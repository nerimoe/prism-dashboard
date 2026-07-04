import 'package:flutter/material.dart';

import '../api/models.dart';
import '../context_extensions.dart';

class ScreenPadding extends StatelessWidget {
  const ScreenPadding({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.isCompact ? 16 : 24),
      child: child,
    );
  }
}

class PrismPanel extends StatelessWidget {
  const PrismPanel({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.text.titleMedium),
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
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.tone,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? tone;

  @override
  Widget build(BuildContext context) {
    final color = tone ?? context.colors.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.text.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(value, style: context.text.titleLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: 0.32)),
      ),
      child: Text(
        label,
        style: context.text.labelSmall?.copyWith(color: color),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });
  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: context.colors.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(title, style: context.text.titleMedium),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String compactId(String id) => id.length <= 8
    ? id
    : '${id.substring(0, 4)}…${id.substring(id.length - 4)}';

class MoneyText extends StatelessWidget {
  const MoneyText({super.key, required this.value, this.style});
  final num? value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    if (value == null) return Text('--', style: style);
    final text = formatMoney(value);
    final isNegative = value! < 0;
    return Text(
      text,
      style:
          style?.copyWith(
            color: isNegative ? context.colors.error : style?.color,
            fontWeight: FontWeight.bold,
          ) ??
          TextStyle(
            color: isNegative ? context.colors.error : context.colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class DateTimeText extends StatelessWidget {
  const DateTimeText({super.key, required this.value, this.style});
  final DateTime? value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    if (value == null) return Text('--', style: style);
    final local = value!.toLocal();
    final year = local.year;
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    final text = '$year-$month-$day $hour:$minute';
    return Text(text, style: style ?? context.text.bodyMedium);
  }
}

class PlayerStatusPill extends StatelessWidget {
  const PlayerStatusPill({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'active' => const StatusPill(label: '可使用', color: Colors.green),
      'banned' => const StatusPill(label: '已封禁', color: Colors.red),
      'disabled' => const StatusPill(label: '已停用', color: Colors.orange),
      _ => const StatusPill(label: '未知', color: Colors.grey),
    };
  }
}

class PresenceStatusPill extends StatelessWidget {
  const PresenceStatusPill({super.key, required this.isPresent});
  final bool isPresent;

  @override
  Widget build(BuildContext context) {
    return isPresent
        ? const StatusPill(label: '在场', color: Colors.green)
        : const StatusPill(label: '离店', color: Colors.grey);
  }
}

class ArchiveStatusPill extends StatelessWidget {
  const ArchiveStatusPill({super.key, required this.isArchived});
  final bool isArchived;

  @override
  Widget build(BuildContext context) {
    return isArchived
        ? const StatusPill(label: '已归档', color: Colors.orange)
        : const StatusPill(label: '正常', color: Colors.green);
  }
}

class OrderStatusPill extends StatelessWidget {
  const OrderStatusPill({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'fulfilled' => const StatusPill(label: '已完成', color: Colors.green),
      'cancelled' => const StatusPill(label: '已取消', color: Colors.red),
      _ => const StatusPill(label: '待处理', color: Colors.orange),
    };
  }
}

class DeviceStatusPill extends StatelessWidget {
  const DeviceStatusPill({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'online' => const StatusPill(label: '在线', color: Colors.green),
      'degraded' => const StatusPill(label: '故障', color: Colors.orange),
      _ => const StatusPill(label: '离线', color: Colors.red),
    };
  }
}

class StaffRolePill extends StatelessWidget {
  const StaffRolePill({super.key, required this.role});
  final StaffRole role;

  @override
  Widget build(BuildContext context) {
    return switch (role) {
      StaffRole.owner => const StatusPill(label: '店主', color: Colors.purple),
      StaffRole.manager => const StatusPill(label: '店长', color: Colors.blue),
      StaffRole.viewer => const StatusPill(label: '店员', color: Colors.grey),
    };
  }
}

class StaffUserStatusPill extends StatelessWidget {
  const StaffUserStatusPill({super.key, required this.isArchived});
  final bool isArchived;

  @override
  Widget build(BuildContext context) {
    return isArchived
        ? const StatusPill(label: '已停用', color: Colors.orange)
        : const StatusPill(label: '可登录', color: Colors.green);
  }
}

class ApiTokenStatusPill extends StatelessWidget {
  const ApiTokenStatusPill({super.key, required this.isRevoked});
  final bool isRevoked;

  @override
  Widget build(BuildContext context) {
    return isRevoked
        ? const StatusPill(label: '已撤销', color: Colors.red)
        : const StatusPill(label: '可使用', color: Colors.green);
  }
}
