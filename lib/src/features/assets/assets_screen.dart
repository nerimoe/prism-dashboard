import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../shared/admin_layout.dart';
import '../../shared/time_format.dart';
import '../../shared/widgets.dart';

final _effectScopeSingle = ['ses', 'sion'].join();
const _newAssetEditorKey = '__new_asset__';

enum _AssetWorkspaceAction { pricingEffect, present, redeemCode }

class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key, this.api, this.onOpenPlayer});

  final PrismApiClient? api;
  final ValueChanged<String>? onOpenPlayer;

  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late Future<_AssetsData> _future;
  String? _message;
  String? _assetEditorKey;
  _AssetWorkspaceAction? _workspaceAction;
  int _activeTabIndex = 0;

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      animationDuration: Duration.zero,
    );
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
      title: '资产与礼物',
      subtitle: '管理店内余额、券、礼物模板和兑换码。',
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
            onTap: _selectTab,
            tabs: const [
              Tab(text: '资产定义'),
              Tab(text: '计费效果'),
              Tab(text: '礼物'),
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
              final action = _workspaceActionMatchesTab()
                  ? _workspaceAction
                  : null;
              final actionPanel = action == null
                  ? null
                  : _ActionWorkspacePanel(
                      action: action,
                      data: data,
                      onClose: () => setState(() => _workspaceAction = null),
                      onCreatePresent: _createPresent,
                      onCreateRedeemCode: _createRedeemCode,
                      onCreateRedeemCodeBatch: _createRedeemCodeBatch,
                      onSavePricingEffect: _savePricingEffect,
                    );
              final content = _AssetsTabContent(
                tabIndex: _activeTabIndex,
                data: data,
                onArchiveAsset: _archiveAssetDefinition,
                onRestoreAsset: _restoreAssetDefinition,
                onSaveAsset: _saveAssetDefinition,
                onCreateAsset: _openNewAssetEditor,
                onCreatePricingEffect: _openPricingEffectEditor,
                assetEditorKey: _assetEditorKey,
                onSelectAsset: (definition) => setState(
                  () => _assetEditorKey = _assetDefinitionKey(definition),
                ),
                onCreatePresent: _openCreatePresentEditor,
                onArchivePresent: _archivePresent,
                onRestorePresent: _restorePresent,
                onCreateRedeemCode: _openRedeemCodeGenerator,
                onRevokeCode: _revokeRedeemCode,
                onOpenPlayer: widget.onOpenPlayer,
              );
              if (actionPanel == null) return content;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [actionPanel, const SizedBox(height: 16), content],
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
      _api.listPricingEffects(),
      _api.listPricingConfigs(),
      _api.listPresents(),
      _api.listRedeemCodes(),
    ]);
    return _AssetsData(
      definitions: results[0] as List<AssetDefinition>,
      pricingEffects: results[1] as List<PricingEffect>,
      pricingConfigs: results[2] as List<PricingConfig>,
      presents: results[3] as List<Present>,
      redeemCodes: results[4] as List<RedeemCode>,
    );
  }

  void _refresh() {
    setState(() => _future = _load());
  }

  void _openNewAssetEditor() {
    _selectTab(0);
    setState(() {
      _workspaceAction = null;
      _assetEditorKey = _newAssetEditorKey;
    });
  }

  void _openPricingEffectEditor() {
    _selectTab(1);
    setState(() {
      _workspaceAction = _AssetWorkspaceAction.pricingEffect;
    });
  }

  void _openCreatePresentEditor() {
    _selectTab(2);
    setState(() {
      _workspaceAction = _AssetWorkspaceAction.present;
    });
  }

  void _openRedeemCodeGenerator() {
    _selectTab(3);
    setState(() {
      _workspaceAction = _AssetWorkspaceAction.redeemCode;
    });
  }

  void _selectTab(int index) {
    if (_activeTabIndex == index && _tabController.index == index) return;
    setState(() => _activeTabIndex = index);
    if (_tabController.index == index) return;
    _tabController.animateTo(index, duration: Duration.zero);
  }

  bool _workspaceActionMatchesTab() {
    return switch (_workspaceAction) {
      _AssetWorkspaceAction.pricingEffect => _activeTabIndex == 1,
      _AssetWorkspaceAction.present => _activeTabIndex == 2,
      _AssetWorkspaceAction.redeemCode => _activeTabIndex == 3,
      null => false,
    };
  }

  Future<void> _createPresent(_CreatePresentDraft draft) async {
    await _api.createPresent(
      name: draft.name.trim(),
      activeAt: draft.activeAt?.toIso8601String(),
      expiresAt: draft.expiresAt?.toIso8601String(),
      grants: draft.grants.map((grant) => grant.toJson()).toList(),
    );
    _done('礼物已保存。');
  }

  Future<void> _createRedeemCode(_CreateRedeemCodeDraft draft) async {
    await _api.createRedeemCode(
      code: draft.code.trim(),
      presentId: draft.present.id,
      maxUseCount: draft.maxUseCount,
      activeAt: draft.activeAt?.toIso8601String(),
      expiresAt: draft.expiresAt?.toIso8601String(),
    );
    _done('兑换码已生成。');
  }

  Future<void> _createRedeemCodeBatch(_CreateRedeemCodeDraft draft) async {
    await _api.createRedeemCodeBatch(
      count: draft.count,
      prefix: draft.prefix.trim(),
      presentId: draft.present.id,
      maxUseCount: draft.maxUseCount,
      activeAt: draft.activeAt?.toIso8601String(),
      expiresAt: draft.expiresAt?.toIso8601String(),
    );
    _done('兑换码已批量生成。');
  }

  Future<void> _savePricingEffect(_PricingEffectDraft draft) async {
    await _api.savePricingEffect(
      draft.id.trim(),
      name: draft.name.trim(),
      type: draft.type,
      scope: draft.scope,
      value: draft.type == 'free' ? null : draft.value,
      consumable: draft.consumable,
      limitPerDay: draft.limitPerDay,
      activeAt: draft.activeAt?.toIso8601String(),
      expiresAt: draft.expiresAt?.toIso8601String(),
      config: _pricingEffectConfig(
        sessionLabels: draft.sessionLabels,
        pricingConfigIds: draft.pricingConfigIds,
        ruleIds: draft.ruleIds,
      ),
    );
    _done('计费效果已保存。');
  }

  Future<void> _archiveAssetDefinition(AssetDefinition definition) async {
    await _api.archiveAssetDefinition(definition.type, definition.code);
    _done('资产已归档。');
  }

  Future<void> _restoreAssetDefinition(AssetDefinition definition) async {
    await _api.restoreAssetDefinition(definition.type, definition.code);
    _done('资产已恢复。');
  }

  Future<void> _saveAssetDefinition(_AssetDefinitionDraft draft) async {
    await _api.saveAssetDefinition(
      draft.type,
      draft.code,
      displayName: draft.displayName,
      stackable: draft.stackable,
      pricingEffectId: draft.pricingEffectId,
      activeAt: draft.activeAt?.toIso8601String(),
      expiresAt: draft.expiresAt?.toIso8601String(),
    );
    _done('资产已保存。');
  }

  Future<void> _archivePresent(Present present) async {
    await _api.archivePresent(present.id);
    _done('礼物已归档。');
  }

  Future<void> _restorePresent(Present present) async {
    await _api.restorePresent(present.id);
    _done('礼物已恢复。');
  }

  Future<void> _revokeRedeemCode(RedeemCode code) async {
    await _api.revokeRedeemCode(code.id);
    _done('兑换码已撤销。');
  }

  void _done(String message) {
    setState(() {
      _message = message;
      _workspaceAction = null;
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
    required this.onSaveAsset,
    required this.onCreateAsset,
    required this.onCreatePricingEffect,
    required this.assetEditorKey,
    required this.onSelectAsset,
    required this.onCreatePresent,
    required this.onArchivePresent,
    required this.onRestorePresent,
    required this.onCreateRedeemCode,
    required this.onRevokeCode,
    required this.onOpenPlayer,
  });

  final int tabIndex;
  final _AssetsData data;
  final ValueChanged<AssetDefinition> onArchiveAsset;
  final ValueChanged<AssetDefinition> onRestoreAsset;
  final ValueChanged<_AssetDefinitionDraft> onSaveAsset;
  final VoidCallback onCreateAsset;
  final VoidCallback onCreatePricingEffect;
  final String? assetEditorKey;
  final ValueChanged<AssetDefinition> onSelectAsset;
  final VoidCallback onCreatePresent;
  final ValueChanged<Present> onArchivePresent;
  final ValueChanged<Present> onRestorePresent;
  final VoidCallback onCreateRedeemCode;
  final ValueChanged<RedeemCode> onRevokeCode;
  final ValueChanged<String>? onOpenPlayer;

  @override
  Widget build(BuildContext context) {
    return switch (tabIndex) {
      0 => _AssetDefinitionsTab(
        definitions: data.definitions,
        pricingEffects: data.pricingEffects,
        editorKey: assetEditorKey,
        onCreate: onCreateAsset,
        onSelect: onSelectAsset,
        onSave: onSaveAsset,
        onArchive: onArchiveAsset,
        onRestore: onRestoreAsset,
      ),
      1 => _PricingEffectsTab(
        effects: data.pricingEffects,
        onCreate: onCreatePricingEffect,
      ),
      2 => _PresentsTab(
        presents: data.presents,
        definitions: data.definitions,
        redeemCodes: data.redeemCodes,
        onCreate: onCreatePresent,
        onArchive: onArchivePresent,
        onRestore: onRestorePresent,
      ),
      _ => _RedeemCodesTab(
        codes: data.redeemCodes,
        presents: data.presents,
        onCreate: onCreateRedeemCode,
        onRevoke: onRevokeCode,
        onOpenPlayer: onOpenPlayer,
      ),
    };
  }
}

