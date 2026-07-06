import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../shared/admin_forms.dart';
import '../../shared/admin_layout.dart';
import '../../shared/time_format.dart';
import '../../shared/widgets.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key, this.api});

  final PrismApiClient? api;

  @override
  ConsumerState<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late Future<_ServicesData> _future;
  String? _message;

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _future = _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminWorkspace(
      title: '服务项目与订单',
      subtitle: '管理报名、饮品、商品和预约等非计时服务，处理现场待出品订单。',
      actions: [
        FilledButton.icon(
          onPressed: _showCreateItemDialog,
          icon: const Icon(Icons.add_business),
          label: const Text('添加服务'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_message != null) ...[
            _MessageBanner(
              message: _message!,
              onClose: () => setState(() => _message = null),
            ),
            const SizedBox(height: 12),
          ],
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: '服务项目'),
              Tab(text: '订单处理'),
            ],
          ),
          const SizedBox(height: 16),
          FutureBuilder<_ServicesData>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return PrismPanel(
                  title: '服务数据没有加载成功',
                  subtitle: snapshot.error.toString(),
                  trailing: IconButton(
                    tooltip: '重试',
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh),
                  ),
                  child: const SizedBox.shrink(),
                );
              }

              final data = snapshot.data ?? _ServicesData.empty();
              return SizedBox(
                height: 560,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _ServiceItemsTab(
                      items: data.items,
                      onArchive: _archiveItem,
                      onRestore: _restoreItem,
                    ),
                    _OrdersTab(
                      orders: data.orders,
                      onFulfill: _confirmFulfillOrder,
                      onCancel: _confirmCancelOrder,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<_ServicesData> _load() async {
    final results = await Future.wait<Object>([
      _api.listBusinessItems(),
      _api.listBusinessItemOrders(),
    ]);
    return _ServicesData(
      items: results[0] as List<BusinessItem>,
      orders: results[1] as List<BusinessItemOrder>,
    );
  }

  void _refresh() {
    setState(() => _future = _load());
  }

  void _done(String message) {
    setState(() {
      _message = message;
      _future = _load();
    });
  }

  Future<void> _showCreateItemDialog() async {
    final name = TextEditingController();
    final assetType = TextEditingController();
    final assetCode = TextEditingController();
    var kind = _serviceKindOptions.first.value;
    var price = 1200;
    DateTime? activeAt;
    DateTime? expiresAt;

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          Future<void> pickDate({
            required DateTime? current,
            required ValueChanged<DateTime?> onPicked,
          }) async {
            final picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2035),
              initialDate: current ?? DateTime.now(),
            );
            if (picked != null) {
              onPicked(DateTime(picked.year, picked.month, picked.day));
            }
          }

          return AlertDialog(
            title: const Text('添加服务'),
            content: SizedBox(
              width: 460,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: kind,
                      decoration: const InputDecoration(labelText: '服务类型'),
                      items: [
                        for (final option in _serviceKindOptions)
                          DropdownMenuItem(
                            value: option.value,
                            child: Text(option.label),
                          ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setDialogState(() => kind = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: name,
                      decoration: const InputDecoration(labelText: '服务名称'),
                    ),
                    const SizedBox(height: 16),
                    StepperNumberField(
                      label: '售价',
                      value: price,
                      min: 0,
                      max: 999999,
                      step: 100,
                      onChanged: (value) => setDialogState(() => price = value),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: assetType,
                      decoration: const InputDecoration(
                        labelText: '发放内容类型',
                        helperText: '可选，购买后自动发放',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: assetCode,
                      decoration: const InputDecoration(
                        labelText: '发放内容编号',
                        helperText: '可选，例如 event.weekend',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => pickDate(
                            current: activeAt,
                            onPicked: (value) =>
                                setDialogState(() => activeAt = value),
                          ),
                          icon: const Icon(Icons.event_available),
                          label: Text(_dateButtonText('开始售卖', activeAt)),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => pickDate(
                            current: expiresAt,
                            onPicked: (value) =>
                                setDialogState(() => expiresAt = value),
                          ),
                          icon: const Icon(Icons.event_busy),
                          label: Text(_dateButtonText('结束售卖', expiresAt)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () async {
                  final trimmedName = name.text.trim();
                  if (trimmedName.isEmpty) return;
                  Navigator.pop(context);
                  await _api.createBusinessItem(
                    name: trimmedName,
                    price: price,
                    kind: kind,
                    assetType: _blankToNull(assetType.text),
                    assetCode: _blankToNull(assetCode.text),
                    activeAt: activeAt,
                    expiresAt: expiresAt,
                    metadata: null,
                  );
                  _done('服务已添加。');
                },
                child: const Text('保存'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _archiveItem(BusinessItem item) async {
    await _api.archiveBusinessItem(item.id);
    _done('${item.name} 已下架。');
  }

  Future<void> _restoreItem(BusinessItem item) async {
    await _api.restoreBusinessItem(item.id);
    _done('${item.name} 已恢复售卖。');
  }

  Future<void> _confirmFulfillOrder(BusinessItemOrder order) {
    return ConfirmActionDialog.show(
      context: context,
      title: '核销订单',
      message: '确认 ${order.itemName} 已交付给玩家 ${order.playerId}？',
      confirmLabel: '核销',
      onConfirm: () async {
        await _api.fulfillBusinessItemOrder(order.id);
        _done('${order.itemName} 已核销。');
      },
    );
  }

  Future<void> _confirmCancelOrder(BusinessItemOrder order) {
    return ConfirmActionDialog.show(
      context: context,
      title: '取消订单',
      message: '只取消这笔订单记录，不会自动退款。需要退款时请另外处理玩家资产。',
      confirmLabel: '取消订单',
      isDestructive: true,
      onConfirm: () async {
        await _api.cancelBusinessItemOrder(order.id);
        _done('${order.itemName} 已取消。');
      },
    );
  }
}

class _ServiceItemsTab extends StatelessWidget {
  const _ServiceItemsTab({
    required this.items,
    required this.onArchive,
    required this.onRestore,
  });

  final List<BusinessItem> items;
  final ValueChanged<BusinessItem> onArchive;
  final ValueChanged<BusinessItem> onRestore;

  @override
  Widget build(BuildContext context) {
    final activeItems = items
        .where((item) => !item.isArchived)
        .toList(growable: false);
    final archivedItems = items
        .where((item) => item.isArchived)
        .toList(growable: false);
    if (items.isEmpty) {
      return const PrismPanel(
        title: '服务项目',
        child: EmptyState(
          icon: Icons.room_service,
          title: '还没有可售服务',
          message: '添加报名、饮品或预约项目后，玩家购买记录会进入订单处理。',
        ),
      );
    }

    return PrismPanel(
      title: '服务项目',
      subtitle: '${activeItems.length} 个在售项目',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (activeItems.isEmpty)
            const EmptyState(
              icon: Icons.room_service,
              title: '暂无在售服务',
              message: '恢复下架项目或添加新服务后，会显示在这里。',
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: activeItems.length,
              separatorBuilder: (_, _) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final item = activeItems[index];
                return _ServiceItemRow(
                  item: item,
                  onArchive: () => onArchive(item),
                  onRestore: () => onRestore(item),
                );
              },
            ),
          if (archivedItems.isNotEmpty) ...[
            const SizedBox(height: 8),
            Material(
              color: Colors.transparent,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(top: 8),
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text('归档服务（${archivedItems.length}）'),
                subtitle: const Text('这些服务不会继续售卖，可从这里恢复。'),
                children: [
                  for (
                    var index = 0;
                    index < archivedItems.length;
                    index++
                  ) ...[
                    _ServiceItemRow(
                      item: archivedItems[index],
                      onArchive: () => onArchive(archivedItems[index]),
                      onRestore: () => onRestore(archivedItems[index]),
                    ),
                    if (index != archivedItems.length - 1)
                      const Divider(height: 24),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ServiceItemRow extends StatelessWidget {
  const _ServiceItemRow({
    required this.item,
    required this.onArchive,
    required this.onRestore,
  });

  final BusinessItem item;
  final VoidCallback onArchive;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                serviceKindLabel(item.kind),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 110, child: MoneyText(value: item.price)),
        SizedBox(
          width: 210,
          child: Text(
            assetLabel(item),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 210, child: Text(activeWindowLabel(item))),
        _ServiceStatusPill(isArchived: item.isArchived),
        item.isArchived
            ? OutlinedButton.icon(
                onPressed: onRestore,
                icon: const Icon(Icons.restore),
                label: const Text('恢复售卖'),
              )
            : OutlinedButton.icon(
                onPressed: onArchive,
                icon: const Icon(Icons.archive_outlined),
                label: const Text('下架'),
              ),
      ],
    );
  }
}

class _OrdersTab extends StatelessWidget {
  const _OrdersTab({
    required this.orders,
    required this.onFulfill,
    required this.onCancel,
  });

  final List<BusinessItemOrder> orders;
  final ValueChanged<BusinessItemOrder> onFulfill;
  final ValueChanged<BusinessItemOrder> onCancel;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const PrismPanel(
        title: '订单处理',
        child: EmptyState(
          icon: Icons.receipt_long,
          title: '暂无待处理订单',
          message: '玩家购买服务后会出现在这里。',
        ),
      );
    }

    return PrismPanel(
      title: '订单处理',
      subtitle: '${orders.length} 笔订单',
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: orders.length,
        separatorBuilder: (_, _) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderRow(
            order: order,
            onFulfill: () => onFulfill(order),
            onCancel: () => onCancel(order),
          );
        },
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  const _OrderRow({
    required this.order,
    required this.onFulfill,
    required this.onCancel,
  });

  final BusinessItemOrder order;
  final VoidCallback onFulfill;
  final VoidCallback onCancel;

  bool get canHandle => order.status == 'paid' || order.status == 'pending';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.itemName,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text('玩家 ${order.playerId}'),
            ],
          ),
        ),
        SizedBox(width: 110, child: MoneyText(value: order.price)),
        _OrderStatePill(status: order.status),
        SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('下单'),
              DateTimeText(value: order.createdAt),
            ],
          ),
        ),
        SizedBox(width: 180, child: Text(completionTimeLabel(order))),
        if (canHandle) ...[
          FilledButton.icon(
            onPressed: onFulfill,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('核销'),
          ),
          OutlinedButton.icon(
            onPressed: onCancel,
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('取消订单'),
          ),
        ],
      ],
    );
  }
}

class _MessageBanner extends StatelessWidget {
  const _MessageBanner({required this.message, required this.onClose});

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: colors.onPrimaryContainer),
            ),
          ),
          IconButton(
            tooltip: '关闭',
            onPressed: onClose,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class _ServiceStatusPill extends StatelessWidget {
  const _ServiceStatusPill({required this.isArchived});

  final bool isArchived;

  @override
  Widget build(BuildContext context) {
    return isArchived
        ? const StatusPill(label: '已下架', color: Colors.orange)
        : const StatusPill(label: '售卖中', color: Colors.green);
  }
}

class _OrderStatePill extends StatelessWidget {
  const _OrderStatePill({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'fulfilled' => const StatusPill(label: '已完成', color: Colors.green),
      'cancelled' => const StatusPill(label: '已取消', color: Colors.red),
      _ => const StatusPill(label: '待出品', color: Colors.orange),
    };
  }
}

class _ServicesData {
  const _ServicesData({required this.items, required this.orders});

  final List<BusinessItem> items;
  final List<BusinessItemOrder> orders;

  factory _ServicesData.empty() => const _ServicesData(items: [], orders: []);
}

class _ServiceKindOption {
  const _ServiceKindOption(this.value, this.label);

  final String value;
  final String label;
}

const _serviceKindOptions = [
  _ServiceKindOption('event.entry', '活动报名'),
  _ServiceKindOption('food.drink', '饮品'),
  _ServiceKindOption('goods', '商品'),
  _ServiceKindOption('booking', '预约'),
  _ServiceKindOption('other', '其他服务'),
];

String serviceKindLabel(String value) {
  for (final option in _serviceKindOptions) {
    if (option.value == value) return option.label;
  }
  return '服务';
}

String assetLabel(BusinessItem item) {
  if (item.assetType == null || item.assetCode == null) {
    return '未绑定资产';
  }
  return '购买后发放：${item.assetType}/${item.assetCode}';
}

String activeWindowLabel(BusinessItem item) {
  if (item.activeAt == null && item.expiresAt == null) return '长期售卖';
  final start = item.activeAt == null ? '不限' : formatAdminDate(item.activeAt);
  final end = item.expiresAt == null ? '不限' : formatAdminDate(item.expiresAt);
  return '$start 至 $end';
}

String completionTimeLabel(BusinessItemOrder order) {
  if (order.fulfilledAt != null) {
    return '完成：${formatAdminDateTime(order.fulfilledAt)}';
  }
  if (order.cancelledAt != null) {
    return '取消：${formatAdminDateTime(order.cancelledAt)}';
  }
  return '等待处理';
}

String _dateButtonText(String label, DateTime? value) {
  if (value == null) return label;
  return '$label ${formatAdminDate(value)}';
}

String? _blankToNull(String value) {
  final trimmed = value.trim();
  return trimmed.isEmpty ? null : trimmed;
}
