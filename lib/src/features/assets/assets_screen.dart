import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../shared/admin_layout.dart';
import '../../shared/widgets.dart';

class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key, this.api});

  final PrismApiClient? api;

  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late Future<_AssetsData> _future;
  String? _message;

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      title: '资产与礼包',
      subtitle: '管理店内余额、券、礼包模板和兑换码。',
      actions: [
        FilledButton.icon(
          onPressed: _showCreateAssetDialog,
          icon: const Icon(Icons.add_card),
          label: const Text('添加资产'),
        ),
        OutlinedButton.icon(
          onPressed: _showCreatePresentDialog,
          icon: const Icon(Icons.card_giftcard),
          label: const Text('添加礼包'),
        ),
        OutlinedButton.icon(
          onPressed: _showCreateRedeemCodeDialog,
          icon: const Icon(Icons.qr_code_2),
          label: const Text('生成兑换码'),
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
              Tab(text: '资产定义'),
              Tab(text: '礼包'),
              Tab(text: '兑换码'),
            ],
          ),
          const SizedBox(height: 16),
          FutureBuilder<_AssetsData>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return PrismPanel(
                  title: '资产数据没有加载成功',
                  subtitle: snapshot.error.toString(),
                  trailing: IconButton(
                    tooltip: '重试',
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh),
                  ),
                  child: const SizedBox.shrink(),
                );
              }

              final data = snapshot.data ?? _AssetsData.empty();
              return SizedBox(
                height: 520,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _AssetDefinitionsTab(
                      definitions: data.definitions,
                      onArchive: _archiveAssetDefinition,
                      onRestore: _restoreAssetDefinition,
                    ),
                    _PresentsTab(
                      presents: data.presents,
                      onArchive: _archivePresent,
                      onRestore: _restorePresent,
                    ),
                    _RedeemCodesTab(
                      codes: data.redeemCodes,
                      onRevoke: _revokeRedeemCode,
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

  Future<_AssetsData> _load() async {
    final results = await Future.wait<Object>([
      _api.listAssetDefinitions(),
      _api.listPresents(),
      _api.listRedeemCodes(),
    ]);
    return _AssetsData(
      definitions: results[0] as List<AssetDefinition>,
      presents: results[1] as List<Present>,
      redeemCodes: results[2] as List<RedeemCode>,
    );
  }

  void _refresh() {
    setState(() => _future = _load());
  }

  Future<void> _showCreateAssetDialog() async {
    final type = TextEditingController(text: 'currency');
    final code = TextEditingController();
    final name = TextEditingController();
    var stackable = true;
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('添加资产'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: type,
                decoration: const InputDecoration(labelText: '资产类型'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: code,
                decoration: const InputDecoration(labelText: '资产代码'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: '显示名称'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('可叠加'),
                value: stackable,
                onChanged: (value) => setDialogState(() => stackable = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.pop(context);
                await _api.saveAssetDefinition(
                  type.text.trim(),
                  code.text.trim(),
                  displayName: name.text.trim(),
                  stackable: stackable,
                );
                _done('资产已保存。');
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCreatePresentDialog() async {
    final name = TextEditingController();
    final assetType = TextEditingController(text: 'currency');
    final assetCode = TextEditingController(text: 'free');
    final amount = TextEditingController(text: '10');
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加礼包'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: '礼包名称'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: assetType,
              decoration: const InputDecoration(labelText: '发放资产类型'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: assetCode,
              decoration: const InputDecoration(labelText: '发放资产代码'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '发放数量'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await _api.createPresent(
                name: name.text.trim(),
                grants: [
                  {
                    'assetType': assetType.text.trim(),
                    'assetCode': assetCode.text.trim(),
                    'amount': num.tryParse(amount.text.trim()) ?? 0,
                    'mergeStrategy': 'stack',
                    'activeAt': null,
                    'expiresAt': null,
                  },
                ],
              );
              _done('礼包已保存。');
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateRedeemCodeDialog() async {
    final code = TextEditingController();
    final presentId = TextEditingController();
    final maxUseCount = TextEditingController(text: '1');
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('生成兑换码'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: code,
              decoration: const InputDecoration(labelText: '兑换码'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: presentId,
              decoration: const InputDecoration(labelText: '选择礼包'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: maxUseCount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '可使用次数'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await _api.createRedeemCode(
                code: code.text.trim(),
                presentId: presentId.text.trim(),
                maxUseCount: int.tryParse(maxUseCount.text.trim()) ?? 1,
              );
              _done('兑换码已生成。');
            },
            child: const Text('生成'),
          ),
        ],
      ),
    );
  }

  Future<void> _archiveAssetDefinition(AssetDefinition definition) async {
    await _api.archiveAssetDefinition(definition.type, definition.code);
    _done('资产已归档。');
  }

  Future<void> _restoreAssetDefinition(AssetDefinition definition) async {
    await _api.restoreAssetDefinition(definition.type, definition.code);
    _done('资产已恢复。');
  }

  Future<void> _archivePresent(Present present) async {
    await _api.archivePresent(present.id);
    _done('礼包已归档。');
  }

  Future<void> _restorePresent(Present present) async {
    await _api.restorePresent(present.id);
    _done('礼包已恢复。');
  }

  Future<void> _revokeRedeemCode(RedeemCode code) async {
    await _api.revokeRedeemCode(code.id);
    _done('兑换码已撤销。');
  }

  void _done(String message) {
    setState(() {
      _message = message;
      _future = _load();
    });
  }
}

class _AssetsData {
  const _AssetsData({
    required this.definitions,
    required this.presents,
    required this.redeemCodes,
  });

  factory _AssetsData.empty() {
    return const _AssetsData(definitions: [], presents: [], redeemCodes: []);
  }

  final List<AssetDefinition> definitions;
  final List<Present> presents;
  final List<RedeemCode> redeemCodes;
}

class _AssetDefinitionsTab extends StatelessWidget {
  const _AssetDefinitionsTab({
    required this.definitions,
    required this.onArchive,
    required this.onRestore,
  });

  final List<AssetDefinition> definitions;
  final ValueChanged<AssetDefinition> onArchive;
  final ValueChanged<AssetDefinition> onRestore;

  @override
  Widget build(BuildContext context) {
    if (definitions.isEmpty) {
      return const EmptyState(
        icon: Icons.inventory_2,
        title: '暂无资产定义',
        message: '添加余额、券或其他店内资产后，会显示在这里。',
      );
    }
    return ListView.separated(
      itemCount: definitions.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = definitions[index];
        return ListTile(
          title: Text(item.displayName),
          subtitle: Text('${item.type}/${item.code}'),
          trailing: Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ArchiveStatusPill(isArchived: item.isArchived),
              TextButton(
                onPressed: () =>
                    item.isArchived ? onRestore(item) : onArchive(item),
                child: Text(item.isArchived ? '恢复' : '归档'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PresentsTab extends StatelessWidget {
  const _PresentsTab({
    required this.presents,
    required this.onArchive,
    required this.onRestore,
  });

  final List<Present> presents;
  final ValueChanged<Present> onArchive;
  final ValueChanged<Present> onRestore;

  @override
  Widget build(BuildContext context) {
    if (presents.isEmpty) {
      return const EmptyState(
        icon: Icons.card_giftcard,
        title: '暂无礼包',
        message: '礼包用于统一配置兑换码发放内容。',
      );
    }
    return ListView.separated(
      itemCount: presents.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = presents[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text('${item.grants.length} 项发放内容'),
          trailing: Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ArchiveStatusPill(isArchived: item.isArchived),
              TextButton(
                onPressed: () =>
                    item.isArchived ? onRestore(item) : onArchive(item),
                child: Text(item.isArchived ? '恢复' : '归档'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RedeemCodesTab extends StatelessWidget {
  const _RedeemCodesTab({required this.codes, required this.onRevoke});

  final List<RedeemCode> codes;
  final ValueChanged<RedeemCode> onRevoke;

  @override
  Widget build(BuildContext context) {
    if (codes.isEmpty) {
      return const EmptyState(
        icon: Icons.qr_code_2,
        title: '暂无兑换码',
        message: '生成单个或批量兑换码后，会显示在这里。',
      );
    }
    return ListView.separated(
      itemCount: codes.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = codes[index];
        return ListTile(
          title: Text(item.code),
          subtitle: Text(
            '礼包 ${item.presentId ?? '--'} · 可用 ${item.usageLimit} 次',
          ),
          trailing: TextButton(
            onPressed: item.isRevoked ? null : () => onRevoke(item),
            child: Text(item.isRevoked ? '已撤销' : '撤销'),
          ),
        );
      },
    );
  }
}

class _MessageBanner extends StatelessWidget {
  const _MessageBanner({required this.message, required this.onClose});

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(child: Text(message)),
            IconButton(
              tooltip: '关闭',
              onPressed: onClose,
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
