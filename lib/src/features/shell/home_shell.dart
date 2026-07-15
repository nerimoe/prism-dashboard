import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/models.dart';
import '../../app_state.dart';
import '../../context_extensions.dart';
import '../operations/operations_screen.dart';
import '../players/players_screen.dart';
import '../assets/assets_screen.dart';
import '../pricing/pricing_screen.dart';
import '../services/services_screen.dart';
import '../devices/devices_screen.dart';
import '../reports/reports_screen.dart';
import '../system/system_screen.dart';

enum DashboardDestination {
  operations(Icons.sensors, '现场工作台', '现场'),
  players(Icons.group, '玩家档案', '玩家'),
  assets(Icons.inventory_2, '资产与礼物', '资产'),
  pricing(Icons.tune, '计费配置', '计费'),
  services(Icons.room_service, '服务项目与订单', '服务'),
  devices(Icons.devices, '设备看板', '设备'),
  reports(Icons.bar_chart, '营业报表', '报表'),
  system(Icons.admin_panel_settings, '员工与系统', '系统');

  const DashboardDestination(this.icon, this.title, this.shortLabel);
  final IconData icon;
  final String title;
  final String shortLabel;
}

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key, required this.appState});

  final AppState appState;

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  DashboardDestination _destination = DashboardDestination.operations;
  String? _targetPlayerId;
  bool _showingSetupTokens = false;

  @override
  Widget build(BuildContext context) {
    if (widget.appState.oneTimeApiTokens.isNotEmpty && !_showingSetupTokens) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showSetupTokens());
    }
    final content = _contentFor(_destination);
    if (context.isCompact) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_destination.title),
          actions: [
            _StaffMenu(staff: widget.appState.staff!, onLogout: _logout),
          ],
        ),
        body: content,
        bottomNavigationBar: NavigationBar(
          selectedIndex: DashboardDestination.values.indexOf(_destination),
          onDestinationSelected: (index) =>
              setState(() => _destination = DashboardDestination.values[index]),
          destinations: [
            for (final item in DashboardDestination.values)
              NavigationDestination(
                icon: Icon(item.icon),
                label: item.shortLabel,
              ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colors.outlineVariant),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _GroupedSidebar(
                selected: _destination,
                onSelected: (value) => setState(() => _destination = value),
                staff: widget.appState.staff!,
                onLogout: _logout,
              ),
              Expanded(child: content),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentFor(DashboardDestination destination) {
    final canWrite = widget.appState.staff?.canWrite ?? false;
    return switch (destination) {
      DashboardDestination.operations => OperationsScreen(canWrite: canWrite),
      DashboardDestination.players => PlayersScreen(
        initialPlayerId: _targetPlayerId,
        canWrite: canWrite,
      ),
      DashboardDestination.assets => AssetsScreen(
        canWrite: canWrite,
        onOpenPlayer: (playerId) => setState(() {
          _targetPlayerId = playerId;
          _destination = DashboardDestination.players;
        }),
      ),
      DashboardDestination.pricing => PricingScreen(canWrite: canWrite),
      DashboardDestination.services => const ServicesScreen(),
      DashboardDestination.devices => DevicesScreen(canWrite: canWrite),
      DashboardDestination.reports => const ReportsScreen(),
      DashboardDestination.system => SystemScreen(
        canWrite: widget.appState.staff?.canWrite,
        role: widget.appState.staff?.role,
      ),
    };
  }

  void _logout() {
    ref.read(appControllerProvider.notifier).logout();
  }

  Future<void> _showSetupTokens() async {
    if (!mounted || _showingSetupTokens) return;
    final tokens = widget.appState.oneTimeApiTokens;
    if (tokens.isEmpty) return;
    setState(() => _showingSetupTokens = true);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('请保存初始化接入密钥'),
        content: SizedBox(
          width: 620,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('完整密钥只会显示这一次。请分别保存机器人入口和机器软件密钥。'),
                const SizedBox(height: 16),
                for (final token in tokens) ...[
                  Text(
                    token.label,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  SelectableText(token.token ?? '密钥内容不可用'),
                  const SizedBox(height: 14),
                ],
              ],
            ),
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('我已保存全部密钥'),
          ),
        ],
      ),
    );
    ref.read(appControllerProvider.notifier).clearOneTimeApiTokens();
    if (mounted) setState(() => _showingSetupTokens = false);
  }
}

