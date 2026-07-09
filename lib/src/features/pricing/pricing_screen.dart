import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../context_extensions.dart';
import '../../shared/admin_forms.dart';
import '../../shared/admin_layout.dart';
import '../../shared/widgets.dart';

class PricingScreen extends ConsumerStatefulWidget {
  const PricingScreen({super.key, this.api});

  final PrismApiClient? api;

  @override
  ConsumerState<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends ConsumerState<PricingScreen> {
  late Future<_PricingData> _future;
  String? _selectedId;
  bool _creatingDraft = false;
  String? _message;

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_PricingData>(
      future: _future,
      builder: (context, snapshot) {
        final data =
            snapshot.data ?? const _PricingData(configs: [], extensions: []);
        final selected = _creatingDraft ? null : _selectedConfig(data.configs);
        return AdminWorkspace(
          title: '计费配置',
          subtitle: '管理入场计时、店内附加收费和每天的营业计费时段。',
          actions: [
            OutlinedButton.icon(
              onPressed: () => setState(() {
                _creatingDraft = true;
                _selectedId = null;
              }),
              icon: const Icon(Icons.add),
              label: const Text('新建方案'),
            ),
            IconButton(
              tooltip: '刷新',
              onPressed: _refresh,
              icon: const Icon(Icons.refresh),
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
              if (snapshot.connectionState != ConnectionState.done)
                const Center(child: CircularProgressIndicator())
              else if (snapshot.hasError)
                PrismPanel(
                  title: '计费数据没有加载成功',
                  subtitle: snapshot.error.toString(),
                  trailing: IconButton(
                    tooltip: '重试',
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh),
                  ),
                  child: const SizedBox.shrink(),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _PricingList(
                          configs: data.configs,
                          selectedId: selected?.id,
                          extensionCount: data.extensions.length,
                          onSelect: (config) => setState(() {
                            _creatingDraft = false;
                            _selectedId = config.id;
                          }),
                          onArchive: _archiveConfig,
                          onRestore: _restoreConfig,
                        ),
                        const SizedBox(height: 16),
                        _PricingEditor(
                          key: ValueKey(selected?.id ?? 'new'),
                          selected: selected,
                          configs: data.configs,
                          api: _api,
                          onSaved: (message, savedId) {
                            setState(() {
                              _message = message;
                              _creatingDraft = false;
                              _selectedId = savedId ?? _selectedId;
                              _future = _load();
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<_PricingData> _load() async {
    final results = await Future.wait<Object>([
      _api.listPricingConfigs(),
      _api.listPricingExtensions(),
    ]);
    return _PricingData(
      configs: results[0] as List<PricingConfig>,
      extensions: results[1] as List<Map<String, dynamic>>,
    );
  }

  PricingConfig? _selectedConfig(List<PricingConfig> configs) {
    if (configs.isEmpty) return null;
    if (_selectedId == null) {
      return configs.firstWhere(
        (config) => !config.isArchived,
        orElse: () => configs.first,
      );
    }
    return configs.firstWhere(
      (config) => config.id == _selectedId,
      orElse: () => configs.firstWhere(
        (config) => !config.isArchived,
        orElse: () => configs.first,
      ),
    );
  }

  void _refresh() {
    setState(() => _future = _load());
  }

  Future<void> _archiveConfig(PricingConfig config) async {
    await _api.archivePricingConfig(config.id);
    setState(() {
      _creatingDraft = false;
      _message = '计费方案已归档。';
      _future = _load();
    });
  }

  Future<void> _restoreConfig(PricingConfig config) async {
    await _api.restorePricingConfig(config.id);
    setState(() {
      _creatingDraft = false;
      _message = '计费方案已恢复。';
      _future = _load();
    });
  }
}

class _PricingData {
  const _PricingData({required this.configs, required this.extensions});

  final List<PricingConfig> configs;
  final List<Map<String, dynamic>> extensions;
}

class _PricingList extends StatelessWidget {
  const _PricingList({
    required this.configs,
    required this.selectedId,
    required this.extensionCount,
    required this.onSelect,
    required this.onArchive,
    required this.onRestore,
  });

  final List<PricingConfig> configs;
  final String? selectedId;
  final int extensionCount;
  final ValueChanged<PricingConfig> onSelect;
  final ValueChanged<PricingConfig> onArchive;
  final ValueChanged<PricingConfig> onRestore;

  @override
  Widget build(BuildContext context) {
    final activeConfigs = configs
        .where((config) => !config.isArchived)
        .toList(growable: false);
    final archivedConfigs = configs
        .where((config) => config.isArchived)
        .toList(growable: false);
    return PrismPanel(
      title: '计费方案',
      subtitle: '已接入 $extensionCount 项扩展能力',
      child: configs.isEmpty
          ? const EmptyState(
              icon: Icons.tune,
              title: '还没有计费方案',
              message: '先新建一条按时计费或固定收费方案。',
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (activeConfigs.isEmpty)
                  const EmptyState(
                    icon: Icons.tune,
                    title: '暂无可用方案',
                    message: '恢复归档方案或新建方案后，结算才能使用。',
                  )
                else
                  for (final config in activeConfigs)
                    _PricingConfigTile(
                      config: config,
                      selected: config.id == selectedId,
                      onSelect: () => onSelect(config),
                      actionLabel: '归档',
                      onAction: () => onArchive(config),
                    ),
                if (archivedConfigs.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Material(
                    color: Colors.transparent,
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.inventory_2_outlined),
                      title: Text('归档方案（${archivedConfigs.length}）'),
                      subtitle: const Text('这些方案不会参与新结算，可从这里恢复。'),
                      children: [
                        for (final config in archivedConfigs)
                          _PricingConfigTile(
                            config: config,
                            selected: config.id == selectedId,
                            onSelect: () => onSelect(config),
                            actionLabel: '恢复',
                            onAction: () => onRestore(config),
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

class _PricingConfigTile extends StatelessWidget {
  const _PricingConfigTile({
    required this.config,
    required this.selected,
    required this.onSelect,
    required this.actionLabel,
    required this.onAction,
  });

  final PricingConfig config;
  final bool selected;
  final VoidCallback onSelect;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: selected,
        leading: Icon(
          config.kind == 'charge.fixed'
              ? Icons.payments_outlined
              : Icons.donut_large,
        ),
        title: Text(_pricingConfigTitle(config)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_pricingSummary(config)),
            const SizedBox(height: 4),
            _PricingConfigIdLine(configId: config.id, compact: true),
          ],
        ),
        onTap: onSelect,
        trailing: Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ArchiveStatusPill(isArchived: config.isArchived),
            TextButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ),
      ),
    );
  }
}

class _PricingEditor extends StatefulWidget {
  const _PricingEditor({
    super.key,
    required this.selected,
    required this.configs,
    required this.api,
    required this.onSaved,
  });

  final PricingConfig? selected;
  final List<PricingConfig> configs;
  final PrismApiClient api;
  final void Function(String message, String? savedId) onSaved;

  @override
  State<_PricingEditor> createState() => _PricingEditorState();
}

class _PricingEditorState extends State<_PricingEditor> {
  final _name = TextEditingController();
  final _fixedLabel = TextEditingController();
  String _mode = 'time.priority';
  bool _enabled = true;
  DateTime _previewDate = DateTime(2026, 7, 5);
  String _providerId = 'time.default';
  List<String> _includedPricingConfigIds = [];
  List<_RuleDraft> _rules = [];
  int _selectedRuleIndex = 0;
  num _fixedAmount = 500;
  String? _error;
  Future<PricingTimeline>? _timelineFuture;
  PricingTimeline? _lastTimeline;

  @override
  void initState() {
    super.initState();
    _load(widget.selected);
  }

  @override
  void dispose() {
    _name.dispose();
    _fixedLabel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedRule = _rules.isEmpty
        ? null
        : _rules[_selectedRuleIndex.clamp(0, _rules.length - 1)];
    return PrismPanel(
      title: widget.selected == null
          ? '新建计费方案'
          : _pricingConfigTitle(widget.selected!),
      subtitle: _mode == 'time.priority'
          ? '编辑一天内实际会生效的时段，圆环来自后端预览结果。'
          : _mode == 'time.cap'
          ? '只限制选中计费方案的合计金额，不直接产生费用。'
          : '适合门票、服务费和一次性项目。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_error != null) ...[
            _MessageBanner(
              message: _error!,
              isError: true,
              onClose: () => setState(() => _error = null),
            ),
            const SizedBox(height: 12),
          ],
          if (_mode == 'charge.fixed')
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PlanBasics(
                  configId: widget.selected?.id,
                  name: _name,
                  mode: _mode,
                  enabled: _enabled,
                  onModeChanged: _changeMode,
                  onEnabledChanged: (value) => setState(() => _enabled = value),
                ),
                const SizedBox(height: 16),
                _FixedChargeEditor(
                  label: _fixedLabel,
                  amount: _fixedAmount,
                  onAmountChanged: (value) =>
                      setState(() => _fixedAmount = value),
                ),
              ],
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 900;
                final timeline = _mode == 'time.priority' || _mode == 'time.cap'
                    ? _TimelinePanel(
                        timelineFuture: _timelineFuture,
                        cachedTimeline: _lastTimeline,
                        previewDate: _previewDate,
                        onDateChanged: _changePreviewDate,
                        onRefresh: _refreshTimeline,
                        onSegmentSelected: _selectSegment,
                        selectedRuleId: selectedRule?.id,
                        isCapTimeline: _mode == 'time.cap',
                      )
                    : null;
                final rules = _RuleListPanel(
                  rules: _rules,
                  selectedIndex: _selectedRuleIndex,
                  onSelect: (index) =>
                      setState(() => _selectedRuleIndex = index),
                  onAdd: _addRule,
                );
                final basics = _PlanBasics(
                  configId: widget.selected?.id,
                  name: _name,
                  mode: _mode,
                  enabled: _enabled,
                  onModeChanged: _changeMode,
                  onEnabledChanged: (value) => setState(() => _enabled = value),
                );
                final ruleForm = selectedRule == null
                    ? null
                    : _RuleForm(
                        rule: selectedRule,
                        isCapRule: _mode == 'time.cap',
                        onChanged: _updateSelectedRule,
                        onDelete: _deleteSelectedRule,
                      );
                final capSelector = _mode == 'time.cap'
                    ? _IncludedPricingConfigSelector(
                        configs: widget.configs,
                        selectedIds: _includedPricingConfigIds,
                        currentConfigId: widget.selected?.id,
                        onChanged: (value) =>
                            setState(() => _includedPricingConfigIds = value),
                      )
                    : null;
                final edit = _PricingEditColumn(
                  basics: basics,
                  ruleForm: capSelector == null
                      ? ruleForm
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            capSelector,
                            if (ruleForm != null) ...[
                              const SizedBox(height: 16),
                              ruleForm,
                            ],
                          ],
                        ),
                );
                if (!wide) {
                  return Column(
                    children: [
                      basics,
                      if (timeline != null) ...[
                        const SizedBox(height: 16),
                        timeline,
                      ],
                      const SizedBox(height: 16),
                      rules,
                      if (capSelector != null) ...[
                        const SizedBox(height: 16),
                        capSelector,
                      ],
                      if (ruleForm != null) ...[
                        const SizedBox(height: 16),
                        ruleForm,
                      ],
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 420,
                      child: timeline == null
                          ? rules
                          : _TimelineAndRuleList(
                              timeline: timeline,
                              rules: rules,
                            ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(child: edit),
                  ],
                );
              },
            ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              if (_mode == 'time.priority' || _mode == 'time.cap')
                OutlinedButton.icon(
                  onPressed: _refreshTimeline,
                  icon: const Icon(Icons.timeline),
                  label: const Text('预览草稿'),
                ),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('保存方案'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _load(PricingConfig? config) {
    _mode = config?.kind ?? 'time.priority';
    _enabled = config?.isActive ?? true;
    _name.text = config == null ? '营业时间计费' : _pricingConfigTitle(config);
    _providerId =
        config?.providerId ??
        (_mode == 'charge.fixed'
            ? 'fixed.${DateTime.now().millisecondsSinceEpoch}'
            : _mode == 'time.cap'
            ? 'cap.${DateTime.now().millisecondsSinceEpoch}'
            : 'time.${DateTime.now().millisecondsSinceEpoch}');
    _fixedLabel.text = config?.fixedChargeLabel ?? '店内固定收费';
    _fixedAmount = config?.fixedChargeAmount ?? 500;
    _includedPricingConfigIds = config?.includedPricingConfigIds ?? const [];
    _rules = (config?.rules.isEmpty ?? true)
        ? [_RuleDraft.standard()]
        : [for (final rule in config!.rules) _RuleDraft.fromModel(rule)];
    _selectedRuleIndex = 0;
    _error = null;
    _lastTimeline = null;
    if (_mode == 'time.priority' || _mode == 'time.cap') _refreshTimeline();
  }

  void _changePreviewDate(DateTime value) {
    setState(() => _previewDate = value);
    _refreshTimeline();
  }

  void _changeMode(String value) {
    setState(() {
      _mode = value;
      if (value == 'charge.fixed' && _providerId.startsWith('time.')) {
        _providerId = 'fixed.${DateTime.now().millisecondsSinceEpoch}';
      }
      if (value == 'time.cap') {
        _providerId = _providerId.startsWith('cap.')
            ? _providerId
            : 'cap.${DateTime.now().millisecondsSinceEpoch}';
      }
      if (value == 'time.priority' &&
          (_providerId.startsWith('fixed.') ||
              _providerId.startsWith('cap.'))) {
        _providerId = 'time.${DateTime.now().millisecondsSinceEpoch}';
      }
    });
    if (value == 'time.priority' || value == 'time.cap') _refreshTimeline();
  }

  void _addRule() {
    setState(() {
      _rules = [..._rules, _RuleDraft.extra(priority: _rules.length + 1)];
      _selectedRuleIndex = _rules.length - 1;
    });
    _refreshTimeline();
  }

  void _deleteSelectedRule() {
    final selected = _rules[_selectedRuleIndex];
    final activeRules = _rules.where((rule) => !rule.isArchived).length;
    if (!selected.isArchived && activeRules <= 1) {
      setState(() => _error = '至少保留一个可用时段。');
      return;
    }
    setState(() {
      if (selected.isArchived) {
        _rules[_selectedRuleIndex] = selected.copyWith(status: 'active');
      } else if (selected.persisted) {
        _rules[_selectedRuleIndex] = selected.copyWith(status: 'archived');
        _selectedRuleIndex = _firstActiveRuleIndex(_rules);
      } else {
        _rules.removeAt(_selectedRuleIndex);
        _selectedRuleIndex = math.min(_selectedRuleIndex, _rules.length - 1);
      }
    });
    _refreshTimeline();
  }

  void _updateSelectedRule(_RuleDraft rule) {
    setState(() => _rules[_selectedRuleIndex] = rule);
    _refreshTimeline();
  }

  void _selectSegment(UnitPricing segment) {
    final index = _rules.indexWhere((rule) => rule.id == segment.ruleId);
    if (index >= 0) setState(() => _selectedRuleIndex = index);
  }

  int _firstActiveRuleIndex(List<_RuleDraft> rules) {
    final index = rules.indexWhere((rule) => !rule.isArchived);
    return index < 0 ? 0 : index;
  }

  void _refreshTimeline() {
    if (_mode != 'time.priority' && _mode != 'time.cap') return;
    final future = widget.api.previewPricingTimeline(
      name: _name.text.trim().isEmpty ? '草稿' : _name.text.trim(),
      kind: _mode,
      providerId: _providerId,
      localDate: _dateText(_previewDate),
      rules: [for (final rule in _rules) rule.toJson()],
      includedPricingConfigIds: _includedPricingConfigIds,
    );
    setState(() {
      _timelineFuture = future;
    });
    future.then((timeline) {
      if (!mounted || _timelineFuture != future) return;
      setState(() => _lastTimeline = timeline);
    });
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) {
      setState(() => _error = '请输入方案名称。');
      return;
    }
    try {
      if (_mode == 'charge.fixed') {
        final saved = widget.selected == null || widget.selected!.isArchived
            ? await widget.api.createFixedChargePricingConfig(
                name: _name.text.trim(),
                label: _fixedLabel.text.trim().isEmpty
                    ? _name.text.trim()
                    : _fixedLabel.text.trim(),
                amount: _fixedAmount,
                enabled: _enabled,
                providerId: _providerId,
              )
            : await widget.api.updateFixedChargePricingConfig(
                widget.selected!.id,
                name: _name.text.trim(),
                label: _fixedLabel.text.trim().isEmpty
                    ? _name.text.trim()
                    : _fixedLabel.text.trim(),
                amount: _fixedAmount,
                isActive: _enabled,
                providerId: _providerId,
              );
        widget.onSaved('固定收费方案已保存。', saved.id);
        return;
      }
      if (_mode == 'time.cap') {
        if (_includedPricingConfigIds.isEmpty) {
          setState(() => _error = '请选择至少一个参与全局封顶的按时计费方案。');
          return;
        }
        final saved = widget.selected == null || widget.selected!.isArchived
            ? await widget.api.createPricingConfig(
                name: _name.text.trim(),
                kind: 'time.cap',
                rules: [for (final rule in _rules) rule.toJson()],
                enabled: _enabled,
                providerId: _providerId,
                includedPricingConfigIds: _includedPricingConfigIds,
              )
            : await widget.api.updatePricingConfig(
                widget.selected!.id,
                name: _name.text.trim(),
                rules: [for (final rule in _rules) rule.toJson()],
                isActive: _enabled,
                providerId: _providerId,
                kind: 'time.cap',
                includedPricingConfigIds: _includedPricingConfigIds,
              );
        widget.onSaved('全局封顶时间轴已保存。', saved.id);
        return;
      }

      final saved = widget.selected == null || widget.selected!.isArchived
          ? await widget.api.createPricingConfig(
              name: _name.text.trim(),
              kind: 'time.priority',
              rules: [for (final rule in _rules) rule.toJson()],
              enabled: _enabled,
              providerId: _providerId,
            )
          : await widget.api.updatePricingConfig(
              widget.selected!.id,
              name: _name.text.trim(),
              rules: [for (final rule in _rules) rule.toJson()],
              isActive: _enabled,
              providerId: _providerId,
            );
      widget.onSaved('按时计费方案已保存。', saved.id);
    } catch (error) {
      setState(
        () => _error = error is PrismApiException
            ? error.message
            : error.toString(),
      );
    }
  }
}

class _PlanBasics extends StatelessWidget {
  const _PlanBasics({
    required this.configId,
    required this.name,
    required this.mode,
    required this.enabled,
    required this.onModeChanged,
    required this.onEnabledChanged,
  });

  final String? configId;
  final TextEditingController name;
  final String mode;
  final bool enabled;
  final ValueChanged<String> onModeChanged;
  final ValueChanged<bool> onEnabledChanged;

  @override
  Widget build(BuildContext context) {
    return _InlinePanel(
      icon: Icons.tune,
      title: '方案信息',
      subtitle: '按时计费用于入场计时；固定收费适合门票、服务费或一次性项目。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: '方案名称'),
          ),
          if (configId != null && configId!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _PricingConfigIdLine(configId: configId!),
          ],
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'time.priority',
                icon: Icon(Icons.timer),
                label: Text('按时计费'),
              ),
              ButtonSegment(
                value: 'time.cap',
                icon: Icon(Icons.price_check),
                label: Text('全局封顶'),
              ),
              ButtonSegment(
                value: 'charge.fixed',
                icon: Icon(Icons.payments_outlined),
                label: Text('固定收费'),
              ),
            ],
            selected: {mode},
            onSelectionChanged: (value) => onModeChanged(value.first),
          ),
          const SizedBox(height: 8),
          Material(
            color: Colors.transparent,
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(enabled ? '结算时可使用' : '暂时不使用'),
              value: enabled,
              onChanged: onEnabledChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _IncludedPricingConfigSelector extends StatelessWidget {
  const _IncludedPricingConfigSelector({
    required this.configs,
    required this.selectedIds,
    required this.currentConfigId,
    required this.onChanged,
  });

  final List<PricingConfig> configs;
  final List<String> selectedIds;
  final String? currentConfigId;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    final candidates = configs
        .where(
          (config) =>
              config.kind == 'time.priority' && config.id != currentConfigId,
        )
        .toList();
    return _InlinePanel(
      icon: Icons.playlist_add_check,
      title: '参与封顶的计费方案',
      subtitle: '全局封顶只汇总这里选中的按时计费方案；固定收费和其他全局封顶不能被选中。',
      child: candidates.isEmpty
          ? const EmptyState(
              icon: Icons.playlist_remove,
              title: '暂无可选方案',
              message: '请先创建至少一个按时计费方案，再配置全局封顶。',
            )
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final config in candidates)
                  FilterChip(
                    label: Text(_pricingConfigTitle(config)),
                    selected: selectedIds.contains(config.id),
                    onSelected: (selected) {
                      final next = [...selectedIds];
                      if (selected) {
                        next.add(config.id);
                      } else {
                        next.remove(config.id);
                      }
                      onChanged(next.toSet().toList());
                    },
                  ),
              ],
            ),
    );
  }
}

class _PricingConfigIdLine extends StatelessWidget {
  const _PricingConfigIdLine({required this.configId, this.compact = false});

  final String configId;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final labelStyle = compact
        ? context.text.labelSmall
        : context.text.labelMedium?.copyWith(fontWeight: FontWeight.w700);
    final idStyle = compact
        ? context.text.bodySmall
        : context.text.bodyMedium?.copyWith(fontWeight: FontWeight.w700);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('计费方案 ID', style: labelStyle),
        const SizedBox(width: 8),
        Flexible(child: SelectableText(configId, maxLines: 1, style: idStyle)),
        const SizedBox(width: 4),
        Tooltip(
          message: '复制计费方案 ID',
          child: IconButton(
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.copy_all_outlined, size: 18),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: configId));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('计费方案 ID 已复制。')));
            },
          ),
        ),
      ],
    );
  }
}

