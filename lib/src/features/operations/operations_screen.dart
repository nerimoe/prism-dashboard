import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../context_extensions.dart';
import '../../shared/time_format.dart';
import '../../shared/widgets.dart';
import '../../theme.dart';

class OperationsScreen extends ConsumerStatefulWidget {
  const OperationsScreen({super.key, this.api, this.canWrite = true});

  final PrismApiClient? api;
  final bool canWrite;

  @override
  ConsumerState<OperationsScreen> createState() => _OperationsScreenState();
}

class _OperationsScreenState extends ConsumerState<OperationsScreen> {
  late Future<List<LivePlayer>> _future;
  String? _selectedPlayerId;
  String? _message;
  DateTime? _loadedAt;
  final Set<String> _expandedSessionIds = {};
  final Set<String> _expandedGlobalCapWindowIds = {};
  Timer? _refreshTimer;

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  @override
  void initState() {
    super.initState();
    _future = _load();
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 20),
      (_) => mounted ? _refresh() : null,
    );
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
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
              expandedSessionIds: _expandedSessionIds,
              onToggleSession: _toggleSession,
              expandedGlobalCapWindowIds: _expandedGlobalCapWindowIds,
              onToggleGlobalCapWindow: _toggleGlobalCapWindow,
              canWrite: widget.canWrite,
            );
            final topContent = <Widget>[
              _OperationsHeader(
                players: players,
                loadedAt: _loadedAt,
                onRefresh: _refresh,
                onStartSession: _showStartSessionDialog,
                onBulkCheckout: _confirmBulkCheckout,
                canWrite: widget.canWrite,
              ),
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
                                  expandedSessionIds: _expandedSessionIds,
                                  onToggleSession: _toggleSession,
                                  expandedGlobalCapWindowIds:
                                      _expandedGlobalCapWindowIds,
                                  onToggleGlobalCapWindow:
                                      _toggleGlobalCapWindow,
                                  canWrite: widget.canWrite,
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
    _loadedAt = DateTime.now();
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
    setState(() {
      _future = _load();
    });
  }

  void _toggleSession(String sessionId) {
    setState(() {
      if (!_expandedSessionIds.add(sessionId)) {
        _expandedSessionIds.remove(sessionId);
      }
    });
  }

  void _toggleGlobalCapWindow(String windowKey) {
    setState(() {
      if (!_expandedGlobalCapWindowIds.add(windowKey)) {
        _expandedGlobalCapWindowIds.remove(windowKey);
      }
    });
  }

  Future<void> _showStartSessionDialog() async {
    final results = await Future.wait<Object>([
      _api.listPlayers(),
      _api.listPricingConfigs(),
    ]);
    final players = (results[0] as List<Player>)
        .where((player) => player.status == 'active')
        .toList(growable: false);
    final pricingConfigs = (results[1] as List<PricingConfig>)
        .where((config) => !config.isArchived)
        .toList(growable: false);
    if (!mounted) return;
    if (players.isEmpty) {
      setState(() => _message = '还没有可开始计时的玩家。');
      return;
    }
    var selectedPlayer = players.firstWhere(
      (player) => player.id == _selectedPlayerId,
      orElse: () => players.first,
    );
    final labelController = TextEditingController(text: '现场加开');
    final selectedPricingConfigIds = <String>{
      for (final config
          in pricingConfigs
              .where((config) => config.kind == 'time.priority')
              .take(1))
        config.id,
    };
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('给 ${selectedPlayer.displayName} 开始计时'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<Player>(
                  initialValue: selectedPlayer,
                  decoration: const InputDecoration(labelText: '选择玩家'),
                  items: [
                    for (final player in players)
                      DropdownMenuItem(
                        value: player,
                        child: Text(player.displayName),
                      ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setDialogState(() => selectedPlayer = value);
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: labelController,
                  decoration: const InputDecoration(
                    labelText: '计时名称',
                    hintText: '例如 四口麻将、八口麻将',
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '使用的计费方案',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 8),
                if (pricingConfigs.isEmpty)
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.info_outline),
                    title: Text('还没有可用的计费方案'),
                    subtitle: Text('保存计费配置后，就可以在这里选择。'),
                  )
                else
                  for (final config in pricingConfigs)
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(_pricingConfigTitle(config)),
                      subtitle: Text(
                        '${config.rules.length} 个计费时段 · ${config.isActive ? '正在使用' : '暂未启用'}',
                      ),
                      value: selectedPricingConfigIds.contains(config.id),
                      onChanged: (selected) {
                        setDialogState(() {
                          if (selected == true) {
                            selectedPricingConfigIds.add(config.id);
                          } else {
                            selectedPricingConfigIds.remove(config.id);
                          }
                        });
                      },
                    ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: selectedPricingConfigIds.isEmpty
                  ? null
                  : () => Navigator.pop(context, true),
              child: const Text('开始计时'),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true) return;
    final player = selectedPlayer;
    final label = labelController.text.trim();
    try {
      await _api.startPlayerSession(
        player.id,
        label: label,
        pricingConfigIds: selectedPricingConfigIds.toList(),
      );
      setState(() {
        _message = '${player.displayName} 已开始计时。';
        _future = _load();
      });
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<void> _confirmBulkCheckout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('闭店统一结账'),
        content: const Text('会结清所有仍在计时的玩家，请确认已经核对现场账单。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('统一结账'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _api.bulkCheckoutActiveSessions();
      setState(() {
        _selectedPlayerId = null;
        _message = '已提交闭店统一结账。';
        _future = _load();
      });
    } catch (error) {
      setState(() => _message = error.toString());
    }
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
    final totalController = TextEditingController(
      text: (player.estimatedTotal ?? 0).toString(),
    );
    final reasonController = TextEditingController(text: '现场临时处理');
    final submitted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('现场改价'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: totalController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: '临时金额',
                prefixText: '¥ ',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: '处理原因'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('确认改价'),
          ),
        ],
      ),
    );
    if (submitted != true) return;

    final total = num.tryParse(totalController.text.trim());
    final reason = reasonController.text.trim();
    if (total == null || reason.isEmpty) {
      setState(() => _message = '请输入临时金额和处理原因。');
      return;
    }
    try {
      await _api.checkoutWithOverride(
        player.playerId,
        total: total,
        reason: reason,
      );
      setState(() {
        _selectedPlayerId = null;
        _message = '${player.displayName} 已按临时金额结账。';
        _future = _load();
      });
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }
}