class _ActionWorkspacePanel extends StatelessWidget {
  const _ActionWorkspacePanel({
    required this.action,
    required this.data,
    required this.onClose,
    required this.onCreatePresent,
    required this.onCreateRedeemCode,
    required this.onCreateRedeemCodeBatch,
    required this.onSavePricingEffect,
  });

  final _AssetWorkspaceAction action;
  final _AssetsData data;
  final VoidCallback onClose;
  final ValueChanged<_CreatePresentDraft> onCreatePresent;
  final ValueChanged<_CreateRedeemCodeDraft> onCreateRedeemCode;
  final ValueChanged<_CreateRedeemCodeDraft> onCreateRedeemCodeBatch;
  final ValueChanged<_PricingEffectDraft> onSavePricingEffect;

  @override
  Widget build(BuildContext context) {
    return switch (action) {
      _AssetWorkspaceAction.present => _CreatePresentPanel(
        definitions: data.definitions
            .where((definition) => !definition.isArchived)
            .toList(growable: false),
        onClose: onClose,
        onSubmit: onCreatePresent,
      ),
      _AssetWorkspaceAction.redeemCode => _CreateRedeemCodePanel(
        presents: data.presents
            .where((present) => !present.isArchived)
            .toList(growable: false),
        onClose: onClose,
        onCreate: onCreateRedeemCode,
        onCreateBatch: onCreateRedeemCodeBatch,
      ),
      _AssetWorkspaceAction.pricingEffect => _PricingEffectPanel(
        pricingConfigs: data.pricingConfigs,
        onClose: onClose,
        onSubmit: onSavePricingEffect,
      ),
    };
  }
}

class _CreatePresentDraft {
  const _CreatePresentDraft({
    required this.name,
    required this.grants,
    required this.activeAt,
    required this.expiresAt,
  });

  final String name;
  final List<_GrantDraft> grants;
  final DateTime? activeAt;
  final DateTime? expiresAt;
}

class _CreateRedeemCodeDraft {
  const _CreateRedeemCodeDraft({
    required this.present,
    required this.code,
    required this.prefix,
    required this.count,
    required this.maxUseCount,
    required this.activeAt,
    required this.expiresAt,
  });

  final Present present;
  final String code;
  final String prefix;
  final int count;
  final int maxUseCount;
  final DateTime? activeAt;
  final DateTime? expiresAt;
}

class _PricingEffectDraft {
  const _PricingEffectDraft({
    required this.id,
    required this.name,
    required this.type,
    required this.scope,
    required this.value,
    required this.consumable,
    required this.limitPerDay,
    required this.sessionLabels,
    required this.pricingConfigIds,
    required this.ruleIds,
    required this.activeAt,
    required this.expiresAt,
  });

  final String id;
  final String name;
  final String type;
  final String scope;
  final num? value;
  final bool consumable;
  final int? limitPerDay;
  final String sessionLabels;
  final Set<String> pricingConfigIds;
  final Set<String> ruleIds;
  final DateTime? activeAt;
  final DateTime? expiresAt;
}

class _AssetsData {
  const _AssetsData({
    required this.definitions,
    required this.pricingEffects,
    required this.pricingConfigs,
    required this.presents,
    required this.redeemCodes,
  });

  factory _AssetsData.empty() {
    return const _AssetsData(
      definitions: [],
      pricingEffects: [],
      pricingConfigs: [],
      presents: [],
      redeemCodes: [],
    );
  }

  final List<AssetDefinition> definitions;
  final List<PricingEffect> pricingEffects;
  final List<PricingConfig> pricingConfigs;
  final List<Present> presents;
  final List<RedeemCode> redeemCodes;
}

class _GrantDraft {
  _GrantDraft(this.definition);

  AssetDefinition definition;
  final amount = TextEditingController(text: '1');
  String mergeStrategy = 'stack';
  DateTime? activeAt;
  DateTime? expiresAt;

  Map<String, dynamic> toJson() => {
    'assetType': definition.type,
    'assetCode': definition.code,
    'amount': num.tryParse(amount.text.trim()) ?? 0,
    'mergeStrategy': mergeStrategy,
    'activeAt': activeAt?.toIso8601String(),
    'expiresAt': expiresAt?.toIso8601String(),
  };
}

class _GrantEditor extends StatelessWidget {
  const _GrantEditor({
    required this.draft,
    required this.definitions,
    required this.onChanged,
    required this.onRemove,
  });

  final _GrantDraft draft;
  final List<AssetDefinition> definitions;
  final VoidCallback onChanged;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '礼物内容',
      trailing: IconButton(
        tooltip: '移除',
        onPressed: onRemove,
        icon: const Icon(Icons.close),
      ),
      child: Column(
        children: [
          DropdownButtonFormField<AssetDefinition>(
            initialValue: draft.definition,
            decoration: const InputDecoration(labelText: '发放资产'),
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
              draft.definition = value;
              onChanged();
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: draft.amount,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: '数量'),
            onChanged: (_) => onChanged(),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: draft.mergeStrategy,
            decoration: const InputDecoration(labelText: '到账方式'),
            items: const [
              DropdownMenuItem(value: 'stack', child: Text('叠加数量')),
              DropdownMenuItem(value: 'replace', child: Text('替换现有')),
              DropdownMenuItem(value: 'extend-time', child: Text('延长有效期')),
            ],
            onChanged: (value) {
              if (value == null) return;
              draft.mergeStrategy = value;
              onChanged();
            },
          ),
          const SizedBox(height: 12),
          _DateTimeField(
            label: '内容开始生效',
            value: draft.activeAt,
            onChanged: (value) {
              draft.activeAt = value;
              onChanged();
            },
          ),
          const SizedBox(height: 8),
          _DateTimeField(
            label: '内容过期时间',
            value: draft.expiresAt,
            onChanged: (value) {
              draft.expiresAt = value;
              onChanged();
            },
          ),
        ],
      ),
    );
  }
}