class _FixedChargeEditor extends StatelessWidget {
  const _FixedChargeEditor({
    required this.label,
    required this.amount,
    required this.onAmountChanged,
  });

  final TextEditingController label;
  final num amount;
  final ValueChanged<num> onAmountChanged;

  @override
  Widget build(BuildContext context) {
    return _InlinePanel(
      icon: Icons.payments_outlined,
      title: '固定收费',
      subtitle: '每次结账都会加入一笔固定费用，适合入场费或固定服务项目。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: label,
            decoration: const InputDecoration(labelText: '账单显示名称'),
          ),
          const SizedBox(height: 12),
          DecimalNumberField(
            label: '收费金额',
            value: amount,
            min: 0,
            max: 99999,
            step: 1,
            onChanged: onAmountChanged,
          ),
        ],
      ),
    );
  }
}

class _TimelinePanel extends StatelessWidget {
  const _TimelinePanel({
    required this.timelineFuture,
    required this.cachedTimeline,
    required this.previewDate,
    required this.onDateChanged,
    required this.onRefresh,
    required this.onSegmentSelected,
    required this.selectedRuleId,
    required this.isCapTimeline,
  });

  final Future<PricingTimeline>? timelineFuture;
  final PricingTimeline? cachedTimeline;
  final DateTime previewDate;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onRefresh;
  final ValueChanged<UnitPricing> onSegmentSelected;
  final String? selectedRuleId;
  final bool isCapTimeline;