class _OperationsHeader extends StatelessWidget {
  const _OperationsHeader({
    required this.players,
    required this.loadedAt,
    required this.onRefresh,
    required this.onStartSession,
    required this.onBulkCheckout,
    required this.canWrite,
  });

  final List<LivePlayer> players;
  final DateTime? loadedAt;
  final VoidCallback onRefresh;
  final VoidCallback onStartSession;
  final VoidCallback onBulkCheckout;
  final bool canWrite;

  @override
  Widget build(BuildContext context) {
    final sessions = players.fold<int>(
      0,
      (sum, player) => sum + player.activeSessionCount,
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
                '${players.length} 名玩家在场 · $sessions 项计时中 · ${loadedAt == null ? '刚刚' : formatAdminDateTime(loadedAt)} 已刷新',
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
            IconButton(
              onPressed: onRefresh,
              tooltip: '刷新',
              icon: const Icon(Icons.refresh),
            ),
            FilledButton(
              onPressed: canWrite ? onStartSession : null,
              child: const Text('给玩家加开计时'),
            ),
            OutlinedButton(
              onPressed: !canWrite || players.isEmpty ? null : onBulkCheckout,
              child: const Text('闭店统一结账'),
            ),
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
      (sum, player) => sum + player.activeSessionCount,
    );
    final estimatedTotal = players.fold<num>(
      0,
      (sum, player) => sum + (player.estimatedTotal ?? 0),
    );
    final attentionCount = players
        .where(
          (player) =>
              player.status == 'low_balance' ||
              player.status == 'negative_balance' ||
              player.status == 'needs_attention',
        )
        .length;
    final metrics = [
      _MetricBox(label: '在场玩家', value: '${players.length}'),
      _MetricBox(label: '正在计时', value: '$sessions'),
      _MetricBox(label: '当前预估', value: formatMoney(estimatedTotal)),
      _MetricBox(
        label: '需关注',
        value: '$attentionCount',
        danger: attentionCount > 0,
      ),
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
                        Text(
                          '${player.activeSessionCount} 项计时中 · ${player.sessionCount} 项费用',
                        ),
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
            '${entrySource(first.title)} · ${formatAdminDateTime(first.startedAt)}',
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
    required this.expandedSessionIds,
    required this.onToggleSession,
    required this.expandedGlobalCapWindowIds,
    required this.onToggleGlobalCapWindow,
    required this.canWrite,
    this.maxHeight,
  });