class _DateTimeField extends StatelessWidget {
  const _DateTimeField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(labelText: label),
      child: Row(
        children: [
          Expanded(
            child: Text(value == null ? '不限时间' : formatAdminDateTime(value)),
          ),
          TextButton(
            onPressed: () async {
              final picked = await _pickDateTime(context, value);
              if (picked != null) onChanged(picked);
            },
            child: const Text('选择'),
          ),
          if (value != null)
            IconButton(
              tooltip: '清除',
              onPressed: () => onChanged(null),
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }
}

Future<DateTime?> _pickDateTime(BuildContext context, DateTime? initial) async {
  final now = DateTime.now();
  final base = initial ?? now;
  final date = await showDatePicker(
    context: context,
    initialDate: base,
    firstDate: DateTime(now.year - 2),
    lastDate: DateTime(now.year + 5),
  );
  if (date == null || !context.mounted) return null;
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(base),
  );
  if (time == null) return null;
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

class _AssetDefinitionsTab extends StatelessWidget {
  const _AssetDefinitionsTab({
    required this.definitions,
    required this.pricingEffects,
    required this.editorKey,
    required this.onCreate,
    required this.onSelect,
    required this.onSave,
    required this.onArchive,
    required this.onRestore,
  });

  final List<AssetDefinition> definitions;
  final List<PricingEffect> pricingEffects;
  final String? editorKey;
  final VoidCallback onCreate;
  final ValueChanged<AssetDefinition> onSelect;
  final ValueChanged<_AssetDefinitionDraft> onSave;
  final ValueChanged<AssetDefinition> onArchive;
  final ValueChanged<AssetDefinition> onRestore;

  @override
  Widget build(BuildContext context) {
    final activeDefinitions = definitions
        .where((definition) => !definition.isArchived)
        .toList(growable: false);
    final archivedDefinitions = definitions
        .where((definition) => definition.isArchived)
        .toList(growable: false);
    if (definitions.isEmpty) {
      return const EmptyState(
        icon: Icons.inventory_2,
        title: '暂无资产定义',
        message: '添加余额、券或其他店内资产后，会显示在这里。',
      );
    }
    final selectedDefinition = _selectedAssetDefinition(definitions, editorKey);
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 900;
        final list = _AssetDefinitionList(
          activeDefinitions: activeDefinitions,
          archivedDefinitions: archivedDefinitions,
          selectedKey: editorKey ?? _assetDefinitionKey(selectedDefinition),
          onCreate: onCreate,
          onSelect: onSelect,
          onArchive: onArchive,
          onRestore: onRestore,
        );
        final editor = _AssetDefinitionEditor(
          key: ValueKey(editorKey ?? _assetDefinitionKey(selectedDefinition)),
          definition: editorKey == _newAssetEditorKey
              ? null
              : selectedDefinition,
          pricingEffects: pricingEffects,
          onSave: onSave,
          onArchive: selectedDefinition == null
              ? null
              : () => onArchive(selectedDefinition),
          onRestore: selectedDefinition == null
              ? null
              : () => onRestore(selectedDefinition),
        );
        if (stacked) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [list, const SizedBox(height: 16), editor],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: list),
            const SizedBox(width: 24),
            SizedBox(width: 420, child: editor),
          ],
        );
      },
    );
  }
}

class _AssetDefinitionList extends StatelessWidget {
  const _AssetDefinitionList({
    required this.activeDefinitions,
    required this.archivedDefinitions,
    required this.selectedKey,
    required this.onCreate,
    required this.onSelect,
    required this.onArchive,
    required this.onRestore,
  });

