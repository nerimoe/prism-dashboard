import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../context_extensions.dart';
import '../../shared/widgets.dart';
import '../../theme.dart';

class OperationsScreen extends ConsumerStatefulWidget {
  const OperationsScreen({super.key, this.api});

  final PrismApiClient? api;

  @override
  ConsumerState<OperationsScreen> createState() => _OperationsScreenState();
}

class _OperationsScreenState extends ConsumerState<OperationsScreen> {
  late Future<List<LivePlayer>> _future;
  String? _selectedPlayerId;
  String? _message;

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LivePlayer>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return ScreenPadding(
            child: PrismPanel(
              title: '现场数据没有加载成功',
              subtitle: snapshot.error.toString(),
              trailing: IconButton(
                onPressed: _refresh,
                tooltip: '重试',
                icon: const Icon(Icons.refresh),
              ),
              child: const SizedBox.shrink(),
            ),
          );
        }

        final players = snapshot.data ?? const <LivePlayer>[];
        final selected = _selectedPlayer(players);
        return LayoutBuilder(
          builder: (context, viewport) {
            final pagePadding = EdgeInsets.symmetric(
              horizontal: context.isCompact ? 16 : 22,
              vertical: context.isCompact ? 16 : 20,
            );
            final useTwoPane =
                viewport.maxWidth >= 980 && viewport.maxHeight.isFinite;
            final list = _PlayerList(
              players: players,
              selected: selected,
              onSelect: (player) =>
                  setState(() => _selectedPlayerId = player.playerId),
            );
            final detail = _PlayerSessionDetail(
              player: selected,
              onStopSession: _confirmStopSession,
              onCheckoutAll: _confirmCheckoutAll,
              onManualAdjust: _showManualAdjustNotice,
            );
            final topContent = <Widget>[
              _OperationsHeader(players: players, onRefresh: _refresh),
              const SizedBox(height: 16),
              _MetricRow(players: players),
              if (_message != null) ...[
                const SizedBox(height: 12),
                _MessageBanner(
                  message: _message!,
                  onClose: () => setState(() => _message = null),
                ),
              ],
              const SizedBox(height: 16),
            ];

            if (!useTwoPane) {
              return SingleChildScrollView(
                padding: pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...topContent,
                    list,
                    const SizedBox(height: 16),
                    detail,
                  ],
                ),
              );
            }

            return Padding(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...topContent,
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 102,
                          child: LayoutBuilder(
                            builder: (context, constraints) => _PlayerList(
                              players: players,
                              selected: selected,
                              maxHeight: constraints.maxHeight,
                              onSelect: (player) => setState(
                                () => _selectedPlayerId = player.playerId,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          flex: 100,
                          child: LayoutBuilder(
                            builder: (context, constraints) =>
                                _PlayerSessionDetail(
                                  player: selected,
                                  maxHeight: constraints.maxHeight,
                                  onStopSession: _confirmStopSession,
                                  onCheckoutAll: _confirmCheckoutAll,
                                  onManualAdjust: _showManualAdjustNotice,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<List<LivePlayer>> _load() async {
    final players = await _api.listLivePlayers();
    if (_selectedPlayerId == null && players.isNotEmpty) {
      _selectedPlayerId = players.first.playerId;
    }
    return players;
  }

  LivePlayer? _selectedPlayer(List<LivePlayer> players) {
    if (players.isEmpty) return null;
    return players.firstWhere(
      (player) => player.playerId == _selectedPlayerId,
      orElse: () => players.first,
    );
  }

  void _refresh() {
    setState(() => _future = _load());
  }

  Future<void> _confirmStopSession(
    LivePlayer player,
    LiveSession session,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('停止 ${session.title}'),
        content: Text('只停这项计时，先不扣款。费用会留到 ${player.displayName} 结账时一起算。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.stop_circle),
            label: const Text('停止计时'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _api.stopPlayerSession(
        playerId: player.playerId,
        sessionId: session.id,
      );
      setState(() {
        _message = '${player.displayName} 的「${session.title}」已停表，还没扣款。';
        _future = _load();
      });
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<void> _confirmCheckoutAll(LivePlayer player) async {
    late final SettlementPreview preview;
    try {
      preview = await _api.previewAllCheckout(player.playerId);
    } catch (error) {
      setState(() => _message = error.toString());
      return;
    }
    if (!mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('结清 ${player.displayName}'),
        content: Text(
          '会把 ${player.displayName} 现在的 ${preview.sessionIds.length} 笔未结费用一起结掉，预计扣款 ${formatMoney(preview.total)}。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.receipt_long),
            label: const Text('确认结账'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _api.confirmAllCheckout(player.playerId);
      setState(() {
        _selectedPlayerId = null;
        _message = '${player.displayName} 已结账。';
        _future = _load();
      });
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<void> _showManualAdjustNotice(LivePlayer player) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('现场改价'),
        content: Text('${player.displayName} 这单暂时不能在这里改价。需要临时处理时，先线下备注差额。'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }
}

class _OperationsHeader extends StatelessWidget {
  const _OperationsHeader({required this.players, required this.onRefresh});

  final List<LivePlayer> players;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final sessions = players.fold<int>(
      0,
      (sum, player) => sum + player.sessionCount,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '现场工作台',
                style: context.text.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${players.length} 名玩家在场 · $sessions 项计时中 · 12:43 已刷新',
                style: context.text.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.end,
          children: [
            FilledButton(onPressed: onRefresh, child: const Text('给玩家加开计时')),
            OutlinedButton(onPressed: onRefresh, child: const Text('闭店统一结账')),
          ],
        ),
      ],
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.players});

  final List<LivePlayer> players;

  @override
  Widget build(BuildContext context) {
    final sessions = players.fold<int>(
      0,
      (sum, player) => sum + player.sessionCount,
    );
    final metrics = [
      _MetricBox(label: '在场玩家', value: '${players.length}'),
      _MetricBox(label: '正在计时', value: '$sessions'),
      const _MetricBox(label: '待处理服务', value: '5'),
      const _MetricBox(label: '异常设备', value: '1', danger: true),
    ];
    if (context.isCompact) {
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: metrics
            .map((metric) => SizedBox(width: 160, child: metric))
            .toList(),
      );
    }
    return Row(
      children: [
        for (var index = 0; index < metrics.length; index++) ...[
          Expanded(child: metrics[index]),
          if (index != metrics.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _MetricBox extends StatelessWidget {
  const _MetricBox({
    required this.label,
    required this.value,
    this.danger = false,
  });

  final String label;
  final String value;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.text.labelSmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: context.text.headlineSmall?.copyWith(
                color: danger ? context.colors.error : null,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerList extends StatelessWidget {
  const _PlayerList({
    required this.players,
    required this.selected,
    required this.onSelect,
    this.maxHeight,
  });

  final List<LivePlayer> players;
  final LivePlayer? selected;
  final ValueChanged<LivePlayer> onSelect;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    final rows = SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final player in players)
            _PlayerRow(
              player: player,
              selected: selected?.playerId == player.playerId,
              onTap: () => onSelect(player),
            ),
        ],
      ),
    );
    final boundedRows = maxHeight == null || !maxHeight!.isFinite
        ? rows
        : Flexible(
            fit: FlexFit.loose,
            child: Scrollbar(child: rows),
          );
    return _DeskPanel(
      key: const ValueKey('live-player-list-panel'),
      title: '在场玩家',
      maxHeight: maxHeight,
      trailing: Text(
        '点玩家看账单',
        style: context.text.bodySmall?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),
      child: players.isEmpty
          ? const EmptyState(
              icon: Icons.event_available,
              title: '现在没有玩家在场',
              message: '当玩家通过 /入场 或店员代开后，会出现在这里。',
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!context.isCompact) const _PlayerHeader(),
                boundedRows,
              ],
            ),
    );
  }
}

class _PlayerHeader extends StatelessWidget {
  const _PlayerHeader();

  @override
  Widget build(BuildContext context) {
    final style = context.text.labelMedium?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    return Container(
      color: context.colors.surfaceContainer,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text('玩家', style: style)),
          Expanded(
            flex: 2,
            child: Text('计时项', style: style, textAlign: TextAlign.end),
          ),
          Expanded(
            flex: 3,
            child: Text('在场时间', style: style, textAlign: TextAlign.end),
          ),
          Expanded(
            flex: 3,
            child: Text('现在应付', style: style, textAlign: TextAlign.end),
          ),
          Expanded(
            flex: 2,
            child: Text('状态', style: style, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}

class _PlayerRow extends StatelessWidget {
  const _PlayerRow({
    required this.player,
    required this.selected,
    required this.onTap,
  });

  final LivePlayer player;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? context.colors.primaryContainer
          : context.colors.surfaceContainerLowest,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: context.colors.outlineVariant),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          child: context.isCompact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PlayerName(player: player),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Text('${player.sessionCount} 项计时'),
                        Text(formatDurationMinutes(player.stayDurationMinutes)),
                        Text(formatMoney(player.estimatedTotal)),
                        _PlayerStatusText(player: player),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(flex: 4, child: _PlayerName(player: player)),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${player.sessionCount}',
                        textAlign: TextAlign.end,
                        style: context.text.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        formatDurationMinutes(player.stayDurationMinutes),
                        textAlign: TextAlign.end,
                        style: context.text.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        formatMoney(player.estimatedTotal),
                        textAlign: TextAlign.end,
                        style:
                            (selected
                                    ? context.text.titleMedium
                                    : context.text.bodySmall)
                                ?.copyWith(
                                  color: selected
                                      ? context.colors.primary
                                      : context.colors.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: _PlayerStatusText(player: player),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _PlayerName extends StatelessWidget {
  const _PlayerName({required this.player});
  final LivePlayer player;

  @override
  Widget build(BuildContext context) {
    final first = player.sessions.isEmpty ? null : player.sessions.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                player.displayName,
                style: context.text.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (first != null) ...[
          const SizedBox(height: 3),
          Text(
            first.entrySourceLine,
            style: context.text.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _PlayerStatusText extends StatelessWidget {
  const _PlayerStatusText({required this.player});

  final LivePlayer player;

  @override
  Widget build(BuildContext context) {
    final label = _playerStatusLabel(player);
    return Text(
      label,
      textAlign: TextAlign.end,
      style: context.text.bodySmall?.copyWith(
        color: _playerStatusColor(context, label),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _PlayerSessionDetail extends StatelessWidget {
  const _PlayerSessionDetail({
    required this.player,
    required this.onStopSession,
    required this.onCheckoutAll,
    required this.onManualAdjust,
    this.maxHeight,
  });

  final LivePlayer? player;
  final void Function(LivePlayer player, LiveSession session) onStopSession;
  final ValueChanged<LivePlayer> onCheckoutAll;
  final ValueChanged<LivePlayer> onManualAdjust;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    final value = player;
    return _DeskPanel(
      key: const ValueKey('live-player-bill-panel'),
      title: value == null ? '现场账单' : '${value.displayName} 的现场账单',
      strong: value != null,
      purpleHead: value != null,
      maxHeight: maxHeight,
      trailing: value == null
          ? null
          : Text(
              '${value.sessionCount} 项计时',
              style: context.text.bodySmall?.copyWith(
                color: context.colors.primary,
              ),
            ),
      child: value == null
          ? const EmptyState(
              icon: Icons.person_search,
              title: '先选玩家',
              message: '账单明细会显示在这里。',
            )
          : Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: context.colors.outlineVariant,
                          ),
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final compact = constraints.maxWidth < 440;
                          final facts = [
                            _SmallFact(
                              label: '可用余额',
                              value: formatMoney(value.walletTotal),
                            ),
                            _SmallFact(
                              label: '现在应付',
                              value: formatMoney(value.estimatedTotal),
                              highlighted: true,
                            ),
                            _SmallFact(
                              label: '在场时间',
                              value: formatDurationMinutes(
                                value.stayDurationMinutes,
                              ),
                            ),
                          ];
                          if (compact) {
                            return Column(
                              children: [
                                for (
                                  var index = 0;
                                  index < facts.length;
                                  index++
                                ) ...[
                                  facts[index],
                                  if (index != facts.length - 1)
                                    const SizedBox(height: 8),
                                ],
                              ],
                            );
                          }
                          return Row(
                            children: [
                              for (
                                var index = 0;
                                index < facts.length;
                                index++
                              ) ...[
                                Expanded(child: facts[index]),
                                if (index != facts.length - 1)
                                  const SizedBox(width: 10),
                              ],
                            ],
                          );
                        },
                      ),
                    ),
                    _SessionTable(
                      sessions: value.sessions,
                      onStop: (session) => onStopSession(value, session),
                    ),
                    _BillBlock(
                      player: value,
                      onCheckoutAll: () => onCheckoutAll(value),
                      onManualAdjust: () => onManualAdjust(value),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _DeskPanel extends StatelessWidget {
  const _DeskPanel({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.strong = false,
    this.purpleHead = false,
    this.maxHeight,
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final bool strong;
  final bool purpleHead;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    final panel = Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: strong
              ? const Color(0xFFD0BCFF)
              : context.colors.outlineVariant,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: purpleHead ? context.colors.primaryContainer : null,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: context.text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          Divider(
            height: 1,
            color: purpleHead
                ? Colors.transparent
                : context.colors.outlineVariant,
          ),
          if (maxHeight == null || !maxHeight!.isFinite)
            child
          else
            Flexible(fit: FlexFit.loose, child: child),
        ],
      ),
    );
    final value = maxHeight;
    if (value == null || !value.isFinite) return panel;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: value),
      child: panel,
    );
  }
}

class _SmallFact extends StatelessWidget {
  const _SmallFact({
    required this.label,
    required this.value,
    this.highlighted = false,
  });
  final String label;
  final String value;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.text.labelSmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.text.titleMedium?.copyWith(
              color: highlighted ? context.colors.primary : null,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionTable extends StatelessWidget {
  const _SessionTable({required this.sessions, required this.onStop});

  final List<LiveSession> sessions;
  final ValueChanged<LiveSession> onStop;

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: EmptyState(
          icon: Icons.timelapse,
          title: '没有正在计时的项目',
          message: '这个玩家现在没有需要停止的计时。',
        ),
      );
    }
    return Column(
      children: [
        if (!context.isCompact)
          Container(
            color: context.colors.surfaceContainer,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('计时项', style: _tableHeadStyle(context)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('收费方式', style: _tableHeadStyle(context)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '计费时长',
                    textAlign: TextAlign.end,
                    style: _tableHeadStyle(context),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '本项费用',
                    textAlign: TextAlign.end,
                    style: _tableHeadStyle(context),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '状态',
                    textAlign: TextAlign.center,
                    style: _tableHeadStyle(context),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '操作',
                    textAlign: TextAlign.end,
                    style: _tableHeadStyle(context),
                  ),
                ),
              ],
            ),
          ),
        for (final session in sessions)
          _SessionRow(session: session, onStop: () => onStop(session)),
      ],
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({required this.session, required this.onStop});

  final LiveSession session;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    final impact = session.currentImpact ?? 0;
    final impactColor = context.colors.onSurface;
    final impactText = _formatSessionImpact(session, impact);
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colors.outlineVariant)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        child: context.isCompact
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SessionName(session: session),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      Text(formatDurationMinutes(session.elapsedMinutes)),
                      Text(
                        impactText,
                        style: TextStyle(
                          color: impactColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      _StopButton(onStop: onStop),
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(flex: 3, child: _SessionName(session: session)),
                  Expanded(
                    flex: 3,
                    child: Text(
                      session.pricingRuleLabel,
                      style: context.text.bodySmall,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      formatDurationMinutes(session.elapsedMinutes),
                      textAlign: TextAlign.end,
                      style: context.text.bodySmall,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      impactText,
                      textAlign: TextAlign.end,
                      style: context.text.bodySmall?.copyWith(
                        color: impactColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '进行中',
                      textAlign: TextAlign.center,
                      style: context.text.bodySmall,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _StopButton(onStop: onStop),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _SessionName extends StatelessWidget {
  const _SessionName({required this.session});

  final LiveSession session;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          session.title,
          style: context.text.bodySmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 3),
        Text(
          session.startedLine,
          style: context.text.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _StopButton extends StatelessWidget {
  const _StopButton({required this.onStop});

  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onStop,
      style: TextButton.styleFrom(
        foregroundColor: context.colors.error,
        backgroundColor: context.colors.errorContainer.withValues(alpha: 0.42),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
      ),
      child: Text(
        '停止',
        style: context.text.labelSmall?.copyWith(
          color: context.colors.error,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _BillBlock extends StatelessWidget {
  const _BillBlock({
    required this.player,
    required this.onCheckoutAll,
    required this.onManualAdjust,
  });

  final LivePlayer player;
  final VoidCallback onCheckoutAll;
  final VoidCallback onManualAdjust;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colors.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _BillLine(label: '计时小计', value: formatMoney(player.estimatedTotal)),
          const SizedBox(height: 8),
          const _BillLine(label: '可用抵扣', value: '¥0'),
          const SizedBox(height: 10),
          Divider(color: context.colors.outlineVariant),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  '本次应扣',
                  style: context.text.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                formatMoney(player.estimatedTotal),
                style: context.text.headlineMedium?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: player.sessions.isEmpty ? null : onCheckoutAll,
                  child: Text('给 ${player.displayName} 结账'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: onManualAdjust,
                  child: const Text('现场改价'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '停掉某项计时后，费用先留在账单里，结账时一起扣。',
            style: context.text.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _BillLine extends StatelessWidget {
  const _BillLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: context.text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

TextStyle? _tableHeadStyle(BuildContext context) {
  return context.text.labelMedium?.copyWith(
    color: context.colors.onSurfaceVariant,
    fontWeight: FontWeight.w700,
  );
}

String _playerStatusLabel(LivePlayer player) {
  if (player.status == 'covered') return '月卡抵扣';
  if (player.status == 'low_balance' ||
      player.walletTotal < (player.estimatedTotal ?? 0)) {
    return '余额可能不足';
  }
  if (player.status == 'active') return '正常';
  return '暂停';
}

Color _playerStatusColor(BuildContext context, String label) {
  return switch (label) {
    '月卡抵扣' => prismSuccessColor,
    '余额可能不足' => context.colors.error,
    '正常' => prismSuccessColor,
    _ => context.colors.onSurfaceVariant,
  };
}

String _formatSessionImpact(LiveSession session, num impact) {
  if (impact > 0 && !session.title.contains('音游')) {
    return '+${formatMoney(impact)}';
  }
  return formatMoney(impact);
}

class _MessageBanner extends StatelessWidget {
  const _MessageBanner({required this.message, required this.onClose});

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.secondaryContainer,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: context.colors.onSecondaryContainer,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: context.colors.onSecondaryContainer),
              ),
            ),
            IconButton(
              onPressed: onClose,
              tooltip: '关闭',
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
