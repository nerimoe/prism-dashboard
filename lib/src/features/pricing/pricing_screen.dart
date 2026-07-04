import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
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
  String? _message;
  TimeOfDay _start = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _end = const TimeOfDay(hour: 22, minute: 0);
  DateTime _specificDate = DateTime(2026, 7, 5);
  int _unitMinutes = 30;
  int _unitPrice = 10;
  int _graceMinutes = 5;
  int _priceCap = 80;

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
        final selected = _selectedConfig(data.configs);
        return AdminWorkspace(
          title: '计费配置',
          subtitle: '配置按时收费规则，并预览一天内的价格变化。',
          actions: [
            FilledButton.icon(
              onPressed: () => _saveConfig(null),
              icon: const Icon(Icons.save),
              label: const Text('保存规则'),
            ),
            OutlinedButton.icon(
              onPressed: _previewDraft,
              icon: const Icon(Icons.timeline),
              label: const Text('预览草稿'),
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
                AdminSplitPane(
                  hasSelection: selected != null,
                  list: _PricingList(
                    configs: data.configs,
                    selectedId: selected?.id,
                    extensions: data.extensions,
                    onSelect: (config) =>
                        setState(() => _selectedId = config.id),
                    onArchive: _archiveConfig,
                    onRestore: _restoreConfig,
                  ),
                  detail: _PricingEditor(
                    selected: selected,
                    start: _start,
                    end: _end,
                    specificDate: _specificDate,
                    unitMinutes: _unitMinutes,
                    unitPrice: _unitPrice,
                    graceMinutes: _graceMinutes,
                    priceCap: _priceCap,
                    onPickStart: () => _pickTime(isStart: true),
                    onPickEnd: () => _pickTime(isStart: false),
                    onPickDate: _pickDate,
                    onUnitMinutesChanged: (value) =>
                        setState(() => _unitMinutes = value),
                    onUnitPriceChanged: (value) =>
                        setState(() => _unitPrice = value),
                    onGraceMinutesChanged: (value) =>
                        setState(() => _graceMinutes = value),
                    onPriceCapChanged: (value) =>
                        setState(() => _priceCap = value),
                    onPreview: _previewDraft,
                    onSave: () => _saveConfig(selected),
                  ),
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
    return configs.firstWhere(
      (config) => config.id == _selectedId,
      orElse: () => configs.first,
    );
  }

  void _refresh() {
    setState(() => _future = _load());
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
      initialDate: _specificDate,
    );
    if (result != null) setState(() => _specificDate = result);
  }

  Future<void> _previewDraft() async {
    try {
      final timeline = await _api.previewPricingTimeline(
        name: '草稿',
        kind: 'time.priority',
        localDate: _dateText(_specificDate),
        rules: [_ruleBody()],
      );
      setState(() => _message = '已生成 ${timeline.timeline.length} 段预览。');
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<void> _saveConfig(PricingConfig? selected) async {
    try {
      if (selected == null) {
        final created = await _api.createPricingConfig(
          name: '按时计费',
          kind: 'time.priority',
          rules: [_ruleBody()],
        );
        setState(() => _selectedId = created.id);
      } else {
        await _api.updatePricingConfig(
          selected.id,
          name: selected.name,
          rules: [_ruleBody()],
          isActive: true,
        );
      }
      setState(() {
        _message = '计费规则已保存。';
        _future = _load();
      });
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<void> _archiveConfig(PricingConfig config) async {
    await _api.archivePricingConfig(config.id);
    setState(() {
      _message = '计费规则已归档。';
      _future = _load();
    });
  }

  Future<void> _restoreConfig(PricingConfig config) async {
    await _api.restorePricingConfig(config.id);
    setState(() {
      _message = '计费规则已恢复。';
      _future = _load();
    });
  }

  Map<String, dynamic> _ruleBody() {
    return {
      'id': 'base',
      'label': '基础按时计费',
      'priority': 0,
      'startTime': _timeText(_start),
      'endTime': _timeText(_end),
      'specificDate': _dateText(_specificDate),
      'weekdays': [1, 2, 3, 4, 5, 6, 7],
      'unitMinutes': _unitMinutes,
      'unitPrice': _unitPrice,
      'graceMinutes': _graceMinutes,
      'priceCap': _priceCap,
    };
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
    required this.extensions,
    required this.onSelect,
    required this.onArchive,
    required this.onRestore,
  });

  final List<PricingConfig> configs;
  final String? selectedId;
  final List<Map<String, dynamic>> extensions;
  final ValueChanged<PricingConfig> onSelect;
  final ValueChanged<PricingConfig> onArchive;
  final ValueChanged<PricingConfig> onRestore;

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '计费规则',
      subtitle: '扩展能力 ${extensions.length} 项',
      child: configs.isEmpty
          ? const EmptyState(
              icon: Icons.tune,
              title: '暂无计费配置',
              message: '保存一条按时计费规则后，会显示在这里。',
            )
          : Column(
              children: [
                for (final config in configs)
                  ListTile(
                    selected: config.id == selectedId,
                    title: Text(config.name),
                    subtitle: Text('${config.rules.length} 条规则'),
                    onTap: () => onSelect(config),
                    trailing: Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ArchiveStatusPill(isArchived: config.isArchived),
                        TextButton(
                          onPressed: () => config.isArchived
                              ? onRestore(config)
                              : onArchive(config),
                          child: Text(config.isArchived ? '恢复' : '归档'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}

class _PricingEditor extends StatelessWidget {
  const _PricingEditor({
    required this.selected,
    required this.start,
    required this.end,
    required this.specificDate,
    required this.unitMinutes,
    required this.unitPrice,
    required this.graceMinutes,
    required this.priceCap,
    required this.onPickStart,
    required this.onPickEnd,
    required this.onPickDate,
    required this.onUnitMinutesChanged,
    required this.onUnitPriceChanged,
    required this.onGraceMinutesChanged,
    required this.onPriceCapChanged,
    required this.onPreview,
    required this.onSave,
  });

  final PricingConfig? selected;
  final TimeOfDay start;
  final TimeOfDay end;
  final DateTime specificDate;
  final int unitMinutes;
  final int unitPrice;
  final int graceMinutes;
  final int priceCap;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;
  final VoidCallback onPickDate;
  final ValueChanged<int> onUnitMinutesChanged;
  final ValueChanged<int> onUnitPriceChanged;
  final ValueChanged<int> onGraceMinutesChanged;
  final ValueChanged<int> onPriceCapChanged;
  final VoidCallback onPreview;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AdminDetailPanel(
      title: selected?.name ?? '新计费规则',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OutlinedButton.icon(
                onPressed: onPickStart,
                icon: const Icon(Icons.schedule),
                label: Text('开始 ${start.format(context)}'),
              ),
              OutlinedButton.icon(
                onPressed: onPickEnd,
                icon: const Icon(Icons.schedule_send),
                label: Text('结束 ${end.format(context)}'),
              ),
              OutlinedButton.icon(
                onPressed: onPickDate,
                icon: const Icon(Icons.event),
                label: Text('生效日 ${_dateText(specificDate)}'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'time',
                label: Text('按时计费'),
                icon: Icon(Icons.timer),
              ),
            ],
            selected: const {'time'},
          ),
          const SizedBox(height: 16),
          StepperNumberField(
            label: '计费单位（分钟）',
            value: unitMinutes,
            min: 5,
            max: 240,
            step: 5,
            onChanged: onUnitMinutesChanged,
          ),
          const SizedBox(height: 12),
          StepperNumberField(
            label: '每单位价格',
            value: unitPrice,
            min: 0,
            max: 999,
            step: 1,
            onChanged: onUnitPriceChanged,
          ),
          const SizedBox(height: 12),
          StepperNumberField(
            label: '宽限分钟',
            value: graceMinutes,
            min: 0,
            max: 60,
            step: 1,
            onChanged: onGraceMinutesChanged,
          ),
          const SizedBox(height: 12),
          StepperNumberField(
            label: '单日封顶',
            value: priceCap,
            min: 0,
            max: 9999,
            step: 5,
            onChanged: onPriceCapChanged,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            children: [
              FilledButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.save),
                label: const Text('保存规则'),
              ),
              OutlinedButton.icon(
                onPressed: onPreview,
                icon: const Icon(Icons.timeline),
                label: const Text('预览草稿'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _timeText(TimeOfDay value) {
  return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}

String _dateText(DateTime value) {
  return '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
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
