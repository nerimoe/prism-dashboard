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
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) setState(() {});
    });
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
              return _AssetsTabContent(
                tabIndex: _tabController.index,
                data: data,
                onArchiveAsset: _archiveAssetDefinition,
                onRestoreAsset: _restoreAssetDefinition,
                onArchivePresent: _archivePresent,
                onRestorePresent: _restorePresent,
                onRevokeCode: _revokeRedeemCode,
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
    final code = TextEditingController();
    final name = TextEditingController();
    var selectedType = 'currency';
    var stackable = true;
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('添加资产'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: selectedType,
                decoration: const InputDecoration(labelText: '资产类别'),
                items: const [
                  DropdownMenuItem(value: 'currency', child: Text('余额资产')),
                  DropdownMenuItem(value: 'ticket', child: Text('券')),
                  DropdownMenuItem(value: 'pass', child: Text('通行权益')),
                  DropdownMenuItem(value: 'benefit', child: Text('店内权益')),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setDialogState(() => selectedType = value);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: code,
                decoration: const InputDecoration(
                  labelText: '店内编号',
                  hintText: '例如 coupon、weekend-pass',
                ),
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
                  selectedType,
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
    final data = await _future;
    final definitions = data.definitions
        .where((definition) => !definition.isArchived)
        .toList();
    if (!mounted) return;
    if (definitions.isEmpty) {
      _done('请先添加一个可用资产，再配置礼包。');
      return;
    }
    final name = TextEditingController();
    final amount = TextEditingController(text: '10');
    var selected = definitions.first;
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('添加礼包'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: '礼包名称'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<AssetDefinition>(
                initialValue: selected,
                decoration: const InputDecoration(labelText: '选择发放资产'),
                items: [
                  for (final definition in definitions)
                    DropdownMenuItem(
                      value: definition,
                      child: Text(
                        '${definition.displayName} · ${_assetKindLabel(definition)}',
                      ),
                    ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setDialogState(() => selected = value);
                },
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
                      'assetType': selected.type,
                      'assetCode': selected.code,
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
      ),
    );
  }

  Future<void> _showCreateRedeemCodeDialog() async {
    final data = await _future;
    final presents = data.presents
        .where((present) => !present.isArchived)
        .toList();
    if (!mounted) return;
    if (presents.isEmpty) {
      _done('请先添加一个可用礼包，再生成兑换码。');
      return;
    }
    final code = TextEditingController();
    final maxUseCount = TextEditingController(text: '1');
    var selected = presents.first;
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('生成兑换码'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: code,
                decoration: const InputDecoration(labelText: '兑换码'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Present>(
                initialValue: selected,
                decoration: const InputDecoration(labelText: '选择礼包'),
                items: [
                  for (final present in presents)
                    DropdownMenuItem(
                      value: present,
                      child: Text(_presentSummary(present)),
                    ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setDialogState(() => selected = value);
                },
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
                  presentId: selected.id,
                  maxUseCount: int.tryParse(maxUseCount.text.trim()) ?? 1,
                );
                _done('兑换码已生成。');
              },
              child: const Text('生成'),
            ),
          ],
        ),
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

class _AssetsTabContent extends StatelessWidget {
  const _AssetsTabContent({
    required this.tabIndex,
    required this.data,
    required this.onArchiveAsset,
    required this.onRestoreAsset,
    required this.onArchivePresent,
    required this.onRestorePresent,
    required this.onRevokeCode,
  });

  final int tabIndex;
  final _AssetsData data;
  final ValueChanged<AssetDefinition> onArchiveAsset;
  final ValueChanged<AssetDefinition> onRestoreAsset;
  final ValueChanged<Present> onArchivePresent;
  final ValueChanged<Present> onRestorePresent;
  final ValueChanged<RedeemCode> onRevokeCode;

  @override
  Widget build(BuildContext context) {
    return switch (tabIndex) {
      0 => _AssetDefinitionsTab(
        definitions: data.definitions,
        onArchive: onArchiveAsset,
        onRestore: onRestoreAsset,
      ),
      1 => _PresentsTab(
        presents: data.presents,
        onArchive: onArchivePresent,
        onRestore: onRestorePresent,
      ),
      _ => _RedeemCodesTab(codes: data.redeemCodes, onRevoke: onRevokeCode),
    };
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
    return Column(
      children: [
        for (var index = 0; index < definitions.length; index++) ...[
          _AssetDefinitionTile(
            definition: definitions[index],
            onArchive: () => onArchive(definitions[index]),
            onRestore: () => onRestore(definitions[index]),
          ),
          if (index != definitions.length - 1) const Divider(height: 1),
        ],
      ],
    );
  }
}

class _AssetDefinitionTile extends StatelessWidget {
  const _AssetDefinitionTile({
    required this.definition,
    required this.onArchive,
    required this.onRestore,
  });

  final AssetDefinition definition;
  final VoidCallback onArchive;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(definition.displayName),
      subtitle: Text(_assetKindLabel(definition)),
      trailing: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ArchiveStatusPill(isArchived: definition.isArchived),
          TextButton(
            onPressed: definition.isArchived ? onRestore : onArchive,
            child: Text(definition.isArchived ? '恢复' : '归档'),
          ),
        ],
      ),
    );
  }
}

String _assetKindLabel(AssetDefinition item) {
  final type = item.type.toLowerCase();
  if (type == 'currency') return '余额资产';
  if (type == 'ticket') return '券';
  if (type == 'pass') return '通行权益';
  return '店内资产';
}

String _presentSummary(Present present) {
  if (present.grants.isEmpty) return present.name;
  final first = present.grants.first;
  return '${present.name} · ${present.grants.length} 项内容 · ${first.amount}';
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
    return Column(
      children: [
        for (var index = 0; index < presents.length; index++) ...[
          _PresentTile(
            present: presents[index],
            onArchive: () => onArchive(presents[index]),
            onRestore: () => onRestore(presents[index]),
          ),
          if (index != presents.length - 1) const Divider(height: 1),
        ],
      ],
    );
  }
}

class _PresentTile extends StatelessWidget {
  const _PresentTile({
    required this.present,
    required this.onArchive,
    required this.onRestore,
  });

  final Present present;
  final VoidCallback onArchive;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(present.name),
      subtitle: Text('${present.grants.length} 项发放内容'),
      trailing: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ArchiveStatusPill(isArchived: present.isArchived),
          TextButton(
            onPressed: present.isArchived ? onRestore : onArchive,
            child: Text(present.isArchived ? '恢复' : '归档'),
          ),
        ],
      ),
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
    return Column(
      children: [
        for (var index = 0; index < codes.length; index++) ...[
          _RedeemCodeTile(
            code: codes[index],
            onRevoke: () => onRevoke(codes[index]),
          ),
          if (index != codes.length - 1) const Divider(height: 1),
        ],
      ],
    );
  }
}

class _RedeemCodeTile extends StatelessWidget {
  const _RedeemCodeTile({required this.code, required this.onRevoke});

  final RedeemCode code;
  final VoidCallback onRevoke;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(code.code),
      subtitle: Text('礼包 ${code.presentId ?? '--'} · 可用 ${code.usageLimit} 次'),
      trailing: TextButton(
        onPressed: code.isRevoked ? null : onRevoke,
        child: Text(code.isRevoked ? '已撤销' : '撤销'),
      ),
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