  @override
  Widget build(BuildContext context) {
    return _InlinePanel(
      icon: Icons.donut_large,
      title: '当天生效圆环',
      subtitle: isCapTimeline
          ? '灰色为空档；彩色部分按对应时段规则限制选中方案合计。'
          : '灰色为空档，空档内不能入场；彩色部分按对应时段收费。',
      child: FutureBuilder<PricingTimeline>(
        future: timelineFuture,
        builder: (context, snapshot) {
          final timeline = snapshot.data ?? cachedTimeline;
          final segments = timeline?.timeline ?? const <UnitPricing>[];
          final isRefreshing =
              snapshot.connectionState != ConnectionState.done &&
              cachedTimeline != null;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: previewDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2035),
                      );
                      if (picked != null) onDateChanged(picked);
                    },
                    icon: const Icon(Icons.event),
                    label: Text(_dateText(previewDate)),
                  ),
                  IconButton(
                    tooltip: '刷新预览',
                    onPressed: onRefresh,
                    icon: const Icon(Icons.sync),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (isRefreshing) ...[
                const LinearProgressIndicator(minHeight: 2),
                const SizedBox(height: 10),
              ],
              if (snapshot.connectionState != ConnectionState.done &&
                  cachedTimeline == null)
                const SizedBox(
                  height: 280,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (snapshot.hasError)
                const EmptyState(
                  icon: Icons.timeline,
                  title: '暂时无法生成预览',
                  message: '请检查时段是否完整，或稍后重试。',
                )
              else if (segments.isEmpty)
                const EmptyState(
                  icon: Icons.timeline,
                  title: '暂无可预览时段',
                  message: '添加计费时段后会显示一天内的收费变化。',
                )
              else ...[
                RingTimeline(
                  segments: segments,
                  selectedRuleId: selectedRuleId,
                  onSegmentSelected: onSegmentSelected,
                ),
                const SizedBox(height: 12),
                _TimelineLegend(
                  segments: segments,
                  valueLabel: isCapTimeline ? '封顶' : null,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _RuleListPanel extends StatelessWidget {
  const _RuleListPanel({
    required this.rules,
    required this.selectedIndex,
    required this.onSelect,
    required this.onAdd,
  });

  final List<_RuleDraft> rules;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final activeRules = [
      for (var index = 0; index < rules.length; index++)
        if (!rules[index].isArchived) MapEntry(index, rules[index]),
    ];
    final archivedRules = [
      for (var index = 0; index < rules.length; index++)
        if (rules[index].isArchived) MapEntry(index, rules[index]),
    ];
    return _InlinePanel(
      icon: Icons.format_list_bulleted,
      title: '计费时段',
      subtitle: '优先级数字越大越先匹配；没有覆盖的时间就是闭店空档。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (activeRules.isEmpty)
            const EmptyState(
              icon: Icons.schedule,
              title: '暂无可用时段',
              message: '恢复归档时段或新增一条时段后，这个方案才能用于结算。',
            )
          else
            for (final entry in activeRules)
              _RuleListTile(
                rule: entry.value,
                selected: entry.key == selectedIndex,
                onTap: () => onSelect(entry.key),
              ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('添加时段'),
            ),
          ),
          if (archivedRules.isNotEmpty) ...[
            const SizedBox(height: 12),
            Material(
              color: Colors.transparent,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text('归档时段（${archivedRules.length}）'),
                subtitle: const Text('这些时段不会参与结算，也不会出现在当天圆环里。'),
                children: [
                  for (final entry in archivedRules)
                    _RuleListTile(
                      rule: entry.value,
                      selected: entry.key == selectedIndex,
                      onTap: () => onSelect(entry.key),
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

class _TimelineAndRuleList extends StatelessWidget {
  const _TimelineAndRuleList({required this.timeline, required this.rules});

  final Widget timeline;
  final Widget rules;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [timeline, const SizedBox(height: 16), rules],
    );
  }
}

class _PricingEditColumn extends StatelessWidget {
  const _PricingEditColumn({required this.basics, required this.ruleForm});

  final Widget basics;
  final Widget? ruleForm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        basics,
        if (ruleForm != null) ...[const SizedBox(height: 16), ruleForm!],
      ],
    );
  }
}

class _RuleListTile extends StatelessWidget {
  const _RuleListTile({
    required this.rule,
    required this.selected,
    required this.onTap,
  });

  final _RuleDraft rule;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final archived = rule.isArchived;
    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: selected,
        leading: Icon(
          archived ? Icons.archive_outlined : Icons.schedule,
          color: archived ? context.colors.onSurfaceVariant : null,
        ),
        title: Text(rule.label),
        subtitle: Text(
          '${rule.start.format24()}-${rule.end.format24()} · ${rule.scopeLabel}',
        ),
        trailing: archived
            ? const ArchiveStatusPill(isArchived: true)
            : Text('优先级 ${rule.priority}'),
        onTap: onTap,
      ),
    );
  }
}

class _RuleForm extends StatelessWidget {
  const _RuleForm({
    required this.rule,
    required this.isCapRule,
    required this.onChanged,
    required this.onDelete,
  });

  final _RuleDraft rule;
  final bool isCapRule;
  final ValueChanged<_RuleDraft> onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return _InlinePanel(
      icon: Icons.edit_calendar,
      title: isCapRule ? '编辑封顶时段' : '编辑时段',
      subtitle: isCapRule
          ? '封顶时段只定义参与方案合计后的最高金额。'
          : '名称可以直接输入；时间和日期用选择器，金额和分钟数用数字控件。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: TextEditingController(text: rule.label)
              ..selection = TextSelection.collapsed(offset: rule.label.length),
            decoration: const InputDecoration(labelText: '时段名称'),
            onChanged: (value) => onChanged(rule.copyWith(label: value)),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (rule.scope != 'range') ...[
                OutlinedButton.icon(
                  onPressed: () => _pickTime(context, rule.start, (value) {
                    onChanged(rule.copyWith(start: value));
                  }),
                  icon: const Icon(Icons.schedule),
                  label: Text('开始 ${rule.start.format(context)}'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _pickTime(context, rule.end, (value) {
                    onChanged(rule.copyWith(end: value));
                  }),
                  icon: const Icon(Icons.schedule_send),
                  label: Text('结束 ${rule.end.format(context)}'),
                ),
              ] else
                Chip(
                  avatar: const Icon(Icons.event_repeat, size: 16),
                  label: Text(_rangeLabel(rule)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'all', label: Text('每天')),
              ButtonSegment(value: 'weekdays', label: Text('按星期')),
              ButtonSegment(value: 'date', label: Text('指定日期')),
              ButtonSegment(value: 'range', label: Text('连续日期')),
            ],
            selected: {rule.scope},
            onSelectionChanged: (value) {
              final scope = value.first;
              onChanged(
                rule.copyWith(
                  scope: scope,
                  weekdays: scope == 'weekdays' ? rule.weekdays : const [],
                  specificDate: scope == 'date'
                      ? (rule.specificDate ?? DateTime(2026, 7, 5))
                      : _clearDate,
                  specificDates: scope == 'date'
                      ? rule.specificDates
                      : const [],
                ),
              );
            },
          ),
          if (rule.scope == 'weekdays') ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final day in _weekdayChoices.entries)
                  FilterChip(
                    label: Text(day.value),
                    selected: rule.weekdays.contains(day.key),
                    onSelected: (selected) {
                      final next = [...rule.weekdays];
                      if (selected) {
                        next.add(day.key);
                      } else {
                        next.remove(day.key);
                      }
                      next.sort();
                      onChanged(rule.copyWith(weekdays: next));
                    },
                  ),
              ],
            ),
          ],
          if (rule.scope == 'date') ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                  initialDate: rule.specificDate ?? DateTime(2026, 7, 5),
                );
                if (picked != null) {
                  onChanged(rule.copyWith(specificDate: picked));
                }
              },
              icon: const Icon(Icons.event),
              label: Text(
                '日期 ${_dateText(rule.specificDate ?? DateTime(2026, 7, 5))}',
              ),
            ),
          ],
          const SizedBox(height: 14),
          StepperNumberField(
            label: '优先级',
            value: rule.priority,
            min: 0,
            max: 99,
            step: 1,
            onChanged: (value) => onChanged(rule.copyWith(priority: value)),
          ),
          if (!isCapRule) ...[
            const SizedBox(height: 12),
            StepperNumberField(
              label: '计费单位（分钟）',
              value: rule.unitMinutes,
              min: 5,
              max: 240,
              step: 5,
              onChanged: (value) =>
                  onChanged(rule.copyWith(unitMinutes: value)),
            ),
            const SizedBox(height: 12),
            DecimalNumberField(
              label: '每单位金额',
              value: rule.unitPrice,
              min: -9999,
              max: 9999,
              step: 1,
              onChanged: (value) => onChanged(rule.copyWith(unitPrice: value)),
            ),
            const SizedBox(height: 12),
            StepperNumberField(
              label: '宽限分钟',
              value: rule.graceMinutes,
              min: 0,
              max: 120,
              step: 1,
              onChanged: (value) =>
                  onChanged(rule.copyWith(graceMinutes: value)),
            ),
          ],
          const SizedBox(height: 12),
          DecimalNumberField(
            label: isCapRule ? '全局封顶金额' : '方案内封顶',
            value: rule.priceCap,
            min: 0,
            max: 99999,
            step: 1,
            onChanged: (value) => onChanged(rule.copyWith(priceCap: value)),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: onDelete,
              icon: Icon(
                rule.isArchived
                    ? Icons.unarchive_outlined
                    : rule.persisted
                    ? Icons.archive_outlined
                    : Icons.delete_outline,
              ),
              label: Text(
                rule.isArchived
                    ? '恢复时段'
                    : rule.persisted
                    ? '归档时段'
                    : '移除草稿',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime(
    BuildContext context,
    TimeOfDay initial,
    ValueChanged<TimeOfDay> onPicked,
  ) async {
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked != null) onPicked(picked);
  }

  String _rangeLabel(_RuleDraft rule) {
    final start = _dateOnly(rule.startDateTime);
    final end = _dateOnly(rule.endDateTime);
    if (start == null || end == null) return '连续日期';
    return '$start 到 $end';
  }
}