  final LivePlayer? player;
  final void Function(LivePlayer player, LiveSession session) onStopSession;
  final ValueChanged<LivePlayer> onCheckoutAll;
  final ValueChanged<LivePlayer> onManualAdjust;
  final Set<String> expandedSessionIds;
  final ValueChanged<String> onToggleSession;
  final Set<String> expandedGlobalCapWindowIds;
  final ValueChanged<String> onToggleGlobalCapWindow;
  final bool canWrite;
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
              '${value.sessionCount} 项费用',
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
                      canStop: canWrite,
                      expandedSessionIds: expandedSessionIds,
                      onToggleSession: onToggleSession,
                    ),
                    _GlobalCapWindows(
                      windows: value.globalCapWindows,
                      expandedWindowIds: expandedGlobalCapWindowIds,
                      onToggleWindow: onToggleGlobalCapWindow,
                    ),
                    _BillBlock(
                      player: value,
                      canWrite: canWrite,
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
  const _SessionTable({
    required this.sessions,
    required this.onStop,
    required this.expandedSessionIds,
    required this.onToggleSession,
    required this.canStop,
  });

  final List<LiveSession> sessions;
  final ValueChanged<LiveSession> onStop;
  final Set<String> expandedSessionIds;
  final ValueChanged<String> onToggleSession;
  final bool canStop;

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
                  child: Text('计费方案', style: _tableHeadStyle(context)),
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
          _SessionRow(
            session: session,
            onStop: () => onStop(session),
            canStop: canStop,
            expanded: expandedSessionIds.contains(session.id),
            onToggleDetails: () => onToggleSession(session.id),
          ),
      ],
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({
    required this.session,
    required this.onStop,
    required this.expanded,
    required this.onToggleDetails,
    required this.canStop,
  });

  final LiveSession session;
  final VoidCallback onStop;
  final bool expanded;
  final VoidCallback onToggleDetails;
  final bool canStop;

  @override
  Widget build(BuildContext context) {
    final impact = session.currentImpact ?? 0;
    final impactColor = context.colors.onSurface;
    final impactText = _formatSessionImpact(session, impact);
    final isActive = session.status == 'active';
    final statusText = isActive ? '进行中' : '已停止';
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colors.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
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
                          Text(_sessionDurationLabel(session)),
                          if (session.endedAt != null)
                            Text(
                              '停止 ${formatAdminDateTime(session.endedAt!)}',
                              style: context.text.bodySmall?.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          Text(
                            session.pricingSummary,
                            style: context.text.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            impactText,
                            style: TextStyle(
                              color: impactColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            statusText,
                            style: context.text.bodySmall?.copyWith(
                              color: isActive
                                  ? context.colors.onSurface
                                  : context.colors.onSurfaceVariant,
                            ),
                          ),
                          _StopButton(onStop: onStop, enabled: isActive),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(flex: 3, child: _SessionName(session: session)),
                      Expanded(
                        flex: 3,
                        child: _SessionPricingSummary(session: session),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          _sessionDurationLabel(session),
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
                          statusText,
                          textAlign: TextAlign.center,
                          style: context.text.bodySmall?.copyWith(
                            color: isActive
                                ? context.colors.onSurface
                                : context.colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _StopButton(
                            onStop: onStop,
                            enabled: isActive && canStop,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          if (session.pricingSegments.isNotEmpty ||
              session.pricingCharges.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: onToggleDetails,
                icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                label: Text(expanded ? '收起计费明细' : '查看计费明细'),
              ),
            ),
          if (expanded)
            _SessionPricingSegments(segments: session.pricingSegments),
        ],
      ),
    );
  }
}

class _SessionPricingSegments extends StatelessWidget {
  const _SessionPricingSegments({required this.segments});

  final List<LivePricingSegment> segments;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      color: context.colors.surfaceContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (segments.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text('计费明细暂不可用'),
            )
          else
            for (final segment in segments)
              _PricingSegmentRow(segment: segment),
        ],
      ),
    );
  }
}

class _PricingSegmentRow extends StatelessWidget {
  const _PricingSegmentRow({required this.segment});

  final LivePricingSegment segment;

  @override
  Widget build(BuildContext context) {
    final durationMinutes = segment.actualEndedAt
        .difference(segment.actualStartedAt)
        .inMinutes;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${segment.planName} · ${segment.ruleLabel}',
                  style: context.text.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '实际计费：${formatAdminDateTime(segment.actualStartedAt)} 至 ${formatAdminDateTime(segment.actualEndedAt)} · ${formatDurationMinutes(durationMinutes)}',
                  style: context.text.bodySmall,
                ),
                Text(
                  '规则时段：${_ruleTimeRangeLabel(segment.ruleTimeRange)}',
                  style: context.text.bodySmall,
                ),
                if (segment.intervalCapReached) ...[
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '区间内封顶 ${formatMoney(segment.intervalCap)} · 已达到',
                      style: context.text.labelSmall,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '本段费用 ${formatMoney(segment.amount)}',
            style: context.text.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlobalCapWindows extends StatelessWidget {
  const _GlobalCapWindows({
    required this.windows,
    required this.expandedWindowIds,
    required this.onToggleWindow,
  });

  final List<LiveGlobalCapWindow> windows;
  final Set<String> expandedWindowIds;
  final ValueChanged<String> onToggleWindow;

  @override
  Widget build(BuildContext context) {
    if (windows.isEmpty) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colors.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Text(
              '跨项目封顶',
              style: context.text.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          for (final window in windows)
            _GlobalCapWindowRow(
              window: window,
              expanded: expandedWindowIds.contains(window.key),
              onToggle: () => onToggleWindow(window.key),
            ),
        ],
      ),
    );
  }
}

