import 'package:flutter/material.dart';
import '../context_extensions.dart';
import 'widgets.dart';

/// 具有卡片外观的表格容器，支持表格标题、过滤器工具栏、表头、局部 Y 轴滚动、Loading 和 Empty 状态。
class AdminTablePanel extends StatelessWidget {
  const AdminTablePanel({
    super.key,
    required this.title,
    this.subtitle,
    this.toolbar,
    required this.headers,
    required this.itemCount,
    required this.rowBuilder,
    this.isLoading = false,
    this.isEmpty = false,
    this.emptyMessage = '暂无数据记录',
    this.emptyIcon = Icons.inbox,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? toolbar;
  final List<String> headers;
  final int itemCount;
  final Widget Function(BuildContext, int) rowBuilder;
  final bool isLoading;
  final bool isEmpty;
  final String emptyMessage;
  final IconData emptyIcon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.colors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题区
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: context.text.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            if (toolbar != null) ...[const SizedBox(height: 12), toolbar!],
            const SizedBox(height: 16),

            // 表头
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: context.colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  for (final header in headers)
                    Expanded(
                      child: Text(
                        header,
                        style: context.text.labelMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // 表格主体内容（自适应高度与局部滚动）
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 400),
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (isEmpty || itemCount == 0) {
      return EmptyState(icon: emptyIcon, title: '暂无数据', message: emptyMessage);
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) =>
          Divider(height: 1, color: context.colors.outlineVariant),
      itemBuilder: rowBuilder,
    );
  }
}
