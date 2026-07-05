import 'dart:math' as math;

import 'package:flutter/material.dart';
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
                    timelineFuture: _timelineFuture(selected),
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

  Future<PricingTimeline>? _timelineFuture(PricingConfig? selected) {
    if (selected == null) {
      return _api.previewPricingTimeline(
        name: '草稿',
        kind: 'time.priority',
        localDate: _dateText(_specificDate),
        rules: [_ruleBody()],
      );
    }
    return _api.getPricingTimeline(
      selected.id,
      localDate: _dateText(_specificDate),
    );
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
          rules: _mergeDraftRule(selected),
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

  List<Map<String, dynamic>> _mergeDraftRule(PricingConfig selected) {
    final draft = _ruleBody();
    return [
      draft,
      for (final rule in selected.rules)
        if (rule.id != draft['id']) _ruleBodyFromModel(rule),
    ];
  }
}

Map<String, dynamic> _ruleBodyFromModel(PriorityTimeRule rule) {
  return {
    'id': rule.id,
    'label': rule.label,
    'priority': rule.priority,
    'status': rule.status,
    'timeRange': {'start': rule.startTime, 'end': rule.endTime},
    if (rule.weekdays.isNotEmpty) 'weekdays': rule.weekdays,
    if (rule.specificDate != null) 'specificDates': [rule.specificDate],
    if (rule.startDateTime != null && rule.endDateTime != null)
      'dateTimeRange': {'start': rule.startDateTime, 'end': rule.endDateTime},
    'pricing': {
      'unitMinutes': rule.unitMinutes,
      'unitPrice': rule.unitPrice,
      'roundGraceMinutes': rule.graceMinutes,
      'priceCap': rule.priceCap,
    },
  };
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
                    title: Text(_pricingConfigTitle(config)),
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
    required this.timelineFuture,
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
  final Future<PricingTimeline>? timelineFuture;
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
      title: selected == null ? '新计费规则' : _pricingConfigTitle(selected!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TimelinePanel(timelineFuture: timelineFuture),
          const SizedBox(height: 16),
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

class _TimelinePanel extends StatelessWidget {
  const _TimelinePanel({required this.timelineFuture});

  final Future<PricingTimeline>? timelineFuture;

  @override
  Widget build(BuildContext context) {
    return _InlinePanel(
      icon: Icons.donut_large,
      title: '当天生效圆环',
      subtitle: '灰色为空档；彩色时段表示当天可以入场并按对应规则计费。',
      child: FutureBuilder<PricingTimeline>(
        future: timelineFuture,
        builder: (context, snapshot) {
          final timeline = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              height: 280,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return const EmptyState(
              icon: Icons.timeline,
              title: '暂时无法生成预览',
              message: '请检查规则时间是否完整，或稍后重试。',
            );
          }
          final segments = timeline?.timeline ?? const <UnitPricing>[];
          if (segments.isEmpty) {
            return const EmptyState(
              icon: Icons.timeline,
              title: '暂无可预览时段',
              message: '保存或预览一条按时计费规则后，会显示当天时间轴。',
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RingTimeline(segments: segments),
              const SizedBox(height: 12),
              _TimelineLegend(segments: segments),
            ],
          );
        },
      ),
    );
  }
}

class RingTimeline extends StatelessWidget {
  const RingTimeline({super.key, required this.segments});

  final List<UnitPricing> segments;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, 320.0);
        return Center(
          child: Semantics(
            label: '按时计费圆环时间轴',
            child: SizedBox.square(
              dimension: size,
              child: CustomPaint(
                painter: RingTimelinePainter(
                  segments: segments,
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
        );
      },
    );
  }
}

class RingTimelinePainter extends CustomPainter {
  const RingTimelinePainter({required this.segments, required this.scheme});

  final List<UnitPricing> segments;
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
      final startMinute = _minuteOfClock(segment.startTime);
      final endMinute = _endMinuteOfSegment(segment);
      final duration = endMinute - startMinute;
      if (duration <= 0) continue;
      final start = -math.pi / 2 + (startMinute / 1440) * math.pi * 2;
      final sweep = (duration / 1440) * math.pi * 2;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.butt
        ..color = _segmentColor(index);
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

  Color _segmentColor(int index) {
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
    return oldDelegate.segments != segments || oldDelegate.scheme != scheme;
  }
}

class _TimelineLegend extends StatelessWidget {
  const _TimelineLegend({required this.segments});

  final List<UnitPricing> segments;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final segment in segments.take(8))
          Chip(
            avatar: const Icon(Icons.schedule, size: 16),
            label: Text(
              '${segment.startTime}-${segment.endTime} ${segment.label ?? '按时计费'}',
            ),
          ),
      ],
    );
  }
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

String _pricingConfigTitle(PricingConfig config) {
  final name = config.name.trim();
  if (name.toLowerCase().startsWith('legacy ')) return '迁移计时规则';
  if (name.isEmpty) return '未命名计费规则';
  return name;
}

String _timeText(TimeOfDay value) {
  return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}

String _dateText(DateTime value) {
  return '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}

int _minuteOfClock(String value) {
  final parts = value.split(':');
  final hour = int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 0;
  final minute = int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0;
  return (hour * 60 + minute).clamp(0, 1440);
}

int _endMinuteOfSegment(UnitPricing segment) {
  final start = _minuteOfClock(segment.startTime);
  final end = _minuteOfClock(segment.endTime);
  if (end == start) return 1440;
  if (end < start) return 1440;
  return end;
}

String _minuteLabel(int minute) {
  final hour = (minute ~/ 60).toString().padLeft(2, '0');
  return '$hour:00';
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
