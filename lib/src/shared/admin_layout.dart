import 'package:flutter/material.dart';
import '../context_extensions.dart';

class AdminWorkspace extends StatelessWidget {
  const AdminWorkspace({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.isCompact ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.text.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (actions != null)
                Wrap(spacing: 8, runSpacing: 8, children: actions!),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

/// 响应式双栏布局组件，大屏下显示左右分栏，移动端下根据选中状态显示列表或详情。
class AdminSplitPane extends StatelessWidget {
  const AdminSplitPane({
    super.key,
    required this.list,
    this.detail,
    required this.hasSelection,
    this.onBack,
  });

  final Widget list;
  final Widget? detail;
  final bool hasSelection;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    if (context.isCompact) {
      if (hasSelection && detail != null) {
        return PopScope(
          canPop: onBack == null,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (onBack != null) {
              onBack!();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBack,
              ),
              title: const Text('详细信息'),
            ),
            body: detail,
          ),
        );
      }
      return list;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisAlignment = constraints.maxHeight.isFinite
            ? CrossAxisAlignment.stretch
            : CrossAxisAlignment.start;
        return Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Expanded(flex: 3, child: list),
            if (detail != null) ...[
              const SizedBox(width: 16),
              Expanded(flex: 2, child: detail!),
            ],
          ],
        );
      },
    );
  }
}

/// 详情面板容器，大屏下提供精致阴影与背景圆角，并限制其局部滚动。
class AdminDetailPanel extends StatelessWidget {
  const AdminDetailPanel({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final body = SingleChildScrollView(child: child);
            final scrollBody = constraints.maxHeight.isFinite
                ? Flexible(fit: FlexFit.loose, child: body)
                : body;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (actions != null) ...actions!,
                  ],
                ),
                const Divider(height: 24),
                scrollBody,
              ],
            );
          },
        ),
      ),
    );
  }
}

/// 全局表单抽屉弹窗组件，移动端下使用底部滑出 Sheet，宽屏下使用 Dialog 弹窗形式。
class FormSheet extends StatelessWidget {
  const FormSheet({
    super.key,
    required this.title,
    required this.child,
    required this.onConfirm,
    this.confirmLabel = '保存',
    this.cancelLabel = '取消',
  });

  final String title;
  final Widget child;
  final VoidCallback onConfirm;
  final String confirmLabel;
  final String cancelLabel;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required Widget child,
    required VoidCallback onConfirm,
    String confirmLabel = '保存',
  }) {
    if (context.isCompact) {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: context.colors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: FormSheet(
            title: title,
            onConfirm: onConfirm,
            confirmLabel: confirmLabel,
            child: child,
          ),
        ),
      );
    }

    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: FormSheet(
            title: title,
            onConfirm: onConfirm,
            confirmLabel: confirmLabel,
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.text.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(child: SingleChildScrollView(child: child)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(cancelLabel),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                child: Text(confirmLabel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
