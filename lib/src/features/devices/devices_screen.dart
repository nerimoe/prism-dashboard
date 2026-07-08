import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../shared/admin_layout.dart';
import '../../shared/time_format.dart';
import '../../shared/widgets.dart';

class DevicesScreen extends ConsumerStatefulWidget {
  const DevicesScreen({super.key, this.api});

  final PrismApiClient? api;

  @override
  ConsumerState<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends ConsumerState<DevicesScreen> {
  late Future<_DevicesData> _future;

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  bool get _canWrite =>
      ref.watch(appControllerProvider).value?.staff?.canWrite ??
      true;

  Future<void> _showConfigureHaDevices(BuildContext context) async {
    try {
      final rawSettings = await _api.getRawSettings();
      if (!context.mounted) return;
      final saved = await showDialog<bool>(
        context: context,
        builder: (context) => _EditHaDevicesDialog(
          api: _api,
          rawSettings: rawSettings,
        ),
      );
      if (saved == true) {
        _refresh();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载配置失败：$e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  Widget build(BuildContext context) {
    return AdminWorkspace(
      title: '设备看板',
      subtitle: '查看设施设备、游戏机器、机器软件在线状态与最近执行记录。',
      actions: [
        IconButton.filledTonal(
          tooltip: '刷新',
          onPressed: _refresh,
          icon: const Icon(Icons.refresh),
        ),
      ],
      child: FutureBuilder<_DevicesData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return PrismPanel(
              title: '设备数据没有加载成功',
              subtitle: snapshot.error.toString(),
              child: const SizedBox.shrink(),
            );
          }

          final data = snapshot.data ?? _DevicesData.empty();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DeviceSummary(data: data),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 1080;
                  final deviceGroups = Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _DeviceGroupPanel(
                        title: '设施设备',
                        subtitle: '门禁、电源、空调和灯光由 Home Assistant 或设施网关处理。',
                        icon: Icons.home_repair_service_outlined,
                        devices: data.facilityDevices,
                        emptyTitle: '暂无设施上报',
                        emptyMessage: '配置 Home Assistant 后，门禁、电源和空调状态会显示在这里。',
                        trailing: _canWrite
                            ? IconButton(
                                tooltip: '配置设备映射',
                                icon: const Icon(Icons.settings),
                                onPressed: () => _showConfigureHaDevices(context),
                              )
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _DeviceGroupPanel(
                        title: '游戏机器',
                        subtitle: '投币、Aime 和机器软件连接状态。',
                        icon: Icons.sports_esports_outlined,
                        machines: data.gameMachines,
                        emptyTitle: '暂无机器连接',
                        emptyMessage: '机器软件连接 WebSocket 后，会在这里显示在线状态和最近心跳。',
                      ),
                    ],
                  );
                  final commandPanel = _CommandAuditPanel(
                    commands: data.commands,
                  );

                  if (compact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        deviceGroups,
                        const SizedBox(height: 16),
                        commandPanel,
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: deviceGroups),
                      const SizedBox(width: 16),
                      Expanded(flex: 2, child: commandPanel),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<_DevicesData> _load() async {
    final results = await Future.wait<Object>([
      _api.listDeviceStates(),
      _api.listMachineConnections(),
      _api.listDeviceCommands(),
    ]);
    return _DevicesData(
      devices: results[0] as List<DeviceState>,
      machines: results[1] as List<MachineConnection>,
      commands: results[2] as List<DeviceCommand>,
    );
  }

  void _refresh() {
    setState(() => _future = _load());
  }
}

class _DeviceSummary extends StatelessWidget {
  const _DeviceSummary({required this.data});

  final _DevicesData data;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 900;
        final children = [
          MetricTile(
            label: '在线机器',
            value: data.onlineMachineCount.toString(),
            icon: Icons.check_circle_outline,
            tone: Colors.green,
          ),
          MetricTile(
            label: '离线机器',
            value: data.offlineMachineCount.toString(),
            icon: Icons.power_settings_new,
            tone: Colors.red,
          ),
          MetricTile(
            label: '设施异常',
            value: data.facilityAttentionCount.toString(),
            icon: Icons.warning_amber,
            tone: Colors.orange,
          ),
          MetricTile(
            label: '待执行指令',
            value: data.pendingCommandCount.toString(),
            icon: Icons.pending_actions,
            tone: Theme.of(context).colorScheme.primary,
          ),
        ];

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final child in children) ...[
                child,
                const SizedBox(height: 8),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (var index = 0; index < children.length; index++) ...[
              Expanded(child: children[index]),
              if (index != children.length - 1) const SizedBox(width: 12),
            ],
          ],
        );
      },
    );
  }
}

