import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../shared/admin_layout.dart';
import '../../shared/admin_tables.dart';
import '../../shared/widgets.dart';

class PlayersScreen extends ConsumerStatefulWidget {
  const PlayersScreen({super.key, this.api});

  final PrismApiClient? api;

  @override
  ConsumerState<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends ConsumerState<PlayersScreen> {
  late Future<List<Player>> _playersFuture;
  String? _selectedPlayerId;
  String? _message;

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  @override
  void initState() {
    super.initState();
    _playersFuture = _loadPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
      future: _playersFuture,
      builder: (context, snapshot) {
        final players = snapshot.data ?? const <Player>[];
        final selected = _selectedPlayer(players);

        return AdminWorkspace(
          title: '玩家档案',
          subtitle: '查看玩家状态、余额、身份来源、资产流水和到店记录。',
          actions: [
            FilledButton.icon(
              onPressed: _showCreatePlayerDialog,
              icon: const Icon(Icons.person_add),
              label: const Text('添加玩家'),
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
              AdminSplitPane(
                hasSelection: selected != null,
                onBack: () => setState(() => _selectedPlayerId = null),
                list: _PlayerTable(
                  players: players,
                  selectedPlayerId: selected?.id,
                  isLoading: snapshot.connectionState != ConnectionState.done,
                  error: snapshot.error,
                  onRefresh: _refresh,
                  onSelect: (player) =>
                      setState(() => _selectedPlayerId = player.id),
                ),
                detail: selected == null
                    ? const AdminDetailPanel(
                        title: '玩家详情',
                        child: EmptyState(
                          icon: Icons.person_search,
                          title: '还没有选中玩家',
                          message: '从左侧选择一名玩家后，可以处理身份、资产和记录。',
                        ),
                      )
                    : _PlayerDetail(
                        key: ValueKey(selected.id),
                        player: selected,
                        api: _api,
                        onStatusChange: _changePlayerStatus,
                        onBindIdentity: _showBindIdentityDialog,
                        onGrantAsset: () => _showAssetDialog(
                          selected,
                          mode: _AssetChangeMode.grant,
                        ),
                        onAdjustAsset: () => _showAssetDialog(
                          selected,
                          mode: _AssetChangeMode.adjust,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<Player>> _loadPlayers() async {
    final players = await _api.listPlayers();
    if (_selectedPlayerId == null && players.isNotEmpty) {
      _selectedPlayerId = players.first.id;
    }
    return players;
  }

  Player? _selectedPlayer(List<Player> players) {
    if (players.isEmpty) return null;
    return players.firstWhere(
      (player) => player.id == _selectedPlayerId,
      orElse: () => players.first,
    );
  }

  void _refresh() {
    setState(() => _playersFuture = _loadPlayers());
  }

  Future<void> _changePlayerStatus(Player player, String status) async {
    try {
      await _api.updatePlayerStatus(player.id, status: status);
      setState(() {
        _message = '${player.displayName} 的状态已更新。';
        _playersFuture = _loadPlayers();
      });
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<void> _showCreatePlayerDialog() async {
    final displayNameController = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加玩家'),
        content: TextField(
          controller: displayNameController,
          decoration: const InputDecoration(
            labelText: '玩家昵称',
            hintText: '例如 A',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              final name = displayNameController.text.trim();
              if (name.isEmpty) return;
              Navigator.pop(context);
              await _createPlayer(name);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _createPlayer(String displayName) async {
    try {
      final player = await _api.createPlayer(displayName: displayName);
      setState(() {
        _selectedPlayerId = player.id;
        _message = '已添加 $displayName。';
        _playersFuture = _loadPlayers();
      });
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<void> _showBindIdentityDialog(Player player) async {
    final sourceController = TextEditingController(text: 'qq');
    final externalIdController = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('绑定 ${player.displayName} 的身份'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: sourceController,
              decoration: const InputDecoration(
                labelText: '身份来源',
                hintText: '例如 QQ、扫码、Aime',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: externalIdController,
              decoration: const InputDecoration(
                labelText: '外部编号',
                hintText: '输入群号、QQ 号或卡号',
              ),
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
              final source = sourceController.text.trim();
              final externalId = externalIdController.text.trim();
              if (source.isEmpty || externalId.isEmpty) return;
              Navigator.pop(context);
              try {
                await _api.bindPlayerIdentity(
                  player.id,
                  provider: source,
                  subject: externalId,
                );
                setState(() => _message = '${player.displayName} 的身份已绑定。');
              } catch (error) {
                setState(() => _message = error.toString());
              }
            },
            child: const Text('绑定'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAssetDialog(
    Player player, {
    required _AssetChangeMode mode,
  }) async {
    final typeController = TextEditingController(text: 'currency');
    final codeController = TextEditingController(text: 'paid');
    final amountController = TextEditingController(
      text: mode == _AssetChangeMode.grant ? '10' : '-10',
    );
    final reasonController = TextEditingController(
      text: mode == _AssetChangeMode.grant ? '店员补发' : '店员调整',
    );
    final title = mode == _AssetChangeMode.grant ? '发放资产' : '调整资产';

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$title：${player.displayName}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: '资产类型'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: '资产代码'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: '数量'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(labelText: '处理原因'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              final amount = num.tryParse(amountController.text.trim());
              if (amount == null) return;
              Navigator.pop(context);
              try {
                if (mode == _AssetChangeMode.grant) {
                  await _api.grantAssets(
                    player.id,
                    assetType: typeController.text.trim(),
                    assetCode: codeController.text.trim(),
                    amount: amount,
                    reason: reasonController.text.trim(),
                  );
                } else {
                  await _api.adjustAssets(
                    player.id,
                    assetType: typeController.text.trim(),
                    assetCode: codeController.text.trim(),
                    amount: amount,
                    reason: reasonController.text.trim(),
                  );
                }
                setState(() => _message = '${player.displayName} 的资产已处理。');
              } catch (error) {
                setState(() => _message = error.toString());
              }
            },
            child: Text(title),
          ),
        ],
      ),
    );
  }
}

enum _AssetChangeMode { grant, adjust }

class _PlayerTable extends StatelessWidget {
  const _PlayerTable({
    required this.players,
    required this.selectedPlayerId,
    required this.isLoading,
    required this.error,
    required this.onRefresh,
    required this.onSelect,
  });

  final List<Player> players;
  final String? selectedPlayerId;
  final bool isLoading;
  final Object? error;
  final VoidCallback onRefresh;
  final ValueChanged<Player> onSelect;

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return PrismPanel(
        title: '玩家列表没有加载成功',
        subtitle: error.toString(),
        trailing: IconButton(
          tooltip: '重试',
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh),
        ),
        child: const SizedBox.shrink(),
      );
    }

    return AdminTablePanel(
      title: '玩家列表',
      subtitle: '按玩家查看余额、状态和当前到店情况。',
      headers: const ['玩家', '在场', '账号', '余额'],
      itemCount: players.length,
      isLoading: isLoading,
      isEmpty: players.isEmpty && !isLoading,
      emptyIcon: Icons.group_off,
      emptyMessage: '还没有玩家档案。',
      trailing: IconButton(
        tooltip: '刷新',
        onPressed: onRefresh,
        icon: const Icon(Icons.refresh),
      ),
      rowBuilder: (context, index) {
        final player = players[index];
        final selected = player.id == selectedPlayerId;
        return Material(
          color: selected
              ? Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.32)
              : Colors.transparent,
          child: InkWell(
            onTap: () => onSelect(player),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      player.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: PresenceStatusPill(
                      isPresent: player.activeSessionId != null,
                    ),
                  ),
                  Expanded(child: PlayerStatusPill(status: player.status)),
                  Expanded(child: MoneyText(value: player.walletTotal)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PlayerDetail extends StatefulWidget {
  const _PlayerDetail({
    super.key,
    required this.player,
    required this.api,
    required this.onStatusChange,
    required this.onBindIdentity,
    required this.onGrantAsset,
    required this.onAdjustAsset,
  });

  final Player player;
  final PrismApiClient api;
  final Future<void> Function(Player, String) onStatusChange;
  final Future<void> Function(Player) onBindIdentity;
  final VoidCallback onGrantAsset;
  final VoidCallback onAdjustAsset;

  @override
  State<_PlayerDetail> createState() => _PlayerDetailState();
}

class _PlayerDetailState extends State<_PlayerDetail> {
  late Future<({PlayerAssets assets, List<LiveSession> sessions})> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  void didUpdateWidget(covariant _PlayerDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.player.id != widget.player.id) {
      _future = _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;
    return FutureBuilder<({PlayerAssets assets, List<LiveSession> sessions})>(
      future: _future,
      builder: (context, snapshot) {
        final data = snapshot.data;
        return AdminDetailPanel(
          title: player.displayName,
          actions: [PlayerStatusPill(status: player.status)],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionTitle(
                icon: Icons.badge,
                title: '基本信息',
                action: Wrap(
                  spacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => widget.onStatusChange(player, 'active'),
                      child: const Text('允许入场'),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          widget.onStatusChange(player, 'disabled'),
                      child: const Text('停用账号'),
                    ),
                    OutlinedButton(
                      onPressed: () => widget.onStatusChange(player, 'banned'),
                      child: const Text('暂停使用'),
                    ),
                  ],
                ),
              ),
              _InfoRow(label: '钱包余额', value: formatMoney(player.walletTotal)),
              _InfoRow(label: '当前状态', value: _presenceLabel(data?.sessions)),
              _InfoRow(
                label: '当前计时项',
                value: _activeSessionCount(data?.sessions),
              ),
              _InfoRow(
                label: '在场时长',
                value: formatDurationMinutes(player.stayDurationMinutes),
              ),
              const SizedBox(height: 18),
              _SectionTitle(
                icon: Icons.link,
                title: '身份绑定',
                action: FilledButton.icon(
                  onPressed: () => widget.onBindIdentity(player),
                  icon: const Icon(Icons.add_link),
                  label: const Text('绑定身份'),
                ),
              ),
              const Text('可把 QQ、扫码、Aime 等来源绑定到同一名玩家。'),
              const SizedBox(height: 18),
              _SectionTitle(
                icon: Icons.account_balance_wallet,
                title: '钱包资产',
                action: Wrap(
                  spacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: widget.onGrantAsset,
                      icon: const Icon(Icons.add_card),
                      label: const Text('发放资产'),
                    ),
                    OutlinedButton.icon(
                      onPressed: widget.onAdjustAsset,
                      icon: const Icon(Icons.tune),
                      label: const Text('调整资产'),
                    ),
                  ],
                ),
              ),
              if (snapshot.connectionState != ConnectionState.done)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (snapshot.hasError)
                Text('资产和记录没有加载成功：${snapshot.error}')
              else ...[
                _AssetList(assets: data?.assets),
                const SizedBox(height: 18),
                _LedgerList(assets: data?.assets),
                const SizedBox(height: 18),
                _SessionHistoryList(sessions: data?.sessions ?? const []),
              ],
            ],
          ),
        );
      },
    );
  }

  Future<({PlayerAssets assets, List<LiveSession> sessions})> _load() async {
    final assets = await widget.api.getPlayerAssets(widget.player.id);
    final sessions = await widget.api.getPlayerSessionHistory(widget.player.id);
    return (assets: assets, sessions: sessions);
  }

  String _presenceLabel(List<LiveSession>? sessions) {
    if (sessions == null) {
      return widget.player.activeSessionId == null ? '离店' : '在场';
    }
    return sessions.any((session) => session.status == 'active') ? '在场' : '离店';
  }

  String _activeSessionCount(List<LiveSession>? sessions) {
    final count = sessions
        ?.where((session) => session.status == 'active')
        .length;
    if (count == null) {
      return widget.player.activeSessionId == null ? '0 项' : '至少 1 项';
    }
    return '$count 项';
  }
}

class _AssetList extends StatelessWidget {
  const _AssetList({required this.assets});

  final PlayerAssets? assets;

  @override
  Widget build(BuildContext context) {
    final holdings = assets?.holdings ?? const <AssetHolding>[];
    if (holdings.isEmpty) return const Text('暂时没有可用资产。');
    return Column(
      children: [
        for (final holding in holdings)
          _InfoRow(
            label:
                holding.assetName ??
                '${holding.assetType}/${holding.assetCode}',
            value: holding.amount.toString(),
          ),
      ],
    );
  }
}

class _LedgerList extends StatelessWidget {
  const _LedgerList({required this.assets});

  final PlayerAssets? assets;

  @override
  Widget build(BuildContext context) {
    final ledger = assets?.ledger ?? const <AssetLedgerEntry>[];
    if (ledger.isEmpty) return const Text('暂无资产流水。');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(icon: Icons.receipt_long, title: '资产流水'),
        for (final entry in ledger.take(5))
          _InfoRow(
            label: entry.assetName == null
                ? entry.reason
                : '${entry.assetName} · ${entry.reason}',
            value: '${entry.direction == 'out' ? '-' : '+'}${entry.amount}',
          ),
      ],
    );
  }
}

class _SessionHistoryList extends StatelessWidget {
  const _SessionHistoryList({required this.sessions});

  final List<LiveSession> sessions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(icon: Icons.history, title: '计时记录'),
        if (sessions.isEmpty)
          const Text('还没有历史计时记录。')
        else if (sessions.any((session) => session.status == 'active')) ...[
          const Text('正在进行的计时项'),
          const SizedBox(height: 4),
          for (final session in sessions.where(
            (session) => session.status == 'active',
          ))
            _InfoRow(
              label: session.title,
              value: '${formatDurationMinutes(session.elapsedMinutes)} · 进行中',
            ),
          const SizedBox(height: 10),
          const Text('最近计时记录'),
        ],
        if (sessions.isNotEmpty)
          for (final session in sessions.take(6))
            _InfoRow(
              label: session.title,
              value: '${formatClock(session.startedAt)} · ${session.status}',
            ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.title, this.action});

  final IconData icon;
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          if (action != null) ...[
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerLeft, child: action!),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