class _GlobalCapWindowRow extends StatelessWidget {
  const _GlobalCapWindowRow({
    required this.window,
    required this.expanded,
    required this.onToggle,
  });

  final LiveGlobalCapWindow window;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final title =
        '${formatAdminDate(window.windowStartedAt)} ${window.ruleLabel}';
    final range =
        '${formatAdminDateTime(window.windowStartedAt)} 至 ${formatAdminDateTime(window.windowEndedAt)}';
    final result =
        '历史已计入 ${formatMoney(window.paidBefore)} · 本次参与金额 ${formatMoney(window.currentAmount)} · 封顶至 ${formatMoney(window.priceCap)} · 本次计入 ${formatMoney(window.amountApplied)}';
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colors.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: onToggle,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      Text(range, style: context.text.bodySmall),
                      Text(result, style: context.text.bodySmall),
                    ],
                  ),
                ),
                Icon(expanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
          if (expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '参与项目：${window.contributions.map((item) => '${item.sessionId} ${formatMoney(item.amount)}').join('、')}',
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SessionPricingSummary extends StatelessWidget {
  const _SessionPricingSummary({required this.session});

  final LiveSession session;

  @override
  Widget build(BuildContext context) {
    if (session.pricingCharges.isEmpty) {
      return Text(
        session.pricingSummary,
        style: context.text.bodySmall?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final charge in session.pricingCharges.take(3))
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: _PricingChargeLine(charge: charge),
          ),
        if (session.pricingCharges.length > 3)
          Text(
            '还有 ${session.pricingCharges.length - 3} 项',
            style: context.text.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

class _PricingChargeLine extends StatelessWidget {
  const _PricingChargeLine({required this.charge});

  final LivePricingCharge charge;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                charge.planName,
                style: context.text.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                softWrap: true,
              ),
              if ((charge.ruleLabel ?? '').trim().isNotEmpty)
                Text(
                  charge.ruleLabel!.trim(),
                  style: context.text.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                  softWrap: true,
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          _formatChargeAmount(charge.amount),
          style: context.text.bodySmall?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
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
          session.endedAt == null
              ? '${formatAdminDateTime(session.startedAt)} 开始'
              : '${formatAdminDateTime(session.startedAt)} 开始 · 停止 ${formatAdminDateTime(session.endedAt!)}',
          style: context.text.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _StopButton extends StatelessWidget {
  const _StopButton({required this.onStop, required this.enabled});

  final VoidCallback onStop;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onStop : null,
      style: TextButton.styleFrom(
        foregroundColor: enabled
            ? context.colors.error
            : context.colors.onSurfaceVariant,
        backgroundColor: enabled
            ? context.colors.errorContainer.withValues(alpha: 0.42)
            : context.colors.surfaceContainerHighest,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
      ),
      child: Text(
        enabled ? '停止' : '待结账',
        style: context.text.labelSmall?.copyWith(
          color: enabled
              ? context.colors.error
              : context.colors.onSurfaceVariant,
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
    required this.canWrite,
  });

  final LivePlayer player;
  final VoidCallback onCheckoutAll;
  final VoidCallback onManualAdjust;
  final bool canWrite;

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
                  onPressed: !canWrite || player.sessions.isEmpty
                      ? null
                      : onCheckoutAll,
                  child: Text('给 ${player.displayName} 结账'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: canWrite ? onManualAdjust : null,
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

String _sessionDurationLabel(LiveSession session) {
  return formatDurationMinutes(session.elapsedMinutes);
}

String _formatChargeAmount(num amount) {
  if (amount > 0) return '+${formatMoney(amount)}';
  return formatMoney(amount);
}

String _ruleTimeRangeLabel(Map<String, dynamic>? range) {
  final start = range?['start']?.toString();
  final end = range?['end']?.toString();
  if (start == null || end == null || start.isEmpty || end.isEmpty) {
    return '--';
  }
  return '$start 至 ${_clockMinutes(end) <= _clockMinutes(start) ? '次日 ' : ''}$end';
}

int _clockMinutes(String value) {
  final parts = value.split(':');
  if (parts.length != 2) return 0;
  final hour = int.tryParse(parts[0]) ?? 0;
  final minute = int.tryParse(parts[1]) ?? 0;
  return hour * 60 + minute;
}

String _pricingConfigTitle(PricingConfig config) {
  final name = config.name.trim();
  if (name.toLowerCase().startsWith('legacy ')) return '迁移计时规则';
  if (name.isEmpty) return '未命名计费规则';
  return name;
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
