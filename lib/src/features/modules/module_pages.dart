import 'package:flutter/material.dart';

import '../../context_extensions.dart';
import '../../shared/widgets.dart';

class PlayersModulePage extends StatelessWidget {
  const PlayersModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ModuleScaffold(
      title: '玩家档案',
      description: '查看玩家状态、身份绑定、钱包和到店记录。',
      icon: Icons.group,
      children: [
        _ActionTile(
          icon: Icons.person_add,
          title: '新建玩家',
          subtitle: '录入显示名后再绑定 QQ、扫码或其他身份。',
        ),
        _ActionTile(
          icon: Icons.account_balance_wallet,
          title: '钱包与资产',
          subtitle: '资产流水独立展示，每次变动都能追到原因。',
        ),
      ],
    );
  }
}

class AssetsModulePage extends StatelessWidget {
  const AssetsModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ModuleScaffold(
      title: '资产、礼包与兑换码',
      description: '用统一的资产模型管理余额、券、礼包和兑换码。',
      icon: Icons.inventory_2,
      children: [
        _ActionTile(
          icon: Icons.card_giftcard,
          title: '礼包',
          subtitle: '配置发放内容、有效期和可见范围。',
        ),
        _ActionTile(
          icon: Icons.qr_code_2,
          title: '兑换码',
          subtitle: '批量生成、撤销和查看兑换记录。',
        ),
      ],
    );
  }
}

class PricingModulePage extends StatefulWidget {
  const PricingModulePage({super.key});

  @override
  State<PricingModulePage> createState() => _PricingModulePageState();
}

class _PricingModulePageState extends State<PricingModulePage> {
  TimeOfDay _start = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _end = const TimeOfDay(hour: 22, minute: 0);
  DateTime _activeDate = DateTime(2026, 7, 4);
  bool _enabled = true;
  int _unitMinutes = 30;
  Set<String> _mode = const {'priority'};

  @override
  Widget build(BuildContext context) {
    return ScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrismPanel(
            title: '计费配置',
            subtitle: '用时间、日期和开关控件描述规则，减少录入错误。',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _pickTime(isStart: true),
                      icon: const Icon(Icons.schedule),
                      label: Text('开始 ${_start.format(context)}'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _pickTime(isStart: false),
                      icon: const Icon(Icons.schedule_send),
                      label: Text('结束 ${_end.format(context)}'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.event),
                      label: Text(
                        '生效日 ${_activeDate.month}/${_activeDate.day}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'priority',
                      label: Text('按时计费'),
                      icon: Icon(Icons.timer),
                    ),
                    ButtonSegment(
                      value: 'fixed',
                      label: Text('固定收费'),
                      icon: Icon(Icons.payments),
                    ),
                  ],
                  selected: _mode,
                  onSelectionChanged: (value) => setState(() => _mode = value),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('启用这条规则'),
                  subtitle: const Text('关闭后保留配置，但不会用于新的计时。'),
                  value: _enabled,
                  onChanged: (value) => setState(() => _enabled = value),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      tooltip: '减少单位时长',
                      onPressed: _unitMinutes <= 5
                          ? null
                          : () => setState(() => _unitMinutes -= 5),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      '每 $_unitMinutes 分钟计费一次',
                      style: context.text.titleSmall,
                    ),
                    IconButton(
                      tooltip: '增加单位时长',
                      onPressed: () => setState(() => _unitMinutes += 5),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime({required bool isStart}) async {
    final result = await showTimePicker(
      context: context,
      initialTime: isStart ? _start : _end,
    );
    if (result == null) return;
    setState(() {
      if (isStart) {
        _start = result;
      } else {
        _end = result;
      }
    });
  }

  Future<void> _pickDate() async {
    final result = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDate: _activeDate,
    );
    if (result != null) setState(() => _activeDate = result);
  }
}

class ServicesModulePage extends StatelessWidget {
  const ServicesModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ModuleScaffold(
      title: '服务项目与订单',
      description: '把饮品、包厢、人工服务等非计时内容单独管理。',
      icon: Icons.room_service,
      children: [
        _ActionTile(
          icon: Icons.add_business,
          title: '服务项目',
          subtitle: '配置可售项目、上架时间和库存。',
        ),
        _ActionTile(
          icon: Icons.fact_check,
          title: '订单处理',
          subtitle: '查看待处理、已完成和取消记录。',
        ),
      ],
    );
  }
}

class DevicesModulePage extends StatelessWidget {
  const DevicesModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ModuleScaffold(
      title: '设备看板',
      description: '查看门禁、电源、投币和扫码终端的状态。',
      icon: Icons.devices,
      children: [
        _ActionTile(
          icon: Icons.power_settings_new,
          title: '电源状态',
          subtitle: '按设备查看在线、离线和最近上报时间。',
        ),
        _ActionTile(
          icon: Icons.history,
          title: '指令记录',
          subtitle: '追踪投币、开门和远程操作是否完成。',
        ),
      ],
    );
  }
}

class ReportsModulePage extends StatelessWidget {
  const ReportsModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ModuleScaffold(
      title: '营业报表',
      description: '核对收入、到店记录、资产扣减和玩家活跃情况。',
      icon: Icons.bar_chart,
      children: [
        _ActionTile(
          icon: Icons.receipt_long,
          title: '结算流水',
          subtitle: '按日筛选每笔结账、调整和扣款。',
        ),
        _ActionTile(
          icon: Icons.leaderboard,
          title: '玩家排行',
          subtitle: '查看到店时长、消费和计时次数。',
        ),
      ],
    );
  }
}

class SystemModulePage extends StatelessWidget {
  const SystemModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ModuleScaffold(
      title: '员工与店铺设置',
      description: '维护店铺设置、员工权限和外部接入密钥。',
      icon: Icons.admin_panel_settings,
      children: [
        _ActionTile(
          icon: Icons.badge,
          title: '员工权限',
          subtitle: '区分店主、店长和只读账号，避免误操作。',
        ),
        _ActionTile(
          icon: Icons.key,
          title: '接入密钥',
          subtitle: '给机器人、设备网关和玩家入口使用。',
        ),
      ],
    );
  }
}

class _ModuleScaffold extends StatelessWidget {
  const _ModuleScaffold({
    required this.title,
    required this.description,
    required this.icon,
    required this.children,
  });

  final String title;
  final String description;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ScreenPadding(
      child: PrismPanel(
        title: title,
        subtitle: description,
        trailing: Icon(icon, color: context.colors.primary),
        child: Wrap(spacing: 12, runSpacing: 12, children: children),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.colors.outlineVariant),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: context.colors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.text.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: context.text.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
