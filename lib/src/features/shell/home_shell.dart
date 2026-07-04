import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/models.dart';
import '../../app_state.dart';
import '../../context_extensions.dart';
import '../modules/module_pages.dart';
import '../operations/operations_screen.dart';

enum DashboardDestination {
  operations(Icons.sensors, '现场工作台', '现场'),
  players(Icons.group, '玩家档案', '玩家'),
  assets(Icons.inventory_2, '资产与礼包', '资产'),
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

  @override
  Widget build(BuildContext context) {
    final content = _contentFor(_destination);
    if (context.isCompact) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_destination.title),
          actions: [_StaffMenu(staff: widget.appState.staff!)],
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
              ),
              Expanded(child: content),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentFor(DashboardDestination destination) {
    return switch (destination) {
      DashboardDestination.operations => const OperationsScreen(),
      DashboardDestination.players => const PlayersModulePage(),
      DashboardDestination.assets => const AssetsModulePage(),
      DashboardDestination.pricing => const PricingModulePage(),
      DashboardDestination.services => const ServicesModulePage(),
      DashboardDestination.devices => const DevicesModulePage(),
      DashboardDestination.reports => const ReportsModulePage(),
      DashboardDestination.system => const SystemModulePage(),
    };
  }
}

class _GroupedSidebar extends StatelessWidget {
  const _GroupedSidebar({required this.selected, required this.onSelected});

  final DashboardDestination selected;
  final ValueChanged<DashboardDestination> onSelected;

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
                      _SidebarEntry('玩家档案', DashboardDestination.players),
                      _SidebarEntry('设备管理', DashboardDestination.devices),
                    ],
                    onSelected: onSelected,
                  ),
                  const _SidebarSeparator(),
                  _SidebarGroup(
                    label: '玩家与资产',
                    selected: selected,
                    items: const [
                      _SidebarEntry('玩家资产', DashboardDestination.assets),
                      _SidebarEntry('礼包与兑换码', DashboardDestination.assets),
                    ],
                    onSelected: onSelected,
                  ),
                  const _SidebarSeparator(),
                  _SidebarGroup(
                    label: '经营配置',
                    selected: selected,
                    items: const [
                      _SidebarEntry('按时计费', DashboardDestination.pricing),
                      _SidebarEntry('服务项目', DashboardDestination.services),
                      _SidebarEntry('营业报表', DashboardDestination.reports),
                    ],
                    onSelected: onSelected,
                  ),
                  const _SidebarSeparator(),
                  _SidebarGroup(
                    label: '系统接入',
                    selected: selected,
                    items: const [
                      _SidebarEntry('员工权限', DashboardDestination.system),
                      _SidebarEntry('接入密钥', DashboardDestination.system),
                      _SidebarEntry('店铺设置', DashboardDestination.system),
                    ],
                    onSelected: onSelected,
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
      color: selected
          ? context.colors.surfaceContainerHigh
          : Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          child: Text(
            item.label,
            style: context.text.labelMedium?.copyWith(
              color: color,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
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

class _StaffMenu extends ConsumerWidget {
  const _StaffMenu({required this.staff});

  final CurrentStaff staff;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      tooltip: '账号菜单',
      onSelected: (value) {
        if (value == 'logout') {
          ref.read(appControllerProvider.notifier).logout();
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