class _GroupedSidebar extends StatelessWidget {
  const _GroupedSidebar({
    required this.selected,
    required this.onSelected,
    required this.staff,
    required this.onLogout,
  });

  final DashboardDestination selected;
  final ValueChanged<DashboardDestination> onSelected;
  final CurrentStaff staff;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        border: Border(right: BorderSide(color: context.colors.outlineVariant)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 26, 14, 22),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      'P',
                      style: context.text.titleSmall?.copyWith(
                        color: context.colors.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'prism_dashboard',
                          style: context.text.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '单店运营后台',
                          style: context.text.labelSmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 18),
                children: [
                  _SidebarGroup(
                    label: '现场运营',
                    selected: selected,
                    items: const [
                      _SidebarEntry('现场工作台', DashboardDestination.operations),
                      _SidebarEntry('设备看板', DashboardDestination.devices),
                    ],
                    onSelected: onSelected,
                  ),
                  const _SidebarSeparator(),
                  _SidebarGroup(
                    label: '玩家与资产',
                    selected: selected,
                    items: const [
                      _SidebarEntry('玩家档案', DashboardDestination.players),
                      _SidebarEntry('资产与礼物', DashboardDestination.assets),
                    ],
                    onSelected: onSelected,
                  ),
                  const _SidebarSeparator(),
                  _SidebarGroup(
                    label: '经营配置',
                    selected: selected,
                    items: const [
                      _SidebarEntry('计费配置', DashboardDestination.pricing),
                      _SidebarEntry('服务项目与订单', DashboardDestination.services),
                      _SidebarEntry('营业报表', DashboardDestination.reports),
                    ],
                    onSelected: onSelected,
                  ),
                  const _SidebarSeparator(),
                  _SidebarGroup(
                    label: '系统接入',
                    selected: selected,
                    items: const [
                      _SidebarEntry('员工与系统', DashboardDestination.system),
                    ],
                    onSelected: onSelected,
                  ),
                ],
              ),
            ),
            const _SidebarSeparator(),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: _StaffMenu(staff: staff, onLogout: onLogout),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarEntry {
  const _SidebarEntry(this.label, this.destination);

  final String label;
  final DashboardDestination destination;
}

class _SidebarGroup extends StatelessWidget {
  const _SidebarGroup({
    required this.label,
    required this.selected,
    required this.items,
    required this.onSelected,
  });

  final String label;
  final DashboardDestination selected;
  final List<_SidebarEntry> items;
  final ValueChanged<DashboardDestination> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Text(
            label,
            style: context.text.labelSmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: _SidebarItem(
              item: item,
              selected: selected == item.destination,
              onTap: () => onSelected(item.destination),
            ),
          ),
      ],
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _SidebarEntry item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? context.colors.onPrimaryContainer
        : context.colors.onSurface;
    return Material(
      key: selected ? const ValueKey('sidebar-selected-item') : null,
      color: selected
          ? context.colors.surfaceContainerHigh
          : Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          child: Semantics(
            selected: selected,
            button: true,
            child: Text(
              item.label,
              style: context.text.labelMedium?.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarSeparator extends StatelessWidget {
  const _SidebarSeparator();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 1,
      color: context.colors.outlineVariant,
    );
  }
}

class _StaffMenu extends StatelessWidget {
  const _StaffMenu({required this.staff, required this.onLogout});

  final CurrentStaff staff;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: '账号菜单',
      onSelected: (value) {
        if (value == 'logout') {
          onLogout();
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'logout', child: Text('退出登录')),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16,
            child: Text(
              staff.displayName.isEmpty
                  ? '?'
                  : staff.displayName.substring(0, 1),
            ),
          ),
          const SizedBox(width: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: Text(staff.displayName, overflow: TextOverflow.ellipsis),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