  final List<AssetDefinition> activeDefinitions;
  final List<AssetDefinition> archivedDefinitions;
  final String selectedKey;
  final VoidCallback onCreate;
  final ValueChanged<AssetDefinition> onSelect;
  final ValueChanged<AssetDefinition> onArchive;
  final ValueChanged<AssetDefinition> onRestore;

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '资产定义',
      subtitle: '点击资产查看详情，也可以在右侧直接修改配置。',
      trailing: FilledButton.icon(
        onPressed: onCreate,
        icon: const Icon(Icons.add_card),
        label: const Text('添加资产'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (activeDefinitions.isEmpty)
            const EmptyState(
              icon: Icons.inventory_2,
              title: '暂无可用资产',
              message: '恢复归档资产或添加新资产后，会显示在这里。',
            )
          else
            for (var index = 0; index < activeDefinitions.length; index++) ...[
              _AssetDefinitionTile(
                definition: activeDefinitions[index],
                selected:
                    selectedKey ==
                    _assetDefinitionKey(activeDefinitions[index]),
                onTap: () => onSelect(activeDefinitions[index]),
                onArchive: () => onArchive(activeDefinitions[index]),
                onRestore: () => onRestore(activeDefinitions[index]),
              ),
              if (index != activeDefinitions.length - 1)
                const Divider(height: 1),
            ],
          if (archivedDefinitions.isNotEmpty) ...[
            const SizedBox(height: 8),
            Material(
              color: Colors.transparent,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text('归档资产（${archivedDefinitions.length}）'),
                subtitle: const Text('这些资产不会用于新的发放或礼物配置。'),
                children: [
                  for (
                    var index = 0;
                    index < archivedDefinitions.length;
                    index++
                  )
                    _AssetDefinitionTile(
                      definition: archivedDefinitions[index],
                      selected:
                          selectedKey ==
                          _assetDefinitionKey(archivedDefinitions[index]),
                      onTap: () => onSelect(archivedDefinitions[index]),
                      onArchive: () => onArchive(archivedDefinitions[index]),
                      onRestore: () => onRestore(archivedDefinitions[index]),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AssetDefinitionTile extends StatelessWidget {
  const _AssetDefinitionTile({
    required this.definition,
    required this.selected,
    required this.onTap,
    required this.onArchive,
    required this.onRestore,
  });

  final AssetDefinition definition;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onArchive;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
      title: Text(definition.displayName),
      subtitle: Text(
        [
          _assetKindLabel(definition),
          if (definition.pricingEffect != null) definition.pricingEffect!.name,
          _windowLabel(definition.activeAt, definition.expiresAt),
        ].where((item) => item.isNotEmpty).join(' · '),
      ),
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

class _PricingEffectsTab extends StatelessWidget {
  const _PricingEffectsTab({required this.effects, required this.onCreate});

  final List<PricingEffect> effects;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final activeEffects = effects
        .where((effect) => !effect.isArchived)
        .toList(growable: false);
    final archivedEffects = effects
        .where((effect) => effect.isArchived)
        .toList(growable: false);
    return PrismPanel(
      title: '计费效果',
      subtitle: '先配置可复用的结算影响，再绑定到资产定义上。',
      trailing: FilledButton.icon(
        onPressed: onCreate,
        icon: const Icon(Icons.price_change_outlined),
        label: const Text('添加计费效果'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (activeEffects.isEmpty)
            const EmptyState(
              icon: Icons.receipt_long_outlined,
              title: '暂无计费效果',
              message: '月卡、抵扣券、折扣券等结算影响会显示在这里。',
            )
          else
            for (var index = 0; index < activeEffects.length; index++) ...[
              _PricingEffectTile(effect: activeEffects[index]),
              if (index != activeEffects.length - 1) const Divider(height: 1),
            ],
          if (archivedEffects.isNotEmpty) ...[
            const SizedBox(height: 8),
            Material(
              color: Colors.transparent,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                leading: const Icon(Icons.archive_outlined),
                title: Text('归档计费效果（${archivedEffects.length}）'),
                subtitle: const Text('这些效果不会绑定到新的资产上。'),
                children: [
                  for (final effect in archivedEffects)
                    _PricingEffectTile(effect: effect),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PricingEffectTile extends StatelessWidget {
  const _PricingEffectTile({required this.effect});

  final PricingEffect effect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.receipt_long_outlined),
      title: Text(effect.name),
      subtitle: Text(
        [
          _pricingEffectKind(effect),
          if (effect.limitPerDay != null) '每日最多 ${effect.limitPerDay} 次',
          _windowLabel(effect.activeAt, effect.expiresAt),
        ].where((item) => item.isNotEmpty).join(' · '),
      ),
      trailing: ArchiveStatusPill(isArchived: effect.isArchived),
    );
  }
}

class _CreatePresentPanel extends StatefulWidget {
  const _CreatePresentPanel({
    required this.definitions,
    required this.onClose,
    required this.onSubmit,
  });

  final List<AssetDefinition> definitions;
  final VoidCallback onClose;
  final ValueChanged<_CreatePresentDraft> onSubmit;

  @override
  State<_CreatePresentPanel> createState() => _CreatePresentPanelState();
}

class _CreatePresentPanelState extends State<_CreatePresentPanel> {
  final _name = TextEditingController();
  late final List<_GrantDraft> _grants;
  DateTime? _activeAt;
  DateTime? _expiresAt;

  @override
  void initState() {
    super.initState();
    _grants = widget.definitions.isEmpty
        ? <_GrantDraft>[]
        : <_GrantDraft>[_GrantDraft(widget.definitions.first)];
  }

  @override
  void dispose() {
    _name.dispose();
    for (final grant in _grants) {
      grant.amount.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '新礼物草稿',
      subtitle: '配置礼物内容、可用时间和到账方式。',
      trailing: IconButton(
        tooltip: '关闭',
        onPressed: widget.onClose,
        icon: const Icon(Icons.close),
      ),
      child: widget.definitions.isEmpty
          ? const EmptyState(
              icon: Icons.inventory_2,
              title: '还没有可用资产',
              message: '先添加资产，再创建礼物。',
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _WorkspaceGrid(
                  children: [
                    _WorkspaceSection(
                      title: '基础信息',
                      subtitle: '给店员和兑换码列表看的礼物名称。',
                      children: [
                        TextField(
                          controller: _name,
                          decoration: const InputDecoration(labelText: '礼物名称'),
                        ),
                      ],
                    ),
                    _WorkspaceSection(
                      title: '可兑换时间',
                      subtitle: '礼物过期后，即使兑换码没过期也不能兑换。',
                      children: [
                        _DateTimeField(
                          label: '礼物开始生效',
                          value: _activeAt,
                          onChanged: (value) =>
                              setState(() => _activeAt = value),
                        ),
                        _DateTimeField(
                          label: '礼物过期时间',
                          value: _expiresAt,
                          onChanged: (value) =>
                              setState(() => _expiresAt = value),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text('包含内容', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                for (var index = 0; index < _grants.length; index++) ...[
                  _GrantEditor(
                    draft: _grants[index],
                    definitions: widget.definitions,
                    onChanged: () => setState(() {}),
                    onRemove: _grants.length == 1
                        ? null
                        : () => setState(() => _grants.removeAt(index)),
                  ),
                  const SizedBox(height: 12),
                ],
                OutlinedButton.icon(
                  onPressed: () => setState(
                    () => _grants.add(_GrantDraft(widget.definitions.first)),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('添加内容'),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: () => widget.onSubmit(
                      _CreatePresentDraft(
                        name: _name.text,
                        grants: List<_GrantDraft>.from(_grants),
                        activeAt: _activeAt,
                        expiresAt: _expiresAt,
                      ),
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text('保存'),
                  ),
                ),
              ],
            ),
    );
  }
}

class _CreateRedeemCodePanel extends StatefulWidget {
  const _CreateRedeemCodePanel({
    required this.presents,
    required this.onClose,
    required this.onCreate,
    required this.onCreateBatch,
  });

  final List<Present> presents;
  final VoidCallback onClose;
  final ValueChanged<_CreateRedeemCodeDraft> onCreate;
  final ValueChanged<_CreateRedeemCodeDraft> onCreateBatch;

  @override
  State<_CreateRedeemCodePanel> createState() => _CreateRedeemCodePanelState();
}

class _CreateRedeemCodePanelState extends State<_CreateRedeemCodePanel> {
  final _code = TextEditingController();
  final _prefix = TextEditingController(text: 'CDK');
  final _count = TextEditingController(text: '100');
  final _maxUseCount = TextEditingController(text: '1');
  Present? _present;
  bool _batch = false;
  DateTime? _activeAt;
  DateTime? _expiresAt;

  @override
  void initState() {
    super.initState();
    _present = widget.presents.isEmpty ? null : widget.presents.first;
  }

  @override
  void dispose() {
    _code.dispose();
    _prefix.dispose();
    _count.dispose();
    _maxUseCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final present = _present;
    return PrismPanel(
      title: '兑换码生成台',
      subtitle: '选择礼物后生成单个兑换码或批量兑换码。',
      trailing: IconButton(
        tooltip: '关闭',
        onPressed: widget.onClose,
        icon: const Icon(Icons.close),
      ),
      child: widget.presents.isEmpty
          ? const EmptyState(
              icon: Icons.card_giftcard,
              title: '还没有可用礼物',
              message: '先新建礼物，再生成兑换码。',
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _WorkspaceGrid(
                  children: [
                    _WorkspaceSection(
                      title: '生成方式',
                      subtitle: '少量补码用单个，大批活动码用批量生成。',
                      children: [
                        SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(value: false, label: Text('单个兑换码')),
                            ButtonSegment(value: true, label: Text('批量生成')),
                          ],
                          selected: {_batch},
                          onSelectionChanged: (value) =>
                              setState(() => _batch = value.first),
                        ),
                        if (_batch) ...[
                          TextField(
                            controller: _prefix,
                            decoration: const InputDecoration(
                              labelText: '兑换码前缀',
                            ),
                          ),
                          TextField(
                            controller: _count,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: '生成数量',
                            ),
                          ),
                        ] else
                          TextField(
                            controller: _code,
                            decoration: const InputDecoration(labelText: '兑换码'),
                          ),
                        TextField(
                          controller: _maxUseCount,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: '可使用次数'),
                        ),
                      ],
                    ),
                    _WorkspaceSection(
                      title: '绑定礼物',
                      subtitle: '兑换成功后会按礼物内容发放资产。',
                      children: [
                        DropdownButtonFormField<Present>(
                          initialValue: present,
                          decoration: const InputDecoration(labelText: '选择礼物'),
                          items: [
                            for (final item in widget.presents)
                              DropdownMenuItem(
                                value: item,
                                child: Text(_presentSummary(item)),
                              ),
                          ],
                          onChanged: (value) =>
                              setState(() => _present = value),
                        ),
                      ],
                    ),
                    _WorkspaceSection(
                      title: '可使用时间',
                      subtitle: '兑换码和礼物任意一方过期，都不能兑换。',
                      children: [
                        _DateTimeField(
                          label: '兑换码开始生效',
                          value: _activeAt,
                          onChanged: (value) =>
                              setState(() => _activeAt = value),
                        ),
                        _DateTimeField(
                          label: '兑换码过期时间',
                          value: _expiresAt,
                          onChanged: (value) =>
                              setState(() => _expiresAt = value),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: present == null
                        ? null
                        : () {
                            final draft = _CreateRedeemCodeDraft(
                              present: present,
                              code: _code.text,
                              prefix: _prefix.text,
                              count: int.tryParse(_count.text.trim()) ?? 1,
                              maxUseCount:
                                  int.tryParse(_maxUseCount.text.trim()) ?? 1,
                              activeAt: _activeAt,
                              expiresAt: _expiresAt,
                            );
                            if (_batch) {
                              widget.onCreateBatch(draft);
                            } else {
                              widget.onCreate(draft);
                            }
                          },
                    icon: const Icon(Icons.qr_code_2),
                    label: const Text('确认生成'),
                  ),
                ),
              ],
            ),
    );
  }
}

class _PricingEffectPanel extends StatefulWidget {
  const _PricingEffectPanel({
    required this.pricingConfigs,
    required this.onClose,
    required this.onSubmit,
  });

  final List<PricingConfig> pricingConfigs;
  final VoidCallback onClose;
  final ValueChanged<_PricingEffectDraft> onSubmit;

  @override
  State<_PricingEffectPanel> createState() => _PricingEffectPanelState();
}

class _PricingEffectPanelState extends State<_PricingEffectPanel> {
  final _id = TextEditingController();
  final _name = TextEditingController();
  final _value = TextEditingController();
  final _limitPerDay = TextEditingController();
  final _sessionLabels = TextEditingController();
  String _type = 'free';
  String _scope = _effectScopeSingle;
  bool _consumable = false;
  final _pricingConfigIds = <String>{};
  final _ruleIds = <String>{};
  DateTime? _activeAt;
  DateTime? _expiresAt;

  @override
  void dispose() {
    _id.dispose();
    _name.dispose();
    _value.dispose();
    _limitPerDay.dispose();
    _sessionLabels.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '计费效果草稿',
      subtitle: '配置资产能影响哪些计时费用。',
      trailing: IconButton(
        tooltip: '关闭',
        onPressed: widget.onClose,
        icon: const Icon(Icons.close),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _WorkspaceGrid(
            children: [
              _WorkspaceSection(
                title: '基础信息',
                subtitle: '效果编号用于后台识别，显示名称给店员选择资产时查看。',
                children: [
                  TextField(
                    controller: _id,
                    decoration: const InputDecoration(
                      labelText: '效果编号',
                      hintText: '例如 monthly-pass-free',
                    ),
                  ),
                  TextField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: '显示名称'),
                  ),
                ],
              ),
              _WorkspaceSection(
                title: '结算方式',
                subtitle: '决定这个资产如何影响结账金额。',
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _type,
                    decoration: const InputDecoration(labelText: '效果方式'),
                    items: const [
                      DropdownMenuItem(value: 'free', child: Text('免除费用')),
                      DropdownMenuItem(value: 'discount', child: Text('固定抵扣')),
                      DropdownMenuItem(
                        value: 'percentage-discount',
                        child: Text('按比例折扣'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _type = value);
                    },
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: _scope,
                    decoration: const InputDecoration(labelText: '作用范围'),
                    items: [
                      DropdownMenuItem(
                        value: _effectScopeSingle,
                        child: Text('单个计时'),
                      ),
                      const DropdownMenuItem(
                        value: 'unified',
                        child: Text('玩家结算总额'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _scope = value);
                    },
                  ),
                  if (_type != 'free')
                    TextField(
                      controller: _value,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: _type == 'discount' ? '抵扣金额' : '折扣比例',
                      ),
                    ),
                  TextField(
                    controller: _limitPerDay,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: '每日最多使用次数'),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('使用后扣除一份资产'),
                    value: _consumable,
                    onChanged: (value) => setState(() => _consumable = value),
                  ),
                ],
              ),
              _WorkspaceSection(
                title: '适用范围',
                subtitle: '留空表示不限；需要精确到某条计时时再选择。',
                children: [
                  TextField(
                    controller: _sessionLabels,
                    decoration: const InputDecoration(
                      labelText: '只对这些计时名称生效',
                      hintText: '例如 音游区间、四口麻将；留空表示不限',
                    ),
                  ),
                  Text(
                    '只对这些计费方案生效',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final config in widget.pricingConfigs.where(
                        (config) => !config.isArchived,
                      ))
                        FilterChip(
                          label: Text(_pricingConfigTitle(config)),
                          selected: _pricingConfigIds.contains(config.id),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _pricingConfigIds.add(config.id);
                              } else {
                                _pricingConfigIds.remove(config.id);
                                for (final rule in config.rules) {
                                  _ruleIds.remove(rule.id);
                                }
                              }
                            });
                          },
                        ),
                    ],
                  ),
                  Text(
                    '只对这些计费时段生效',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final config in widget.pricingConfigs.where(
                        (config) => _pricingConfigIds.contains(config.id),
                      ))
                        for (final rule in config.rules)
                          FilterChip(
                            label: Text(
                              '${_pricingConfigTitle(config)} · ${rule.label}',
                            ),
                            selected: _ruleIds.contains(rule.id),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _ruleIds.add(rule.id);
                                } else {
                                  _ruleIds.remove(rule.id);
                                }
                              });
                            },
                          ),
                      if (_pricingConfigIds.isEmpty)
                        const Chip(label: Text('先选择计费方案')),
                    ],
                  ),
                ],
              ),
              _WorkspaceSection(
                title: '生效时间',
                subtitle: '过期后的资产不会继续参与结算。',
                children: [
                  _DateTimeField(
                    label: '效果开始生效',
                    value: _activeAt,
                    onChanged: (value) => setState(() => _activeAt = value),
                  ),
                  _DateTimeField(
                    label: '效果过期时间',
                    value: _expiresAt,
                    onChanged: (value) => setState(() => _expiresAt = value),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () => widget.onSubmit(
                _PricingEffectDraft(
                  id: _id.text,
                  name: _name.text,
                  type: _type,
                  scope: _scope,
                  value: num.tryParse(_value.text.trim()),
                  consumable: _consumable,
                  limitPerDay: int.tryParse(_limitPerDay.text.trim()),
                  sessionLabels: _sessionLabels.text,
                  pricingConfigIds: Set<String>.from(_pricingConfigIds),
                  ruleIds: Set<String>.from(_ruleIds),
                  activeAt: _activeAt,
                  expiresAt: _expiresAt,
                ),
              ),
              icon: const Icon(Icons.save),
              label: const Text('保存计费效果'),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceGrid extends StatelessWidget {
  const _WorkspaceGrid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 980;
        if (!isWide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < children.length; index++) ...[
                if (index > 0) const SizedBox(height: 12),
                children[index],
              ],
            ],
          );
        }
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final child in children)
              SizedBox(width: (constraints.maxWidth - 16) / 2, child: child),
          ],
        );
      },
    );
  }
}

