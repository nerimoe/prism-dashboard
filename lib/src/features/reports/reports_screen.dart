import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../shared/admin_layout.dart';
import '../../shared/widgets.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key, this.initialToday, this.api});

  final DateTime? initialToday;
  final PrismApiClient? api;

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  late DateTimeRange _range;
  late Future<_ReportData> _future;

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  @override
  void initState() {
    super.initState();
    final today = _dateOnly(widget.initialToday ?? DateTime.now());
    _range = DateTimeRange(start: today, end: today);
    _future = _load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_ReportData>(
      future: _future,
      builder: (context, snapshot) {
        return AdminWorkspace(
          title: '营业报表',
          subtitle: '按日期查看收入、结算记录和玩家消费排行。',
          actions: [
            SegmentedButton<_RangePreset>(
              segments: const [
                ButtonSegment(
                  value: _RangePreset.today,
                  label: Text('今天'),
                  icon: Icon(Icons.today),
                ),
                ButtonSegment(
                  value: _RangePreset.sevenDays,
                  label: Text('近 7 天'),
                  icon: Icon(Icons.date_range),
                ),
              ],
              selected: {_selectedPreset},
              onSelectionChanged: (values) => _applyPreset(values.first),
            ),
            OutlinedButton.icon(
              onPressed: _pickRange,
              icon: const Icon(Icons.calendar_month),
              label: Text(_rangeLabel(_range)),
            ),
            IconButton(
              tooltip: '刷新',
              onPressed: _refresh,
              icon: const Icon(Icons.refresh),
            ),
          ],
          child: _buildBody(context, snapshot),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, AsyncSnapshot<_ReportData> snapshot) {
    final data = snapshot.data;
    if (snapshot.connectionState != ConnectionState.done && data == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return PrismPanel(
        title: '报表没有加载成功',
        subtitle: snapshot.error.toString(),
        trailing: IconButton(
          tooltip: '重试',
          onPressed: _refresh,
          icon: const Icon(Icons.refresh),
        ),
        child: const SizedBox.shrink(),
      );
    }
    if (data == null) {
      return const EmptyState(
        icon: Icons.bar_chart,
        title: '暂无报表数据',
        message: '换一个日期范围再看看。',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SummaryGrid(summary: data.summary),
        const SizedBox(height: 16),
        _SettlementTable(rows: data.settlements),
        const SizedBox(height: 16),
        _PlayerRankingTable(rows: data.players),
      ],
    );
  }

  Future<_ReportData> _load() async {
    final start = _startIso(_range.start);
    final end = _endIso(_range.end);
    final results = await Future.wait<Object>([
      _api.reportsSummary(start: start, end: end),
      _api.reportSettlements(start: start, end: end),
      _api.reportPlayers(start: start, end: end),
    ]);
    return _ReportData(
      summary: results[0] as ReportSummary,
      settlements: results[1] as List<SettlementReportRow>,
      players: results[2] as List<PlayerReportRow>,
    );
  }

  void _refresh() {
    setState(() => _future = _load());
  }

  Future<void> _pickRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDateRange: _range,
    );
    if (picked == null) return;
    setState(() {
      _range = DateTimeRange(
        start: _dateOnly(picked.start),
        end: _dateOnly(picked.end),
      );
      _future = _load();
    });
  }

  void _applyPreset(_RangePreset preset) {
    final today = _dateOnly(widget.initialToday ?? DateTime.now());
    setState(() {
      _range = switch (preset) {
        _RangePreset.today => DateTimeRange(start: today, end: today),
        _RangePreset.sevenDays => DateTimeRange(
          start: today.subtract(const Duration(days: 6)),
          end: today,
        ),
      };
      _future = _load();
    });
  }

  _RangePreset get _selectedPreset {
    final today = _dateOnly(widget.initialToday ?? DateTime.now());
    if (_range.start == today && _range.end == today) {
      return _RangePreset.today;
    }
    final sevenDaysStart = today.subtract(const Duration(days: 6));
    if (_range.start == sevenDaysStart && _range.end == today) {
      return _RangePreset.sevenDays;
    }
    return _RangePreset.today;
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.summary});

  final ReportSummary summary;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      MetricTile(
        label: '营业收入',
        value: formatMoney(summary.revenue),
        icon: Icons.payments,
      ),
      MetricTile(
        label: '已结 session',
        value: summary.settledSessionsCount.toString(),
        icon: Icons.receipt_long,
      ),
      MetricTile(
        label: '资产发放',
        value: summary.assetGrantsCount.toString(),
        icon: Icons.card_giftcard,
      ),
      MetricTile(
        label: '投币指令',
        value: summary.coinCommandsCount.toString(),
        icon: Icons.toll,
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1120
            ? 4
            : constraints.maxWidth >= 720
            ? 2
            : 1;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final tile in tiles)
              SizedBox(
                width: (constraints.maxWidth - (columns - 1) * 12) / columns,
                child: tile,
              ),
          ],
        );
      },
    );
  }
}

