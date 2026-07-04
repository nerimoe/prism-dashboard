import 'package:flutter/material.dart';
import '../context_extensions.dart';

/// 过滤器/操作按钮的一行工具栏容器
class AdminToolbar extends StatelessWidget {
  const AdminToolbar({
    super.key,
    required this.children,
    this.spacing = 12,
  });

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

/// 支持限制数值范围、带“+”和“-”微调按钮的步进数字输入控件
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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(widget.label, style: context.text.bodyMedium),
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
                    : () {
                        widget.onChanged(widget.value - widget.step);
                      },
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  widget.value.toString(),
                  style: context.text.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                icon: const Icon(Icons.add, size: 18),
                onPressed: widget.value >= widget.max
                    ? null
                    : () {
                        widget.onChanged(widget.value + widget.step);
                      },
              ),
            ],
          ),
        ),
      ],
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
    final startText = '${selectedRange.start.year}-${selectedRange.start.month}-${selectedRange.start.day}';
    final endText = '${selectedRange.end.year}-${selectedRange.end.month}-${selectedRange.end.day}';

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
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
        style: context.text.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
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