class _WorkspaceSection extends StatelessWidget {
  const _WorkspaceSection({
    required this.title,
    required this.children,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: theme.textTheme.titleSmall),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              for (var index = 0; index < children.length; index++) ...[
                if (index > 0) const SizedBox(height: 12),
                children[index],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AssetDefinitionDraft {
  const _AssetDefinitionDraft({
    required this.type,
    required this.code,
    required this.displayName,
    required this.stackable,
    required this.pricingEffectId,
    required this.activeAt,
    required this.expiresAt,
  });

  final String type;
  final String code;
  final String displayName;
  final bool stackable;
  final String? pricingEffectId;
  final DateTime? activeAt;
  final DateTime? expiresAt;
}

class _AssetDefinitionEditor extends StatefulWidget {
  const _AssetDefinitionEditor({
    super.key,
    required this.definition,
    required this.pricingEffects,
    required this.onSave,
    required this.onArchive,
    required this.onRestore,
  });

  final AssetDefinition? definition;
  final List<PricingEffect> pricingEffects;
  final ValueChanged<_AssetDefinitionDraft> onSave;
  final VoidCallback? onArchive;
  final VoidCallback? onRestore;

  @override
  State<_AssetDefinitionEditor> createState() => _AssetDefinitionEditorState();
}

class _AssetDefinitionEditorState extends State<_AssetDefinitionEditor> {
  late final TextEditingController _code;
  late final TextEditingController _name;
  late String _type;
  late bool _stackable;
  String? _pricingEffectId;
  DateTime? _activeAt;
  DateTime? _expiresAt;

  bool get _isNew => widget.definition == null;

  @override
  void initState() {
    super.initState();
    final definition = widget.definition;
    _type = definition?.type ?? 'currency';
    _code = TextEditingController(text: definition?.code ?? '');
    _name = TextEditingController(text: definition?.displayName ?? '');
    _stackable = definition?.stackable ?? true;
    _pricingEffectId =
        definition?.pricingEffectId ?? definition?.pricingEffect?.id;
    _activeAt = definition?.activeAt;
    _expiresAt = definition?.expiresAt;
  }

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final definition = widget.definition;
    return PrismPanel(
      title: _isNew ? '添加资产' : '资产详情',
      subtitle: _isNew ? '配置可发放给玩家的余额、券或权益。' : '查看资产用途、有效期和绑定的计费效果。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (definition != null) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('店内编号 ${definition.code}')),
                Chip(
                  label: Text('当前状态 ${definition.isArchived ? '已归档' : '正常'}'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          DropdownButtonFormField<String>(
            initialValue: _type,
            decoration: const InputDecoration(labelText: '资产类别'),
            items: const [
              DropdownMenuItem(value: 'currency', child: Text('余额资产')),
              DropdownMenuItem(value: 'ticket', child: Text('券')),
              DropdownMenuItem(value: 'pass', child: Text('通行权益')),
              DropdownMenuItem(value: 'benefit', child: Text('店内权益')),
            ],
            onChanged: _isNew
                ? (value) {
                    if (value == null) return;
                    setState(() => _type = value);
                  }
                : null,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _code,
            enabled: _isNew,
            decoration: const InputDecoration(labelText: '店内编号'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: '资产名称'),
          ),
          const SizedBox(height: 4),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('可以叠加数量'),
            value: _stackable,
            onChanged: (value) => setState(() => _stackable = value),
          ),
          DropdownButtonFormField<String?>(
            initialValue: _pricingEffectId,
            decoration: const InputDecoration(labelText: '绑定计费效果'),
            items: [
              const DropdownMenuItem(value: null, child: Text('不绑定计费效果')),
              for (final effect in widget.pricingEffects.where(
                (effect) => !effect.isArchived,
              ))
                DropdownMenuItem(
                  value: effect.id,
                  child: Text('${effect.name} · ${_pricingEffectKind(effect)}'),
                ),
            ],
            onChanged: (value) => setState(() => _pricingEffectId = value),
          ),
          const SizedBox(height: 12),
          _DateTimeField(
            label: '开始生效',
            value: _activeAt,
            onChanged: (value) => setState(() => _activeAt = value),
          ),
          const SizedBox(height: 8),
          _DateTimeField(
            label: '过期时间',
            value: _expiresAt,
            onChanged: (value) => setState(() => _expiresAt = value),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              widget.onSave(
                _AssetDefinitionDraft(
                  type: _type,
                  code: _code.text.trim(),
                  displayName: _name.text.trim(),
                  stackable: _stackable,
                  pricingEffectId: _pricingEffectId,
                  activeAt: _activeAt,
                  expiresAt: _expiresAt,
                ),
              );
            },
            icon: const Icon(Icons.save),
            label: Text(_isNew ? '保存资产' : '保存修改'),
          ),
          if (!_isNew && definition != null) ...[
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: definition.isArchived
                  ? widget.onRestore
                  : widget.onArchive,
              icon: Icon(
                definition.isArchived ? Icons.unarchive : Icons.archive,
              ),
              label: Text(definition.isArchived ? '恢复使用' : '归档资产'),
            ),
          ],
        ],
      ),
    );
  }
}

AssetDefinition? _selectedAssetDefinition(
  List<AssetDefinition> definitions,
  String? editorKey,
) {
  if (definitions.isEmpty || editorKey == _newAssetEditorKey) return null;
  for (final definition in definitions) {
    if (_assetDefinitionKey(definition) == editorKey) return definition;
  }
  for (final definition in definitions) {
    if (!definition.isArchived) return definition;
  }
  return definitions.first;
}