class _DeviceGroupPanel extends StatelessWidget {
  const _DeviceGroupPanel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.emptyTitle,
    required this.emptyMessage,
    this.devices = const [],
    this.machines = const [],
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String emptyTitle;
  final String emptyMessage;
  final List<DeviceState> devices;
  final List<MachineConnection> machines;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty && machines.isEmpty) {
      return PrismPanel(
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        child: EmptyState(icon: icon, title: emptyTitle, message: emptyMessage),
      );
    }

    return PrismPanel(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      child: Column(
        children: [
          for (final device in devices) ...[
            _DeviceCard(device: device),
            if (device != devices.last || machines.isNotEmpty)
              const SizedBox(height: 12),
          ],
          for (final machine in machines) ...[
            _MachineCard(machine: machine),
            if (machine != machines.last) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _MachineCard extends StatelessWidget {
  const _MachineCard({required this.machine});

  final MachineConnection machine;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.sports_esports_outlined,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      machine.machineId,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '机器软件 · ${machine.capabilities.isEmpty ? '暂无可执行能力' : '可执行 ${machine.capabilities.length} 项'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _DeviceStatePill(status: machine.status),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(
                icon: Icons.schedule,
                label: '最后心跳 ${formatAdminDateTime(machine.lastSeenAt)}',
              ),
              for (final capability in machine.capabilities)
                _InfoChip(
                  icon: Icons.bolt_outlined,
                  label: capabilityLabel(capability),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({required this.device});

  final DeviceState device;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isMachine = isGameMachine(device);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isMachine
                      ? Icons.sports_esports_outlined
                      : Icons.home_repair_service_outlined,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${deviceTypeLabel(device.type)} · ${executorLabel(device)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _DeviceStatePill(status: device.status),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(icon: Icons.memory_outlined, label: device.deviceId),
              _InfoChip(
                icon: Icons.info_outline,
                label: currentStateLabel(device.state),
              ),
              _InfoChip(
                icon: Icons.schedule,
                label: '上次心跳 ${formatAdminDateTime(device.reportedAt)}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommandAuditPanel extends StatelessWidget {
  const _CommandAuditPanel({required this.commands});

  final List<DeviceCommand> commands;

  @override
  Widget build(BuildContext context) {
    if (commands.isEmpty) {
      return const PrismPanel(
        title: '指令记录',
        child: EmptyState(
          icon: Icons.receipt_long,
          title: '暂无指令记录',
          message: '玩家或员工发出的设备操作会出现在这里。',
        ),
      );
    }

    return PrismPanel(
      title: '指令记录',
      subtitle: '${commands.length} 条最近记录',
      child: Column(
        children: [
          for (final command in commands.take(12)) ...[
            _CommandRow(command: command),
            if (command != commands.take(12).last) const Divider(height: 20),
          ],
        ],
      ),
    );
  }
}

class _CommandRow extends StatelessWidget {
  const _CommandRow({required this.command});

  final DeviceCommand command;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final failure = commandFailureLabel(command);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commandTypeLabel(command.commandType),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${targetLabel(command)} · ${command.deviceId}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            _CommandStatusPill(status: command.status),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _InfoChip(
              icon: Icons.person_outline,
              label: requesterLabel(command),
            ),
            _InfoChip(
              icon: Icons.schedule,
              label: '发起 ${formatAdminDateTime(command.createdAt)}',
            ),
            _InfoChip(
              icon: Icons.task_alt,
              label: commandFinishedLabel(command),
            ),
          ],
        ),
        if (failure != null) ...[
          const SizedBox(height: 8),
          Text(
            failure,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colors.error),
          ),
        ],
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colors.onSurfaceVariant),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceStatePill extends StatelessWidget {
  const _DeviceStatePill({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'online' => const StatusPill(label: '在线', color: Colors.green),
      'degraded' ||
      'unhealthy' => const StatusPill(label: '故障', color: Colors.orange),
      _ => const StatusPill(label: '离线', color: Colors.red),
    };
  }
}

class _CommandStatusPill extends StatelessWidget {
  const _CommandStatusPill({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'acked' => const StatusPill(label: '已确认', color: Colors.green),
      'expired' => const StatusPill(label: '已超时', color: Colors.red),
      _ => const StatusPill(label: '待执行', color: Colors.orange),
    };
  }
}

class _DevicesData {
  const _DevicesData({
    required this.devices,
    required this.machines,
    required this.commands,
  });

  final List<DeviceState> devices;
  final List<MachineConnection> machines;
  final List<DeviceCommand> commands;

  List<DeviceState> get facilityDevices =>
      devices.where((device) => !isGameMachine(device)).toList();
  List<MachineConnection> get gameMachines => machines;

  int get onlineMachineCount =>
      gameMachines.where((machine) => machine.status == 'online').length;
  int get offlineMachineCount =>
      gameMachines.where((machine) => machine.status != 'online').length;
  int get facilityAttentionCount => facilityDevices
      .where(
        (device) => device.status == 'degraded' || device.status == 'unhealthy',
      )
      .length;
  int get pendingCommandCount =>
      commands.where((command) => command.status == 'pending').length;

  factory _DevicesData.empty() =>
      const _DevicesData(devices: [], machines: [], commands: []);
}

String deviceTypeLabel(String value) {
  return switch (value) {
    'door.open' || 'door' || 'gate' => '门禁',
    'coin' => '投币',
    'aime.scan' || 'scan' || 'reader' => 'Aime 读卡',
    'gateway' => '网关',
    'power.on' || 'power.off' || 'power' => '电源',
    'ac.set_temperature' => '空调',
    _ => '设备',
  };
}

String commandTypeLabel(String value) {
  return switch (value) {
    'door.open' || 'door' => '打开门禁',
    'coin' => '投币',
    'aime.scan' || 'scan' => 'Aime 扫卡',
    'power.on' => '打开电源',
    'power.off' => '关闭电源',
    'ac.set_temperature' => '调整空调',
    _ => '设备操作',
  };
}

String capabilityLabel(String value) {
  return switch (value) {
    'coin' => '投币',
    'aime.scan' || 'scan' => 'Aime 扫卡',
    _ => value,
  };
}

String currentStateLabel(String? state) {
  if (state == null || state.isEmpty || state == 'unknown') return '当前状态未知';
  return switch (state) {
    'locked' => '已锁定',
    'unlocked' => '已解锁',
    'on' => '已开启',
    'off' => '已关闭',
    'slow' => '响应较慢',
    _ => '当前 $state',
  };
}

String requesterLabel(DeviceCommand command) {
  if (command.playerId != null) return '玩家 ${command.playerId}';
  if (command.staffId != null) return '员工 ${command.staffId}';
  final requester = command.requester.trim();
  return requester.isEmpty ? '系统发起' : requester;
}

String commandFinishedLabel(DeviceCommand command) {
  if (command.ackedAt != null) {
    return '完成 ${formatAdminDateTime(command.ackedAt)}';
  }
  if (command.expiredAt != null) {
    return '失败 ${formatAdminDateTime(command.expiredAt)}';
  }
  return '等待执行';
}

bool isGameMachine(DeviceState device) =>
    device.targetKind == 'game_machine' ||
    device.executorKind == 'machine_ws' ||
    device.type == 'coin' ||
    device.type == 'aime.scan' ||
    device.type == 'scan';

String executorLabel(DeviceState device) {
  if (device.executorKind == 'machine_ws' || isGameMachine(device)) {
    return '机器软件';
  }
  if (device.executorKind == 'home_assistant') return 'Home Assistant';
  return '设施网关';
}

String targetLabel(DeviceCommand command) {
  if (command.targetKind == 'game_machine' ||
      command.executorKind == 'machine_ws') {
    return '游戏机器';
  }
  return '设施设备';
}

String? commandFailureLabel(DeviceCommand command) {
  final payload = command.payload;
  if (payload == null) return null;
  final machineAck = payload['machineAck'];
  if (machineAck is Map && machineAck['message'] is String) {
    return machineAck['message'] as String;
  }
  final executorFailure = payload['executorFailure'];
  if (executorFailure is Map && executorFailure['message'] is String) {
    return executorFailure['message'] as String;
  }
  return null;
}

class _HaDeviceInput {
  _HaDeviceInput({
    required String name,
    required List<String> alias,
    required String id,
  }) : nameController = TextEditingController(text: name),
       aliasController = TextEditingController(text: alias.join(', ')),
       idController = TextEditingController(text: id);

  final TextEditingController nameController;
  final TextEditingController aliasController;
  final TextEditingController idController;

  void dispose() {
    nameController.dispose();
    aliasController.dispose();
    idController.dispose();
  }
}

class _EditHaDevicesDialog extends StatefulWidget {
  const _EditHaDevicesDialog({
    required this.api,
    required this.rawSettings,
  });

  final PrismApiClient api;
  final Map<String, dynamic> rawSettings;

  @override
  State<_EditHaDevicesDialog> createState() => _EditHaDevicesDialogState();
}

class _EditHaDevicesDialogState extends State<_EditHaDevicesDialog> {
  final List<_HaDeviceInput> _haDevices = [];
  late final TextEditingController _urlController;
  late final TextEditingController _tokenController;
  bool _obscureToken = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final conn = widget.rawSettings['homeAssistantConnection'];
    _urlController = TextEditingController(
      text: conn is Map ? (conn['url']?.toString() ?? '') : '',
    );
    _tokenController = TextEditingController(
      text: conn is Map ? (conn['token']?.toString() ?? '') : '',
    );
    final haDevices = widget.rawSettings['homeAssistantDevices'] ?? [];
    for (final dev in haDevices) {
      if (dev is Map) {
        final aliases = (dev['alias'] as List?)?.map((e) => e.toString()).toList() ?? [];
        _haDevices.add(_HaDeviceInput(
          name: dev['name']?.toString() ?? '',
          alias: aliases,
          id: dev['id']?.toString() ?? '',
        ));
      }
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _tokenController.dispose();
    for (final dev in _haDevices) {
      dev.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _error = null;
    });

    final haDevicesJson = _haDevices.map((dev) {
      final aliases = dev.aliasController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      return {
        'name': dev.nameController.text.trim(),
        'alias': aliases,
        'id': dev.idController.text.trim(),
      };
    }).toList();

    try {
      final updatedRaw = Map<String, dynamic>.from(widget.rawSettings);
      updatedRaw['homeAssistantConnection'] = {
        'url': _urlController.text.trim(),
        'token': _tokenController.text.trim(),
      };
      updatedRaw['homeAssistantDevices'] = haDevicesJson;
      await widget.api.updateRawSettings(updatedRaw);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        _saving = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AlertDialog(
      title: const Text('配置 Home Assistant 设备映射'),
      content: SizedBox(
        width: 650,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error != null) ...[
                Card(
                  color: colors.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      _error!,
                      style: TextStyle(color: colors.onErrorContainer),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Text(
                '管理绑定在系统上的物理设备。配置后，您可以在看板上直接监控这些设备，并可通过微信/QQ等机器人指令控制开关。',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 20),
              // ── Home Assistant 连接配置 ──
              Text(
                'Home Assistant 连接',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Home Assistant URL',
                  hintText: 'http://homeassistant.local:8123',
                  helperText: '支持局域网地址或公网域名（部署在远端时需填写外网可访问地址）',
                  isDense: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
              ),
              const SizedBox(height: 10),
              StatefulBuilder(
                builder: (context, setInner) {
                  return TextField(
                    controller: _tokenController,
                    obscureText: _obscureToken,
                    decoration: InputDecoration(
                      labelText: 'Long-Lived Access Token',
                      hintText: 'eyJ0eXAiOiJKV1QiLCJhb...',
                      helperText: '在 Home Assistant 的用户配置页面生成',
                      isDense: true,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.vpn_key),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureToken ? Icons.visibility_off : Icons.visibility),
                        tooltip: _obscureToken ? '显示 Token' : '隐藏 Token',
                        onPressed: () {
                          setState(() => _obscureToken = !_obscureToken);
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Divider(color: colors.outlineVariant),
              const SizedBox(height: 12),
              // ── 设备列表 ──
              Text(
                '设备映射',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              if (_haDevices.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      '暂无配置的设备，请点击下方「添加设备」进行绑定。',
                      style: TextStyle(color: colors.onSurfaceVariant.withOpacity(0.6)),
                    ),
                  ),
                )
              else
                ...List.generate(_haDevices.length, (index) {
                  final dev = _haDevices[index];
                  return Padding(
                    key: ValueKey(dev),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: colors.outlineVariant),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: dev.nameController,
                                decoration: const InputDecoration(
                                  labelText: '设备名称',
                                  hintText: '中二官拆',
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: dev.aliasController,
                                decoration: const InputDecoration(
                                  labelText: '别名 (逗号分隔)',
                                  hintText: 'chu2, gc',
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 4,
                              child: TextField(
                                controller: dev.idController,
                                style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                                decoration: const InputDecoration(
                                  labelText: 'HA 实体 ID',
                                  hintText: 'switch.cuco_cn...',
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  final removed = _haDevices.removeAt(index);
                                  removed.dispose();
                                });
                              },
                              icon: Icon(Icons.delete_outline, color: colors.error),
                              tooltip: '删除此行',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _haDevices.add(_HaDeviceInput(name: '', alias: [], id: ''));
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('添加设备'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Text('保存'),
        ),
      ],
    );
  }
}