class _SettlementTable extends StatelessWidget {
  const _SettlementTable({required this.rows});

  final List<SettlementReportRow> rows;

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '结算明细',
      subtitle: '最近完成结算的玩家账单。',
      child: rows.isEmpty
          ? const EmptyState(
              icon: Icons.receipt_long,
              title: '还没有结算记录',
              message: '这个日期范围内还没有玩家结账。',
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('玩家')),
                  DataColumn(label: Text('游玩时长')),
                  DataColumn(label: Text('原价')),
                  DataColumn(label: Text('实收')),
                  DataColumn(label: Text('结算时间')),
                ],
                rows: [
                  for (final row in rows)
                    DataRow(
                      cells: [
                        DataCell(Text(row.displayName)),
                        DataCell(Text(_durationLabel(row.durationMinutes))),
                        DataCell(MoneyText(value: row.subtotal)),
                        DataCell(MoneyText(value: row.total)),
                        DataCell(DateTimeText(value: row.settledAt)),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}

class _PlayerRankingTable extends StatelessWidget {
  const _PlayerRankingTable({required this.rows});

  final List<PlayerReportRow> rows;

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '玩家排行',
      subtitle: '按实收金额排序，便于复盘当日主要消费。',
      child: rows.isEmpty
          ? const EmptyState(
              icon: Icons.leaderboard,
              title: '还没有玩家排行',
              message: '这个日期范围内还没有可统计的玩家。',
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('玩家')),
                  DataColumn(label: Text('结算次数')),
                  DataColumn(label: Text('累计时长')),
                  DataColumn(label: Text('实收')),
                  DataColumn(label: Text('最近结算')),
                ],
                rows: [
                  for (final row in rows)
                    DataRow(
                      cells: [
                        DataCell(Text(row.displayName)),
                        DataCell(Text('${row.settlementCount} 次')),
                        DataCell(
                          Text(_durationLabel(row.totalDurationMinutes)),
                        ),
                        DataCell(MoneyText(value: row.revenue)),
                        DataCell(DateTimeText(value: row.lastSettledAt)),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}

class _ReportData {
  const _ReportData({
    required this.summary,
    required this.settlements,
    required this.players,
  });

  final ReportSummary summary;
  final List<SettlementReportRow> settlements;
  final List<PlayerReportRow> players;
}

enum _RangePreset { today, sevenDays }

DateTime _dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);

String _startIso(DateTime date) => _dateOnly(date).toUtc().toIso8601String();

String _endIso(DateTime date) =>
    _dateOnly(date).add(const Duration(days: 1)).toUtc().toIso8601String();

String _rangeLabel(DateTimeRange range) {
  final start = _dateLabel(range.start);
  final end = _dateLabel(range.end);
  return start == end ? start : '$start 至 $end';
}

String _dateLabel(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}

String _durationLabel(int? minutes) {
  if (minutes == null) return '--';
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (hours == 0) return '$rest 分钟';
  if (rest == 0) return '$hours 小时';
  return '$hours 小时 $rest 分钟';
}