class RingTimeline extends StatelessWidget {
  const RingTimeline({
    super.key,
    required this.segments,
    required this.selectedRuleId,
    required this.onSegmentSelected,
  });

  final List<UnitPricing> segments;
  final String? selectedRuleId;
  final ValueChanged<UnitPricing> onSegmentSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, 320.0);
        return Center(
          child: Semantics(
            label: '按时计费圆环时间轴',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (details) {
                final box = context.findRenderObject() as RenderBox?;
                if (box == null) return;
                final local = box.globalToLocal(details.globalPosition);
                final center = Offset(box.size.width / 2, box.size.height / 2);
                final segment = segmentForMinute(
                  segments,
                  minuteFromPoint(local, center),
                );
                if (segment != null) onSegmentSelected(segment);
              },
              child: SizedBox.square(
                dimension: size,
                child: CustomPaint(
                  painter: RingTimelinePainter(
                    segments: segments,
                    selectedRuleId: selectedRuleId,
                    scheme: context.colors,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('24h', style: context.text.headlineSmall),
                        Text(
                          '当天预览',
                          style: context.text.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static int minuteFromPoint(Offset point, Offset center) {
    final dx = point.dx - center.dx;
    final dy = point.dy - center.dy;
    final angle = math.atan2(dy, dx);
    final normalized = (angle + math.pi / 2 + math.pi * 2) % (math.pi * 2);
    return ((normalized / (math.pi * 2)) * 1440).floor().clamp(0, 1439);
  }

  static UnitPricing? segmentForMinute(List<UnitPricing> segments, int minute) {
    for (final segment in segments) {
      if (minute >= segment.startMinute && minute < segment.endMinute) {
        return segment;
      }
      if (segment.endMinute == 1440 && minute == 1439) return segment;
    }
    return null;
  }
}

class RingTimelinePainter extends CustomPainter {
  const RingTimelinePainter({
    required this.segments,
    required this.selectedRuleId,
    required this.scheme,
  });

  final List<UnitPricing> segments;
  final String? selectedRuleId;
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 28;
    final stroke = math.max(24.0, size.width * 0.08);
    final rect = Rect.fromCircle(center: center, radius: radius);
    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt
      ..color = scheme.surfaceContainerHighest;
    canvas.drawCircle(center, radius, basePaint);

    for (var index = 0; index < segments.length; index++) {
      final segment = segments[index];
      final startMinute = segment.startMinute;
      final endMinute = segment.endMinute;
      final duration = endMinute - startMinute;
      if (duration <= 0) continue;
      final start = -math.pi / 2 + (startMinute / 1440) * math.pi * 2;
      final sweep = (duration / 1440) * math.pi * 2;
      final selected =
          selectedRuleId != null && segment.ruleId == selectedRuleId;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? stroke + 8 : stroke
        ..strokeCap = StrokeCap.butt
        ..color = _segmentColor(segment, index);
      canvas.drawArc(rect, start, sweep, false, paint);
    }

    final tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = scheme.outlineVariant;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    for (final tick in [0, 360, 720, 1080]) {
      final angle = -math.pi / 2 + (tick / 1440) * math.pi * 2;
      final direction = Offset(math.cos(angle), math.sin(angle));
      final outer = center + direction * (radius + stroke / 2 + 6);
      final inner = center + direction * (radius + stroke / 2 - 8);
      canvas.drawLine(inner, outer, tickPaint);
      textPainter.text = TextSpan(
        text: _minuteLabel(tick),
        style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11),
      );
      textPainter.layout();
      final labelPoint = center + direction * (radius + stroke / 2 + 22);
      textPainter.paint(
        canvas,
        labelPoint - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  Color _segmentColor(UnitPricing segment, int index) {
    if (segment.isClosed) return scheme.surfaceContainerHighest;
    final colors = [
      scheme.primary,
      scheme.tertiary,
      scheme.secondary,
      scheme.error,
      scheme.primaryContainer,
    ];
    return colors[index % colors.length];
  }

  @override
  bool shouldRepaint(covariant RingTimelinePainter oldDelegate) {
    return oldDelegate.segments != segments ||
        oldDelegate.selectedRuleId != selectedRuleId ||
        oldDelegate.scheme != scheme;
  }
}

class _TimelineLegend extends StatelessWidget {
  const _TimelineLegend({required this.segments, this.valueLabel});

  final List<UnitPricing> segments;
  final String? valueLabel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final segment in segments.take(8))
          Chip(
            avatar: Icon(
              segment.isClosed ? Icons.block : Icons.schedule,
              size: 16,
            ),
            label: Text(
              '${segment.startTime}-${segment.endTime} ${segment.label ?? '按时计费'}'
              '${valueLabel == null || segment.isClosed ? '' : ' · $valueLabel ${_moneyText(segment.price)}'}',
            ),
          ),
      ],
    );
  }
}

String _moneyText(num value) {
  if (value % 1 == 0) return value.toInt().toString();
  return value.toString();
}

class _InlinePanel extends StatelessWidget {
  const _InlinePanel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        border: Border.all(color: context.colors.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: context.colors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.text.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
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
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _RuleDraft {
  const _RuleDraft({
    required this.id,
    required this.label,
    required this.priority,
    required this.status,
    required this.persisted,
    required this.hasTimeRange,
    required this.start,
    required this.end,
    required this.scope,
    required this.weekdays,
    required this.specificDates,
    required this.specificDate,
    required this.startDateTime,
    required this.endDateTime,
    required this.unitMinutes,
    required this.unitPrice,
    required this.graceMinutes,
    required this.priceCap,
  });

  factory _RuleDraft.standard() => _RuleDraft(
    id: 'base',
    label: '标准营业时段',
    priority: 0,
    status: 'active',
    persisted: false,
    hasTimeRange: true,
    start: const TimeOfDay(hour: 10, minute: 0),
    end: const TimeOfDay(hour: 22, minute: 0),
    scope: 'all',
    weekdays: const [],
    specificDates: const [],
    specificDate: null,
    startDateTime: null,
    endDateTime: null,
    unitMinutes: 30,
    unitPrice: 10,
    graceMinutes: 5,
    priceCap: 80,
  );

  factory _RuleDraft.extra({required int priority}) => _RuleDraft(
    id: 'rule-${DateTime.now().microsecondsSinceEpoch}',
    label: '新增时段',
    priority: priority,
    status: 'active',
    persisted: false,
    hasTimeRange: true,
    start: const TimeOfDay(hour: 18, minute: 0),
    end: const TimeOfDay(hour: 22, minute: 0),
    scope: 'all',
    weekdays: const [],
    specificDates: const [],
    specificDate: null,
    startDateTime: null,
    endDateTime: null,
    unitMinutes: 30,
    unitPrice: 10,
    graceMinutes: 5,
    priceCap: 80,
  );

  factory _RuleDraft.fromModel(PriorityTimeRule rule) {
    final dateStrings = rule.specificDates.isNotEmpty
        ? rule.specificDates
        : [
            if (rule.specificDate != null && rule.specificDate!.isNotEmpty)
              rule.specificDate!,
          ];
    final specificDate = dateStrings.isEmpty
        ? null
        : DateTime.tryParse(dateStrings.first);
    final hasDateTimeRange =
        rule.startDateTime != null && rule.endDateTime != null;
    return _RuleDraft(
      id: rule.id.isEmpty
          ? 'rule-${DateTime.now().microsecondsSinceEpoch}'
          : rule.id,
      label: rule.label,
      priority: rule.priority,
      status: rule.status,
      persisted: true,
      hasTimeRange: rule.hasTimeRange || !hasDateTimeRange,
      start: _timeFromText(rule.startTime),
      end: _timeFromText(rule.endTime),
      scope: hasDateTimeRange && !rule.hasTimeRange
          ? 'range'
          : specificDate != null
          ? 'date'
          : rule.weekdays.isNotEmpty
          ? 'weekdays'
          : 'all',
      weekdays: rule.weekdays,
      specificDates: dateStrings,
      specificDate: specificDate,
      startDateTime: rule.startDateTime,
      endDateTime: rule.endDateTime,
      unitMinutes: rule.unitMinutes,
      unitPrice: rule.unitPrice,
      graceMinutes: rule.graceMinutes,
      priceCap: rule.priceCap ?? 0,
    );
  }

  final String id;
  final String label;
  final int priority;
  final String status;
  final bool persisted;
  final bool hasTimeRange;
  final TimeOfDay start;
  final TimeOfDay end;
  final String scope;
  final List<int> weekdays;
  final List<String> specificDates;
  final DateTime? specificDate;
  final String? startDateTime;
  final String? endDateTime;
  final int unitMinutes;
  final num unitPrice;
  final int graceMinutes;
  final num priceCap;

  String get scopeLabel {
    if (isArchived) return '已归档';
    if (scope == 'range') return '连续日期';
    if (scope == 'date') return '指定日期';
    if (scope == 'weekdays') return '按星期';
    return '每天';
  }

  bool get isArchived => status == 'archived';

  _RuleDraft copyWith({
    String? id,
    String? label,
    int? priority,
    String? status,
    bool? persisted,
    bool? hasTimeRange,
    TimeOfDay? start,
    TimeOfDay? end,
    String? scope,
    List<int>? weekdays,
    List<String>? specificDates,
    Object? specificDate = _unchanged,
    Object? startDateTime = _unchanged,
    Object? endDateTime = _unchanged,
    int? unitMinutes,
    num? unitPrice,
    int? graceMinutes,
    num? priceCap,
  }) {
    return _RuleDraft(
      id: id ?? this.id,
      label: label ?? this.label,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      persisted: persisted ?? this.persisted,
      hasTimeRange: hasTimeRange ?? this.hasTimeRange,
      start: start ?? this.start,
      end: end ?? this.end,
      scope: scope ?? this.scope,
      weekdays: weekdays ?? this.weekdays,
      specificDates: specificDates ?? this.specificDates,
      specificDate: identical(specificDate, _unchanged)
          ? this.specificDate
          : identical(specificDate, _clearDate)
          ? null
          : specificDate as DateTime?,
      startDateTime: identical(startDateTime, _unchanged)
          ? this.startDateTime
          : startDateTime as String?,
      endDateTime: identical(endDateTime, _unchanged)
          ? this.endDateTime
          : endDateTime as String?,
      unitMinutes: unitMinutes ?? this.unitMinutes,
      unitPrice: unitPrice ?? this.unitPrice,
      graceMinutes: graceMinutes ?? this.graceMinutes,
      priceCap: priceCap ?? this.priceCap,
    );
  }

  Map<String, dynamic> toJson() {
    final dates = scope == 'date'
        ? [
            if (specificDate != null) _dateText(specificDate!),
            for (final date in specificDates.skip(1)) date,
          ]
        : const <String>[];
    return {
      'id': id,
      'label': label.trim().isEmpty ? '未命名时段' : label.trim(),
      'priority': priority,
      'status': status,
      if (hasTimeRange || scope != 'range')
        'timeRange': {'start': start.format24(), 'end': end.format24()},
      if (scope == 'weekdays' && weekdays.isNotEmpty) 'weekdays': weekdays,
      if (dates.isNotEmpty) 'specificDates': dates,
      if (scope == 'range' && startDateTime != null && endDateTime != null)
        'dateTimeRange': {'start': startDateTime, 'end': endDateTime},
      'pricing': {
        'unitMinutes': unitMinutes,
        'unitPrice': unitPrice,
        'roundGraceMinutes': graceMinutes,
        'priceCap': priceCap,
      },
    };
  }
}

const _weekdayChoices = {
  1: '周一',
  2: '周二',
  3: '周三',
  4: '周四',
  5: '周五',
  6: '周六',
  7: '周日',
};

const Object _unchanged = Object();
const Object _clearDate = Object();

String _pricingConfigTitle(PricingConfig config) {
  final name = config.name.trim();
  if (name.toLowerCase().startsWith('legacy ')) return '迁移计时规则';
  if (name.isEmpty) return '未命名计费方案';
  return name;
}

String _pricingSummary(PricingConfig config) {
  final state = config.isActive ? '正在使用' : '暂未启用';
  if (config.kind == 'charge.fixed') {
    return '固定收费 · ${formatMoney(config.fixedChargeAmount)} · $state';
  }
  if (config.kind == 'time.cap') {
    return '全局封顶 · ${config.includedPricingConfigIds.length} 个参与方案 · $state';
  }
  return '${config.rules.length} 个计费时段 · $state';
}

String _dateText(DateTime value) {
  return '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}

String? _dateOnly(String? value) {
  if (value == null || value.length < 10) return null;
  return value.substring(0, 10);
}

TimeOfDay _timeFromText(String value) {
  final parts = value.split(':');
  return TimeOfDay(
    hour: (int.tryParse(parts.firstOrNull ?? '') ?? 0).clamp(0, 23),
    minute: (int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0).clamp(0, 59),
  );
}

String _minuteLabel(int minute) {
  final hour = (minute ~/ 60).toString().padLeft(2, '0');
  return '$hour:00';
}

extension _TimeOfDayFormat on TimeOfDay {
  String format24() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

class _MessageBanner extends StatelessWidget {
  const _MessageBanner({
    required this.message,
    required this.onClose,
    this.isError = false,
  });

  final String message;
  final VoidCallback onClose;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final color = isError
        ? context.colors.errorContainer
        : context.colors.secondaryContainer;
    final textColor = isError
        ? context.colors.onErrorContainer
        : context.colors.onSecondaryContainer;
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(message, style: TextStyle(color: textColor)),
            ),
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
