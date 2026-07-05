import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../context_extensions.dart';
import '../../shared/admin_layout.dart';
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
  String _searchQuery = '';
  int _detailRefreshToken = 0;

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
        final filteredPlayers = _filterPlayers(players);
        final selected = _selectedPlayer(filteredPlayers);

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
                  players: filteredPlayers,
                  totalCount: players.length,
                  selectedPlayerId: selected?.id,
                  searchQuery: _searchQuery,
                  isLoading: snapshot.connectionState != ConnectionState.done,
                  error: snapshot.error,
                  onRefresh: _refresh,
                  onSearchChanged: (value) =>
                      setState(() => _searchQuery = value),
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
                        refreshToken: _detailRefreshToken,
                        onStatusChange: _changePlayerStatus,
                        onBindIdentity: _showBindIdentityDialog,
                        onDeleteIdentity: _deletePlayerIdentity,
                        onGrantAsset: () => _showAssetDialog(
                          selected,
                          mode: _AssetChangeMode.grant,
                        ),
                        onAdjustAsset: (holding) => _showAssetDialog(
                          selected,
                          mode: _AssetChangeMode.adjust,
                          holding: holding,
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

  List<Player> _filterPlayers(List<Player> players) {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return players;
    return players.where((player) {
      final searchable = [
        player.displayName,
        player.status,
        player.walletTotal.toString(),
        for (final identity in player.identities) identity.provider,
        for (final identity in player.identities) identity.subject,
      ].join(' ').toLowerCase();
      return searchable.contains(query);
    }).toList();
  }

  void _refresh() {
    setState(() => _playersFuture = _loadPlayers());
  }

  Future<void> _changePlayerStatus(Player player, String status) async {
    try {
      await _api.updatePlayerStatus(player.id, status: status);
      setState(() {
        _message = '${player.displayName} 的状态已更新。';
        _detailRefreshToken++;
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
                setState(() {
                  _message = '${player.displayName} 的身份已绑定。';
                  _detailRefreshToken++;
                  _playersFuture = _loadPlayers();
                });
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

  Future<void> _deletePlayerIdentity(
    Player player,
    PlayerIdentity identity,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除身份绑定'),
        content: Text(
          '删除 ${_identityProviderLabel(identity.provider)} ${identity.subject} 后，这个号码或卡号将不再指向 ${player.displayName}。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除绑定'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _api.deletePlayerIdentity(
        player.id,
        provider: identity.provider,
        subject: identity.subject,
      );
      setState(() {
        _message = '${player.displayName} 的身份绑定已删除。';
        _detailRefreshToken++;
        _playersFuture = _loadPlayers();
      });
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<void> _showAssetDialog(
    Player player, {
    required _AssetChangeMode mode,
    AssetHolding? holding,
  }) async {
    final definitions = await _api.listAssetDefinitions();
    final availableDefinitions = definitions
        .where((definition) => !definition.isArchived)
        .toList();
    if (!mounted) return;
    if (availableDefinitions.isEmpty) {
      setState(() => _message = '还没有可用资产，请先在资产与礼包里添加资产。');
      return;
    }

    final amountSeed = mode == _AssetChangeMode.grant ? '10' : '-1';
    final amountController = TextEditingController(text: amountSeed);
    final reasonController = TextEditingController(
      text: mode == _AssetChangeMode.grant ? '店员补发' : '店员调整',
    );
    final title = mode == _AssetChangeMode.grant ? '发放资产' : '调整资产';
    final forcedKey = holding == null
        ? null
        : _assetDefinitionKey(holding.assetType, holding.assetCode);
    var selectedKey =
        forcedKey ??
        _assetDefinitionKey(
          availableDefinitions.first.type,
          availableDefinitions.first.code,
        );
    final selectedHoldingName =
        holding?.assetName ??
        _definitionNameForKey(availableDefinitions, forcedKey);

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('$title：${player.displayName}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (mode == _AssetChangeMode.adjust && holding != null)
                  _SelectedAssetPreview(
                    name: selectedHoldingName ?? '店内资产',
                    amount: holding.amount,
                  )
                else
                  DropdownButtonFormField<String>(
                    initialValue: selectedKey,
                    decoration: const InputDecoration(labelText: '选择资产'),
                    items: [
                      for (final definition in availableDefinitions)
                        DropdownMenuItem(
                          value: _assetDefinitionKey(
                            definition.type,
                            definition.code,
                          ),
                          child: Text(_assetDefinitionLabel(definition)),
                        ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setDialogState(() => selectedKey = value);
                    },
                  ),
                const SizedBox(height: 12),
                TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: mode == _AssetChangeMode.grant ? '发放数量' : '调整数量',
                    helperText: mode == _AssetChangeMode.adjust
                        ? '扣减请填写负数，例如 -1'
                        : null,
                  ),
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
                final reason = reasonController.text.trim();
                if (amount == null || reason.isEmpty) return;
                final parts = _splitAssetDefinitionKey(selectedKey);
                Navigator.pop(context);
                try {
                  if (mode == _AssetChangeMode.grant) {
                    await _api.grantAssets(
                      player.id,
                      assetType: parts.$1,
                      assetCode: parts.$2,
                      amount: amount,
                      reason: reason,
                    );
                  } else {
                    await _api.adjustAssets(
                      player.id,
                      assetType: parts.$1,
                      assetCode: parts.$2,
                      amount: amount,
                      reason: reason,
                    );
                  }
                  setState(() {
                    _message = '${player.displayName} 的资产已处理。';
                    _detailRefreshToken++;
                    _playersFuture = _loadPlayers();
                  });
                } catch (error) {
                  setState(() => _message = error.toString());
                }
              },
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}

enum _AssetChangeMode { grant, adjust }

class _PlayerTable extends StatelessWidget {
  const _PlayerTable({
    required this.players,
    required this.totalCount,
    required this.selectedPlayerId,
    required this.searchQuery,
    required this.isLoading,
    required this.error,
    required this.onRefresh,
    required this.onSearchChanged,
    required this.onSelect,
  });

  final List<Player> players;
  final int totalCount;
  final String? selectedPlayerId;
  final String searchQuery;
  final bool isLoading;
  final Object? error;
  final VoidCallback onRefresh;
  final ValueChanged<String> onSearchChanged;
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

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '玩家名册',
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        searchQuery.trim().isEmpty
                            ? '$totalCount 名玩家'
                            : '找到 ${players.length} 名玩家',
                        style: context.text.bodySmall?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: '刷新',
                  onPressed: onRefresh,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              key: const ValueKey('player-search-field'),
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: '搜索昵称、QQ、卡号或余额',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (players.isEmpty)
              EmptyState(
                icon: searchQuery.trim().isEmpty
                    ? Icons.group_off
                    : Icons.person_search,
                title: searchQuery.trim().isEmpty ? '暂无玩家' : '没有匹配玩家',
                message: searchQuery.trim().isEmpty
                    ? '添加玩家后，会显示在这里。'
                    : '换个昵称、QQ 或卡号再试试。',
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 560),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: players.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return _PlayerListItem(
                      player: player,
                      selected: player.id == selectedPlayerId,
                      onTap: () => onSelect(player),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PlayerListItem extends StatelessWidget {
  const _PlayerListItem({
    required this.player,
    required this.selected,
    required this.onTap,
  });

  final Player player;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final identity = _primaryIdentityLabel(player.identities);
    return Material(
      color: selected
          ? context.colors.primaryContainer.withValues(alpha: 0.42)
          : context.colors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: selected
                  ? context.colors.primary.withValues(alpha: 0.38)
                  : context.colors.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _PlayerAvatar(name: player.displayName, size: 38),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.text.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          identity ?? '还没有绑定身份',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.text.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MoneyText(value: player.walletTotal),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  PresenceStatusPill(isPresent: player.activeSessionId != null),
                  PlayerStatusPill(status: player.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  const _PlayerAvatar({required this.name, required this.size});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final trimmed = name.trim();
    final initial = trimmed.isEmpty ? '?' : trimmed.substring(0, 1);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colors.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Text(
        initial,
        style: context.text.titleMedium?.copyWith(
          color: context.colors.onPrimaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PlayerDetail extends StatefulWidget {
  const _PlayerDetail({
    super.key,
    required this.player,
    required this.api,
    required this.refreshToken,
    required this.onStatusChange,
    required this.onBindIdentity,
    required this.onDeleteIdentity,
    required this.onGrantAsset,
    required this.onAdjustAsset,
  });

  final Player player;
  final PrismApiClient api;
  final int refreshToken;
  final Future<void> Function(Player, String) onStatusChange;
  final Future<void> Function(Player) onBindIdentity;
  final Future<void> Function(Player, PlayerIdentity) onDeleteIdentity;
  final VoidCallback onGrantAsset;
  final ValueChanged<AssetHolding> onAdjustAsset;

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
    if (oldWidget.player.id != widget.player.id ||
        oldWidget.refreshToken != widget.refreshToken) {
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
          title: '玩家详情',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PlayerDetailHero(
                player: player,
                sessions: data?.sessions,
                onAllow: () => widget.onStatusChange(player, 'active'),
                onDisable: () => widget.onStatusChange(player, 'disabled'),
                onBan: () => widget.onStatusChange(player, 'banned'),
              ),
              const SizedBox(height: 18),
              _SummaryGrid(
                items: [
                  _SummaryItem(
                    label: '钱包余额',
                    value: formatMoney(player.walletTotal),
                    icon: Icons.account_balance_wallet,
                  ),
                  _SummaryItem(
                    label: '到店状态',
                    value: _presenceLabel(data?.sessions),
                    icon: Icons.storefront,
                  ),
                  _SummaryItem(
                    label: '计时项',
                    value: _activeSessionCount(data?.sessions),
                    icon: Icons.timer,
                  ),
                  _SummaryItem(
                    label: '在场时长',
                    value: formatDurationMinutes(player.stayDurationMinutes),
                    icon: Icons.schedule,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _DetailSection(
                icon: Icons.link,
                title: '身份绑定',
                action: FilledButton.icon(
                  onPressed: () => widget.onBindIdentity(player),
                  icon: const Icon(Icons.add_link),
                  label: const Text('绑定身份'),
                ),
                child: _IdentityList(
                  identities: player.identities,
                  onDelete: (identity) =>
                      widget.onDeleteIdentity(player, identity),
                ),
              ),
              const SizedBox(height: 12),
              _DetailSection(
                icon: Icons.account_balance_wallet,
                title: '钱包资产',
                action: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: widget.onGrantAsset,
                      icon: const Icon(Icons.add_card),
                      label: const Text('发放资产'),
                    ),
                  ],
                ),
                child: snapshot.connectionState != ConnectionState.done
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : snapshot.hasError
                    ? const EmptyState(
                        icon: Icons.cloud_off,
                        title: '资产和记录暂时没有加载成功',
                        message: '请稍后刷新，或检查后台服务是否正在运行。',
                      )
                    : _AssetList(
                        assets: data?.assets,
                        onAdjust: widget.onAdjustAsset,
                      ),
              ),
              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError) ...[
                const SizedBox(height: 12),
                _LedgerList(assets: data?.assets),
                const SizedBox(height: 12),
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

class _PlayerDetailHero extends StatelessWidget {
  const _PlayerDetailHero({
    required this.player,
    required this.sessions,
    required this.onAllow,
    required this.onDisable,
    required this.onBan,
  });

  final Player player;
  final List<LiveSession>? sessions;
  final VoidCallback onAllow;
  final VoidCallback onDisable;
  final VoidCallback onBan;

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
              _PlayerAvatar(name: player.displayName, size: 52),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        PresenceStatusPill(
                          isPresent:
                              sessions?.any(
                                (session) => session.status == 'active',
                              ) ??
                              player.activeSessionId != null,
                        ),
                        PlayerStatusPill(status: player.status),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: onAllow,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('允许入场'),
              ),
              OutlinedButton.icon(
                onPressed: onDisable,
                icon: const Icon(Icons.pause_circle_outline),
                label: const Text('停用账号'),
              ),
              OutlinedButton.icon(
                onPressed: onBan,
                icon: const Icon(Icons.block),
                label: const Text('暂停使用'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem {
  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.items});

  final List<_SummaryItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 520 ? 2 : 1;
        final width = (constraints.maxWidth - (columns - 1) * 8) / columns;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final item in items)
              SizedBox(
                width: width,
                child: _SummaryTile(item: item),
              ),
          ],
        );
      },
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.item});

  final _SummaryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        border: Border.all(color: context.colors.outlineVariant),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(item.icon, size: 18, color: context.colors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: context.text.labelSmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.icon,
    required this.title,
    required this.child,
    this.action,
  });

  final IconData icon;
  final String title;
  final Widget child;
  final Widget? action;

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
          _SectionTitle(icon: icon, title: title, action: action),
          child,
        ],
      ),
    );
  }
}

class _AssetList extends StatelessWidget {
  const _AssetList({required this.assets, required this.onAdjust});

  final PlayerAssets? assets;
  final ValueChanged<AssetHolding> onAdjust;

  @override
  Widget build(BuildContext context) {
    final holdings = assets?.holdings ?? const <AssetHolding>[];
    if (holdings.isEmpty) {
      return const EmptyState(
        icon: Icons.account_balance_wallet,
        title: '暂无可用资产',
        message: '发放余额、券或通行权益后，会显示在这里。',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < holdings.length; index++) ...[
          _AssetHoldingTile(
            holding: holdings[index],
            onAdjust: () => onAdjust(holdings[index]),
          ),
          if (index != holdings.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _IdentityList extends StatelessWidget {
  const _IdentityList({required this.identities, required this.onDelete});

  final List<PlayerIdentity> identities;
  final ValueChanged<PlayerIdentity> onDelete;

  @override
  Widget build(BuildContext context) {
    if (identities.isEmpty) {
      return const EmptyState(
        icon: Icons.link_off,
        title: '暂无身份绑定',
        message: '绑定 QQ、扫码或卡号后，店员和机器人都能识别这名玩家。',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < identities.length; index++) ...[
          _IdentityTile(
            identity: identities[index],
            onDelete: () => onDelete(identities[index]),
          ),
          if (index != identities.length - 1) const SizedBox(height: 8),
        ],
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
    return _DetailSection(
      icon: Icons.receipt_long,
      title: '资产流水',
      child: ledger.isEmpty
          ? const EmptyState(
              icon: Icons.receipt_long,
              title: '暂无资产流水',
              message: '充值、发券或调整资产后，会显示在这里。',
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var index = 0; index < ledger.take(6).length; index++) ...[
                  _LedgerEntryTile(entry: ledger[index]),
                  if (index != ledger.take(6).length - 1)
                    const SizedBox(height: 8),
                ],
              ],
            ),
    );
  }
}

class _SessionHistoryList extends StatelessWidget {
  const _SessionHistoryList({required this.sessions});

  final List<LiveSession> sessions;

  @override
  Widget build(BuildContext context) {
    return _DetailSection(
      icon: Icons.history,
      title: '计时记录',
      child: sessions.isEmpty
          ? const EmptyState(
              icon: Icons.history,
              title: '暂无计时记录',
              message: '玩家入场或店员代开后，会显示计时历史。',
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (
                  var index = 0;
                  index < sessions.take(6).length;
                  index++
                ) ...[
                  _SessionTile(session: sessions[index]),
                  if (index != sessions.take(6).length - 1)
                    const SizedBox(height: 8),
                ],
              ],
            ),
    );
  }
}

class _IdentityTile extends StatelessWidget {
  const _IdentityTile({required this.identity, required this.onDelete});

  final PlayerIdentity identity;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return _InfoTile(
      icon: Icons.link,
      title: _identityProviderLabel(identity.provider),
      subtitle: identity.subject,
      trailing: IconButton(
        tooltip: '删除绑定',
        onPressed: onDelete,
        icon: const Icon(Icons.delete_outline),
      ),
    );
  }
}

class _AssetHoldingTile extends StatelessWidget {
  const _AssetHoldingTile({required this.holding, required this.onAdjust});

  final AssetHolding holding;
  final VoidCallback onAdjust;

  @override
  Widget build(BuildContext context) {
    return _InfoTile(
      icon: _assetIcon(holding.assetType),
      title: holding.assetName ?? _assetTypeLabel(holding.assetType),
      subtitle: _assetTypeLabel(holding.assetType),
      trailing: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            holding.amount.toString(),
            style: context.text.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          OutlinedButton.icon(
            onPressed: onAdjust,
            icon: const Icon(Icons.tune),
            label: const Text('调整'),
          ),
        ],
      ),
    );
  }
}

class _LedgerEntryTile extends StatelessWidget {
  const _LedgerEntryTile({required this.entry});

  final AssetLedgerEntry entry;

  @override
  Widget build(BuildContext context) {
    final direction = entry.direction == 'out' ? '-' : '+';
    return _InfoTile(
      icon: entry.direction == 'out'
          ? Icons.remove_circle_outline
          : Icons.add_circle_outline,
      title: entry.assetName ?? _assetTypeLabel(entry.assetType),
      subtitle:
          '${_ledgerReasonLabel(entry.reason)} · ${formatClock(entry.createdAt)}',
      trailing: Text(
        '$direction${entry.amount}',
        style: context.text.titleSmall?.copyWith(
          color: entry.direction == 'out'
              ? context.colors.error
              : context.colors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session});

  final LiveSession session;

  @override
  Widget build(BuildContext context) {
    return _InfoTile(
      icon: Icons.timer,
      title: session.title,
      subtitle:
          '${formatClock(session.startedAt)} · ${formatDurationMinutes(session.elapsedMinutes)}',
      trailing: _SmallStatusPill(label: _sessionStatusLabel(session.status)),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        border: Border.all(color: context.colors.outlineVariant),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.colors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          trailing,
        ],
      ),
    );
  }
}

class _SmallStatusPill extends StatelessWidget {
  const _SmallStatusPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: context.text.labelSmall?.copyWith(
          color: context.colors.onSecondaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SelectedAssetPreview extends StatelessWidget {
  const _SelectedAssetPreview({required this.name, required this.amount});

  final String name;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return _InfoTile(
      icon: Icons.account_balance_wallet,
      title: name,
      subtitle: '当前数量 $amount',
      trailing: const SizedBox.shrink(),
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

String _sessionStatusLabel(String status) => switch (status) {
  'active' => '进行中',
  'closed' => '待结算',
  'settled' => '已结清',
  _ => '已结束',
};

String _identityProviderLabel(String provider) =>
    switch (provider.toLowerCase()) {
      'qq' => 'QQ',
      'scan' => '扫码',
      'aime' => 'Aime',
      _ => provider,
    };

String _assetDefinitionKey(String type, String code) => '$type\n$code';

(String, String) _splitAssetDefinitionKey(String key) {
  final parts = key.split('\n');
  return (parts.first, parts.length > 1 ? parts[1] : '');
}

String _assetDefinitionLabel(AssetDefinition definition) {
  return '${definition.displayName} · ${_assetTypeLabel(definition.type)}';
}

String? _definitionNameForKey(List<AssetDefinition> definitions, String? key) {
  if (key == null) return null;
  for (final definition in definitions) {
    if (_assetDefinitionKey(definition.type, definition.code) == key) {
      return definition.displayName;
    }
  }
  return null;
}

String _assetTypeLabel(String type) => switch (type.toLowerCase()) {
  'currency' => '余额资产',
  'ticket' => '券',
  'pass' => '通行权益',
  _ => '店内资产',
};

IconData _assetIcon(String type) => switch (type.toLowerCase()) {
  'currency' => Icons.account_balance_wallet,
  'ticket' => Icons.confirmation_number_outlined,
  'pass' => Icons.workspace_premium_outlined,
  _ => Icons.inventory_2_outlined,
};

String? _primaryIdentityLabel(List<PlayerIdentity> identities) {
  if (identities.isEmpty) return null;
  final qq = identities.where(
    (identity) => identity.provider.toLowerCase() == 'qq',
  );
  final identity = qq.isEmpty ? identities.first : qq.first;
  return '${_identityProviderLabel(identity.provider)} ${identity.subject}';
}

String _ledgerReasonLabel(String reason) {
  if (reason.startsWith('legacy.')) return '迁移记录';
  return reason;
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