String _assetDefinitionKey(AssetDefinition? definition) {
  if (definition == null) return _newAssetEditorKey;
  return '${definition.type}:${definition.code}';
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

String _pricingEffectKind(PricingEffect effect) {
  final action = switch (effect.type) {
    'free' => '免除费用',
    'discount' => '固定抵扣',
    'percentage-discount' => '按比例折扣',
    _ => '计费调整',
  };
  final scope = effect.scope == 'unified' ? '玩家结算总额' : '单个计时';
  return '$action · $scope';
}

String _pricingConfigTitle(PricingConfig config) {
  final name = config.name.trim();
  if (name.toLowerCase().startsWith('legacy ')) return '迁移计时规则';
  if (name.isEmpty) return '未命名计费规则';
  return name;
}

Map<String, dynamic> _pricingEffectConfig({
  required String sessionLabels,
  required Set<String> pricingConfigIds,
  required Set<String> ruleIds,
}) {
  final labels = sessionLabels
      .split(RegExp(r'[,，、\n]'))
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList();
  return {
    if (labels.isNotEmpty)
      ['applicable', 'Ses', 'sion', 'Labels'].join(): labels,
    if (pricingConfigIds.isNotEmpty)
      'applicablePricingConfigIds': pricingConfigIds.toList(),
    if (ruleIds.isNotEmpty) 'applicableRuleIds': ruleIds.toList(),
  };
}

String _windowLabel(DateTime? activeAt, DateTime? expiresAt) {
  if (activeAt == null && expiresAt == null) return '';
  final start = activeAt == null ? '现在' : formatAdminDateTime(activeAt);
  final end = expiresAt == null ? '长期' : formatAdminDateTime(expiresAt);
  return '$start 到 $end';
}

class _PresentsTab extends StatefulWidget {
  const _PresentsTab({
    required this.presents,
    required this.definitions,
    required this.redeemCodes,
    required this.onCreate,
    required this.onArchive,
    required this.onRestore,
  });

  final List<Present> presents;
  final List<AssetDefinition> definitions;
  final List<RedeemCode> redeemCodes;
  final VoidCallback onCreate;
  final ValueChanged<Present> onArchive;
  final ValueChanged<Present> onRestore;

  @override
  State<_PresentsTab> createState() => _PresentsTabState();
}

class _PresentsTabState extends State<_PresentsTab> {
  String? _selectedPresentId;

  @override
  Widget build(BuildContext context) {
    final presents = widget.presents;
    final activePresents = presents
        .where((present) => !present.isArchived)
        .toList(growable: false);
    final archivedPresents = presents
        .where((present) => present.isArchived)
        .toList(growable: false);
    if (presents.isEmpty) {
      return const EmptyState(
        icon: Icons.card_giftcard,
        title: '暂无礼物',
        message: '礼物用于统一配置兑换码发放内容。',
      );
    }
    final selected = _selectedPresent(presents, _selectedPresentId);
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 900;
        final list = _PresentList(
          activePresents: activePresents,
          archivedPresents: archivedPresents,
          selectedPresentId: selected?.id,
          onCreate: widget.onCreate,
          onSelect: (present) =>
              setState(() => _selectedPresentId = present.id),
          onArchive: widget.onArchive,
          onRestore: widget.onRestore,
        );
        final detail = _PresentDetail(
          present: selected,
          definitions: widget.definitions,
          redeemCodes: selected == null
              ? const []
              : widget.redeemCodes
                    .where((code) => code.presentId == selected.id)
                    .toList(growable: false),
          onArchive: selected == null ? null : () => widget.onArchive(selected),
          onRestore: selected == null ? null : () => widget.onRestore(selected),
        );
        if (stacked) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [list, const SizedBox(height: 16), detail],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: list),
            const SizedBox(width: 24),
            SizedBox(width: 420, child: detail),
          ],
        );
      },
    );
  }
}

class _PresentList extends StatelessWidget {
  const _PresentList({
    required this.activePresents,
    required this.archivedPresents,
    required this.selectedPresentId,
    required this.onCreate,
    required this.onSelect,
    required this.onArchive,
    required this.onRestore,
  });

