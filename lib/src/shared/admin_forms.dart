import 'package:flutter/material.dart';
import '../context_extensions.dart';

/// 过滤器/操作按钮的一行工具栏容器
class AdminToolbar extends StatelessWidget {
  const AdminToolbar({super.key, required this.children, this.spacing = 12});

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }
}

/// 支持直接输入数字，也保留“+”和“-”微调按钮的数值控件
class StepperNumberField extends StatefulWidget {
  const StepperNumberField({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 999999,
    this.step = 1,
    this.label = '',
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final int step;
  final String label;

  @override
  State<StepperNumberField> createState() => _StepperNumberFieldState();
}

class _StepperNumberFieldState extends State<StepperNumberField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
    _focusNode = FocusNode()..addListener(_commitIfBlurred);
  }

  @override
  void didUpdateWidget(StepperNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_focusNode.hasFocus && widget.value.toString() != _controller.text) {
      _controller.text = widget.value.toString();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_commitIfBlurred);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (widget.label.isNotEmpty) ...[
          Expanded(
            child: Text(
              widget.label,
              style: context.text.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: context.colors.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                icon: const Icon(Icons.remove, size: 18),
                onPressed: widget.value <= widget.min
                    ? null
                    : () => _changeByStep(-widget.step),
              ),
              Container(
                width: 72,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  style: context.text.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  onFieldSubmitted: (_) => _commitText(),
                  onEditingComplete: _commitText,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                icon: const Icon(Icons.add, size: 18),
                onPressed: widget.value >= widget.max
                    ? null
                    : () => _changeByStep(widget.step),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _commitIfBlurred() {
    if (!_focusNode.hasFocus) _commitText();
  }

  void _commitText() {
    final parsed = int.tryParse(_controller.text.trim());
    final next = (parsed ?? widget.value).clamp(widget.min, widget.max).toInt();
    _setControllerValue(next);
    if (next != widget.value) widget.onChanged(next);
  }

  void _changeByStep(int delta) {
    final next = (widget.value + delta).clamp(widget.min, widget.max).toInt();
    _setControllerValue(next);
    if (next != widget.value) widget.onChanged(next);
  }

  void _setControllerValue(int value) {
    _controller.text = value.toString();
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
  }
}

/// 支持调出 M3 原生 DateRangePicker 的格式化按钮
class DateRangePickerButton extends StatelessWidget {
  const DateRangePickerButton({
    super.key,
    required this.selectedRange,
    required this.onRangeChanged,
  });

  final DateTimeRange selectedRange;
  final ValueChanged<DateTimeRange> onRangeChanged;

  @override
  Widget build(BuildContext context) {
    final startText =
        '${selectedRange.start.year}-${selectedRange.start.month}-${selectedRange.start.day}';
    final endText =
        '${selectedRange.end.year}-${selectedRange.end.month}-${selectedRange.end.day}';

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      icon: const Icon(Icons.date_range, size: 18),
      label: Text('$startText 至 $endText'),
      onPressed: () async {
        final picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
          initialDateRange: selectedRange,
        );
        if (picked != null) {
          onRangeChanged(picked);
        }
      },
    );
  }
}

/// 统一的二次业务确认对话框，防止重要业务（核销、退款、撤销、归档等）误操作
class ConfirmActionDialog extends StatelessWidget {
  const ConfirmActionDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmLabel = '确认',
    this.cancelLabel = '取消',
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmLabel = '确认',
    bool isDestructive = false,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ConfirmActionDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
        confirmLabel: confirmLabel,
        isDestructive: isDestructive,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Text(message, style: context.text.bodyMedium),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelLabel),
        ),
        FilledButton(
          style: isDestructive
              ? FilledButton.styleFrom(
                  backgroundColor: context.colors.error,
                  foregroundColor: context.colors.onError,
                )
              : null,
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