  final List<Present> activePresents;
  final List<Present> archivedPresents;
  final String? selectedPresentId;
  final VoidCallback onCreate;
  final ValueChanged<Present> onSelect;
  final ValueChanged<Present> onArchive;
  final ValueChanged<Present> onRestore;

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '礼物',
      subtitle: '礼物可以包含多项资产，并被一个或多个兑换码引用。',
      trailing: FilledButton.icon(
        onPressed: onCreate,
        icon: const Icon(Icons.card_giftcard),
        label: const Text('新建礼物'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (activePresents.isEmpty)
            const EmptyState(
              icon: Icons.card_giftcard,
              title: '暂无可用礼物',
              message: '恢复归档礼物或添加新礼物后，会显示在这里。',
            )
          else
            for (var index = 0; index < activePresents.length; index++) ...[
              _PresentTile(
                present: activePresents[index],
                selected: activePresents[index].id == selectedPresentId,
                onTap: () => onSelect(activePresents[index]),
                onArchive: () => onArchive(activePresents[index]),
                onRestore: () => onRestore(activePresents[index]),
              ),
              if (index != activePresents.length - 1) const Divider(height: 1),
            ],
          if (archivedPresents.isNotEmpty) ...[
            const SizedBox(height: 8),
            Material(
              color: Colors.transparent,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text('归档礼物（${archivedPresents.length}）'),
                subtitle: const Text('这些礼物不能生成新的兑换码，也不能被兑换。'),
                children: [
                  for (var index = 0; index < archivedPresents.length; index++)
                    _PresentTile(
                      present: archivedPresents[index],
                      selected: archivedPresents[index].id == selectedPresentId,
                      onTap: () => onSelect(archivedPresents[index]),
                      onArchive: () => onArchive(archivedPresents[index]),
                      onRestore: () => onRestore(archivedPresents[index]),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PresentTile extends StatelessWidget {
  const _PresentTile({
    required this.present,
    required this.selected,
    required this.onTap,
    required this.onArchive,
    required this.onRestore,
  });

  final Present present;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onArchive;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
      title: Text(present.name),
      subtitle: Text(
        [
          '${present.grants.length} 项内容',
          _windowLabel(present.activeAt, present.expiresAt),
        ].where((item) => item.isNotEmpty).join(' · '),
      ),
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

class _PresentDetail extends StatelessWidget {
  const _PresentDetail({
    required this.present,
    required this.definitions,
    required this.redeemCodes,
    required this.onArchive,
    required this.onRestore,
  });

  final Present? present;
  final List<AssetDefinition> definitions;
  final List<RedeemCode> redeemCodes;
  final VoidCallback? onArchive;
  final VoidCallback? onRestore;

  @override
  Widget build(BuildContext context) {
    final present = this.present;
    if (present == null) {
      return const PrismPanel(
        title: '礼物详情',
        subtitle: '选择一个礼物后查看它包含哪些资产。',
        child: EmptyState(
          icon: Icons.card_giftcard,
          title: '还没有选中礼物',
          message: '从左侧选择一个礼物。',
        ),
      );
    }
    final now = DateTime.now();
    final usableCodes = redeemCodes
        .where((code) => _redeemCodeUsable(code, present, now))
        .length;
    final usedCodes = redeemCodes
        .where((code) => code.usageCount >= code.usageLimit)
        .length;
    final revokedCodes = redeemCodes.where((code) => code.isRevoked).length;
    return PrismPanel(
      title: '礼物详情',
      subtitle: present.name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ArchiveStatusPill(isArchived: present.isArchived),
              Chip(label: Text(present.oncePerPlayer ? '每名玩家一次' : '可重复兑换')),
              if (_windowLabel(present.activeAt, present.expiresAt).isNotEmpty)
                Chip(
                  label: Text(
                    _windowLabel(present.activeAt, present.expiresAt),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text('绑定兑换码', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _MetricChip(label: '全部', value: '${redeemCodes.length}'),
              _MetricChip(label: '可用', value: '$usableCodes'),
              _MetricChip(label: '已用完', value: '$usedCodes'),
              _MetricChip(label: '已撤销', value: '$revokedCodes'),
            ],
          ),
          if (redeemCodes.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              '已绑定兑换码的礼物会影响后续兑换。需要调整内容时，建议归档后新建礼物。',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: 16),
          Text('包含内容', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (present.grants.isEmpty)
            const Text('这个礼物暂时没有内容。')
          else
            for (final grant in present.grants) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.redeem),
                title: Text(_grantAssetName(definitions, grant)),
                subtitle: Text(
                  [
                    '数量 ${grant.amount}',
                    _grantMergeLabel(grant.mergeStrategy),
                    _windowLabel(grant.activeAt, grant.expiresAt),
                  ].where((item) => item.isNotEmpty).join(' · '),
                ),
              ),
              const Divider(height: 1),
            ],
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: present.isArchived ? onRestore : onArchive,
            icon: Icon(present.isArchived ? Icons.unarchive : Icons.archive),
            label: Text(present.isArchived ? '恢复礼物' : '归档礼物'),
          ),
        ],
      ),
    );
  }
}

Present? _selectedPresent(List<Present> presents, String? selectedPresentId) {
  if (presents.isEmpty) return null;
  for (final present in presents) {
    if (present.id == selectedPresentId) return present;
  }
  for (final present in presents) {
    if (!present.isArchived) return present;
  }
  return presents.first;
}

String _grantMergeLabel(String mergeStrategy) {
  return switch (mergeStrategy) {
    'replace' => '替换现有',
    'extend-time' => '延长有效期',
    _ => '叠加数量',
  };
}

String _grantAssetName(List<AssetDefinition> definitions, AssetGrant grant) {
  for (final definition in definitions) {
    if (definition.type == grant.assetType &&
        definition.code == grant.assetCode) {
      return definition.displayName;
    }
  }
  return '未找到的资产';
}

class _RedeemCodesTab extends StatefulWidget {
  const _RedeemCodesTab({
    required this.codes,
    required this.presents,
    required this.onCreate,
    required this.onRevoke,
    required this.onOpenPlayer,
  });

  static const _previewCount = 20;

  final List<RedeemCode> codes;
  final List<Present> presents;
  final VoidCallback onCreate;
  final ValueChanged<RedeemCode> onRevoke;
  final ValueChanged<String>? onOpenPlayer;

  @override
  State<_RedeemCodesTab> createState() => _RedeemCodesTabState();
}

class _RedeemCodesTabState extends State<_RedeemCodesTab> {
  final _playerFilter = TextEditingController();
  final _codeFilter = TextEditingController();
  String? _presentFilterId;
  _RedeemCodeUsageFilter _usageFilter = _RedeemCodeUsageFilter.all;
  _RedeemCodeSort _sort = _RedeemCodeSort.createdDesc;
  DateTimeRange? _redeemedRange;
  DateTimeRange? _usableRange;

  @override
  void dispose() {
    _playerFilter.dispose();
    _codeFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codes = widget.codes;
    if (codes.isEmpty) {
      return const EmptyState(
        icon: Icons.qr_code_2,
        title: '暂无兑换码',
        message: '生成单个或批量兑换码后，会显示在这里。',
      );
    }
    final presentFilteredCodes = _presentFilterId == null
        ? codes
        : codes
              .where((code) => code.presentId == _presentFilterId)
              .toList(growable: false);
    final now = DateTime.now();
    final activeCount = presentFilteredCodes
        .where((code) => _redeemCodeUsable(code, _presentForCode(code), now))
        .length;
    final usedCount = presentFilteredCodes
        .where((code) => code.usageCount >= code.usageLimit)
        .length;
    final unavailableCount =
        presentFilteredCodes.length - activeCount - usedCount;
    final filteredCodes = presentFilteredCodes
        .where((code) => _usageFilter.matches(code, _presentForCode(code), now))
        .where(_matchesCodeSearch)
        .where(_matchesPlayerSearch)
        .where(_matchesRedeemedRange)
        .where(_matchesUsableRange)
        .toList(growable: false);
    filteredCodes.sort(
      (a, b) => _sort.compare(
        a,
        b,
        _presentName(widget.presents, a.presentId),
        _presentName(widget.presents, b.presentId),
      ),
    );
    final preview = filteredCodes
        .take(_RedeemCodesTab._previewCount)
        .toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrismPanel(
          title: '兑换码概览',
          subtitle: '兑换码可能有几千上万条，这里只保留汇总和最近少量记录。',
          trailing: FilledButton.icon(
            onPressed: widget.onCreate,
            icon: const Icon(Icons.qr_code_2),
            label: const Text('生成兑换码'),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 260,
                    child: DropdownButtonFormField<String?>(
                      initialValue: _presentFilterId,
                      decoration: const InputDecoration(labelText: '按礼物筛选'),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('全部礼物'),
                        ),
                        for (final present in widget.presents)
                          DropdownMenuItem(
                            value: present.id,
                            child: Text(present.name),
                          ),
                      ],
                      onChanged: (value) =>
                          setState(() => _presentFilterId = value),
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: _playerFilter,
                      decoration: const InputDecoration(
                        labelText: '按玩家筛选',
                        prefixIcon: Icon(Icons.person_search),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: _codeFilter,
                      decoration: const InputDecoration(
                        labelText: '按兑换码筛选',
                        prefixIcon: Icon(Icons.qr_code_2),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  SizedBox(
                    width: 210,
                    child: DropdownButtonFormField<_RedeemCodeSort>(
                      initialValue: _sort,
                      decoration: const InputDecoration(labelText: '排序方式'),
                      items: [
                        for (final sort in _RedeemCodeSort.values)
                          DropdownMenuItem(
                            value: sort,
                            child: Text(sort.label),
                          ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _sort = value);
                      },
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _pickRedeemedRange(context),
                    icon: const Icon(Icons.event_available),
                    label: Text(
                      _redeemedRange == null
                          ? '兑换时间'
                          : _rangeLabel(_redeemedRange!),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _pickUsableRange(context),
                    icon: const Icon(Icons.date_range),
                    label: Text(
                      _usableRange == null
                          ? '可用时间'
                          : _rangeLabel(_usableRange!),
                    ),
                  ),
                  if (_hasAdvancedFilters)
                    TextButton.icon(
                      onPressed: _clearAdvancedFilters,
                      icon: const Icon(Icons.filter_alt_off),
                      label: const Text('清除筛选'),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _RedeemCodeFilterChip(
                    label: '全部',
                    value: '${presentFilteredCodes.length}',
                    selected: _usageFilter == _RedeemCodeUsageFilter.all,
                    icon: Icons.confirmation_number_outlined,
                    onSelected: () => setState(
                      () => _usageFilter = _RedeemCodeUsageFilter.all,
                    ),
                  ),
                  _RedeemCodeFilterChip(
                    label: '可继续使用',
                    value: '$activeCount',
                    selected: _usageFilter == _RedeemCodeUsageFilter.usable,
                    icon: Icons.check_circle_outline,
                    onSelected: () => setState(
                      () => _usageFilter = _RedeemCodeUsageFilter.usable,
                    ),
                  ),
                  _RedeemCodeFilterChip(
                    label: '已使用',
                    value: '$usedCount',
                    selected: _usageFilter == _RedeemCodeUsageFilter.used,
                    icon: Icons.task_alt,
                    onSelected: () => setState(
                      () => _usageFilter = _RedeemCodeUsageFilter.used,
                    ),
                  ),
                  _RedeemCodeFilterChip(
                    label: '不可使用',
                    value: '$unavailableCount',
                    selected:
                        _usageFilter == _RedeemCodeUsageFilter.unavailable,
                    icon: Icons.block,
                    onSelected: () => setState(
                      () => _usageFilter = _RedeemCodeUsageFilter.unavailable,
                    ),
                  ),
                  _MetricChip(label: '当前预览', value: '${preview.length} 条'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        PrismPanel(
          title: '最近 20 条',
          subtitle: '需要查某一批兑换码时，用后台查询或批次导出，不在页面一次性展开全部。',
          child: Column(
            children: [
              for (var index = 0; index < preview.length; index++) ...[
                _RedeemCodeTile(
                  code: preview[index],
                  present: _presentForCode(preview[index]),
                  presentName: _presentName(
                    widget.presents,
                    preview[index].presentId,
                  ),
                  onRevoke: () => widget.onRevoke(preview[index]),
                  onOpenPlayer: widget.onOpenPlayer,
                ),
                if (index != preview.length - 1) const Divider(height: 1),
              ],
              if (preview.isEmpty)
                const EmptyState(
                  icon: Icons.qr_code_2,
                  title: '这个礼物下暂无兑换码',
                  message: '切换筛选条件或先生成兑换码。',
                ),
            ],
          ),
        ),
        if (filteredCodes.length > _RedeemCodesTab._previewCount) ...[
          const SizedBox(height: 12),
          Text(
            '还有 ${filteredCodes.length - _RedeemCodesTab._previewCount} 条没有在页面展开。',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }

  Present? _presentForCode(RedeemCode code) {
    for (final present in widget.presents) {
      if (present.id == code.presentId) return present;
    }
    return null;
  }

  bool get _hasAdvancedFilters =>
      _playerFilter.text.trim().isNotEmpty ||
      _codeFilter.text.trim().isNotEmpty ||
      _redeemedRange != null ||
      _usableRange != null;

  bool _matchesCodeSearch(RedeemCode code) {
    final query = _codeFilter.text.trim().toLowerCase();
    if (query.isEmpty) return true;
    return code.code.toLowerCase().contains(query);
  }

  bool _matchesPlayerSearch(RedeemCode code) {
    final query = _playerFilter.text.trim().toLowerCase();
    if (query.isEmpty) return true;
    return code.redemptions.any((redemption) {
      return redemption.playerDisplayName.toLowerCase().contains(query);
    });
  }

  bool _matchesRedeemedRange(RedeemCode code) {
    final range = _redeemedRange;
    if (range == null) return true;
    return code.redemptions.any(
      (redemption) => _inDateRange(redemption.redeemedAt, range),
    );
  }

  bool _matchesUsableRange(RedeemCode code) {
    final range = _usableRange;
    if (range == null) return true;
    final startsInRange =
        code.activeAt != null && _inDateRange(code.activeAt!, range);
    final expiresInRange =
        code.expiresAt != null && _inDateRange(code.expiresAt!, range);
    return startsInRange || expiresInRange;
  }

  Future<void> _pickRedeemedRange(BuildContext context) async {
    final picked = await _pickDateRange(context, _redeemedRange);
    if (picked != null) setState(() => _redeemedRange = picked);
  }

  Future<void> _pickUsableRange(BuildContext context) async {
    final picked = await _pickDateRange(context, _usableRange);
    if (picked != null) setState(() => _usableRange = picked);
  }

  Future<DateTimeRange?> _pickDateRange(
    BuildContext context,
    DateTimeRange? initial,
  ) {
    final now = DateTime.now();
    return showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDateRange: initial,
    );
  }

  void _clearAdvancedFilters() {
    setState(() {
      _playerFilter.clear();
      _codeFilter.clear();
      _redeemedRange = null;
      _usableRange = null;
    });
  }
}

enum _RedeemCodeUsageFilter { all, usable, used, unavailable }

enum _RedeemCodeSort {
  createdDesc('最近创建'),
  redeemedDesc('最近兑换'),
  expiresAsc('即将过期'),
  usageDesc('使用次数'),
  presentAsc('礼物名称');

  const _RedeemCodeSort(this.label);
  final String label;

  int compare(RedeemCode a, RedeemCode b, String presentA, String presentB) {
    return switch (this) {
      _RedeemCodeSort.createdDesc => _dateDesc(a.createdAt, b.createdAt),
      _RedeemCodeSort.redeemedDesc => _dateDesc(
        _latestRedeemedAt(a),
        _latestRedeemedAt(b),
      ),
      _RedeemCodeSort.expiresAsc => _dateAsc(a.expiresAt, b.expiresAt),
      _RedeemCodeSort.usageDesc => b.usageCount.compareTo(a.usageCount),
      _RedeemCodeSort.presentAsc => presentA.compareTo(presentB),
    };
  }
}

extension _RedeemCodeUsageFilterLabel on _RedeemCodeUsageFilter {
  bool matches(RedeemCode code, Present? present, DateTime now) {
    return switch (this) {
      _RedeemCodeUsageFilter.all => true,
      _RedeemCodeUsageFilter.usable => _redeemCodeUsable(code, present, now),
      _RedeemCodeUsageFilter.used => code.usageCount >= code.usageLimit,
      _RedeemCodeUsageFilter.unavailable =>
        !_redeemCodeUsable(code, present, now) &&
            code.usageCount < code.usageLimit,
    };
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label $value'),
      avatar: const Icon(Icons.confirmation_number_outlined, size: 18),
    );
  }
}

class _RedeemCodeFilterChip extends StatelessWidget {
  const _RedeemCodeFilterChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.icon,
    required this.onSelected,
  });

  final String label;
  final String value;
  final bool selected;
  final IconData icon;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      showCheckmark: false,
      avatar: Icon(icon, size: 18),
      label: Text('$label $value'),
      onSelected: (_) => onSelected(),
    );
  }
}

class _RedeemCodeTile extends StatelessWidget {
  const _RedeemCodeTile({
    required this.code,
    required this.present,
    required this.presentName,
    required this.onRevoke,
    required this.onOpenPlayer,
  });

  final RedeemCode code;
  final Present? present;
  final String presentName;
  final VoidCallback onRevoke;
  final ValueChanged<String>? onOpenPlayer;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final usable = _redeemCodeUsable(code, present, now);
    return ListTile(
      title: Text(code.code),
      subtitle: Text(
        [
          '礼物 $presentName',
          '已用 ${code.usageCount} / ${code.usageLimit}',
          _redemptionSummary(code.redemptions),
          _windowLabel(code.activeAt, code.expiresAt),
        ].where((item) => item.isNotEmpty).join(' · '),
      ),
      trailing: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Chip(label: Text(_redeemCodeStatusLabel(code, present, now))),
          if (code.redemptions.isNotEmpty && onOpenPlayer != null)
            TextButton.icon(
              onPressed: () => onOpenPlayer!(code.redemptions.first.playerId),
              icon: const Icon(Icons.person_search),
              label: const Text('查看玩家'),
            ),
          TextButton(
            onPressed: usable ? onRevoke : null,
            child: Text(code.isRevoked ? '已撤销' : '撤销'),
          ),
        ],
      ),
    );
  }
}

DateTime? _latestRedeemedAt(RedeemCode code) {
  DateTime? latest;
  for (final redemption in code.redemptions) {
    if (latest == null || redemption.redeemedAt.isAfter(latest)) {
      latest = redemption.redeemedAt;
    }
  }
  return latest;
}

int _dateDesc(DateTime? a, DateTime? b) {
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  return b.compareTo(a);
}

int _dateAsc(DateTime? a, DateTime? b) {
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  return a.compareTo(b);
}

bool _inDateRange(DateTime value, DateTimeRange range) {
  final local = value.toLocal();
  final start = DateTime(range.start.year, range.start.month, range.start.day);
  final end = DateTime(
    range.end.year,
    range.end.month,
    range.end.day,
    23,
    59,
    59,
    999,
  );
  return !local.isBefore(start) && !local.isAfter(end);
}

String _rangeLabel(DateTimeRange range) {
  return '${formatAdminDate(range.start)} 至 ${formatAdminDate(range.end)}';
}

String _redemptionSummary(List<RedeemCodeRedemption> redemptions) {
  if (redemptions.isEmpty) return '';
  final sorted = [...redemptions]
    ..sort((a, b) => b.redeemedAt.compareTo(a.redeemedAt));
  final latest = sorted.first;
  final suffix = sorted.length > 1 ? '等 ${sorted.length} 次' : '';
  return '使用：${latest.playerDisplayName} · ${formatAdminDateTime(latest.redeemedAt)}$suffix';
}

String _presentName(List<Present> presents, String? presentId) {
  if (presentId == null) return '--';
  for (final present in presents) {
    if (present.id == presentId) return present.name;
  }
  return presentId;
}

bool _redeemCodeUsable(RedeemCode code, Present? present, DateTime now) {
  return _redeemCodeStatusLabel(code, present, now) == '可使用';
}

String _redeemCodeStatusLabel(RedeemCode code, Present? present, DateTime now) {
  if (code.isRevoked) return '已撤销';
  if (code.usageCount >= code.usageLimit) return '已使用';
  if (!_isActiveInWindow(code.activeAt, code.expiresAt, now)) {
    return code.activeAt != null && now.isBefore(code.activeAt!)
        ? '未开始'
        : '已过期';
  }
  if (present == null) return '礼物不存在';
  if (present.isArchived) return '礼物已归档';
  if (!_isActiveInWindow(present.activeAt, present.expiresAt, now)) {
    return present.activeAt != null && now.isBefore(present.activeAt!)
        ? '礼物未开始'
        : '礼物已过期';
  }
  return '可使用';
}

bool _isActiveInWindow(DateTime? activeAt, DateTime? expiresAt, DateTime now) {
  if (activeAt != null && now.isBefore(activeAt)) return false;
  if (expiresAt != null && !now.isBefore(expiresAt)) return false;
  return true;
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
