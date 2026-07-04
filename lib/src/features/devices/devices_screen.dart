import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../shared/admin_layout.dart';
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

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  Widget build(BuildContext context) {
    return AdminWorkspace(
      title: '设备看板',
      subtitle: '查看门禁、投币控制器、读卡器和网关的在线状态与指令处理记录。',
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
              _DeviceStatePanel(devices: data.devices),
              const SizedBox(height: 16),
              _CommandAuditPanel(commands: data.commands),
            ],
          );
        },
      ),
    );
  }

  Future<_DevicesData> _load() async {
    final results = await Future.wait<Object>([
      _api.listDeviceStates(),
      _api.listDeviceCommands(),
    ]);
    return _DevicesData(
      devices: results[0] as List<DeviceState>,
      commands: results[1] as List<DeviceCommand>,
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
            label: '在线设备',
            value: data.onlineCount.toString(),
            icon: Icons.check_circle_outline,
            tone: Colors.green,
          ),
          MetricTile(
            label: '离线设备',
            value: data.offlineCount.toString(),
            icon: Icons.power_settings_new,
            tone: Colors.red,
          ),
          MetricTile(
            label: '需要关注',
            value: data.attentionCount.toString(),
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

class _DeviceStatePanel extends StatelessWidget {
  const _DeviceStatePanel({required this.devices});

  final List<DeviceState> devices;

  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty) {
      return const PrismPanel(
        title: '设备状态',
        child: EmptyState(
          icon: Icons.devices,
          title: '暂无设备上报',
          message: '网关连接后会在这里显示最新状态。',
        ),
      );
    }

    return PrismPanel(
      title: '设备状态',
      subtitle: '${devices.length} 台设备',
      child: Column(
        children: [
          for (final device in devices) ...[
            _DeviceRow(device: device),
            if (device != devices.last) const Divider(height: 24),
          ],
        ],
      ),
    );
  }
}

class _DeviceRow extends StatelessWidget {
  const _DeviceRow({required this.device});

  final DeviceState device;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device.label,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(deviceTypeLabel(device.type)),
            ],
          ),
        ),
        SizedBox(width: 120, child: _DeviceStatePill(status: device.status)),
        SizedBox(width: 160, child: Text(currentStateLabel(device.state))),
        SizedBox(
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('上报时间'),
              DateTimeText(value: device.reportedAt),
            ],
          ),
        ),
        SizedBox(width: 180, child: Text('来源 ${device.reportedBy}')),
      ],
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
        title: '设备指令',
        child: EmptyState(
          icon: Icons.receipt_long,
          title: '暂无指令记录',
          message: '玩家或员工发出的设备操作会出现在这里。',
        ),
      );
    }

    return PrismPanel(
      title: '设备指令',
      subtitle: '${commands.length} 条记录',
      child: Column(
        children: [
          for (final command in commands) ...[
            _CommandRow(command: command),
            if (command != commands.last) const Divider(height: 24),
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
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commandTypeLabel(command.commandType),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(command.deviceId),
            ],
          ),
        ),
        SizedBox(width: 160, child: Text(requesterLabel(command))),
        SizedBox(width: 110, child: _CommandStatusPill(status: command.status)),
        SizedBox(
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('发起时间'),
              DateTimeText(value: command.createdAt),
            ],
          ),
        ),
        SizedBox(width: 190, child: Text(commandFinishedLabel(command))),
      ],
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
  const _DevicesData({required this.devices, required this.commands});

  final List<DeviceState> devices;
  final List<DeviceCommand> commands;

  int get onlineCount =>
      devices.where((device) => device.status == 'online').length;
  int get offlineCount =>
      devices.where((device) => device.status == 'offline').length;
  int get attentionCount => devices
      .where(
        (device) => device.status == 'degraded' || device.status == 'unhealthy',
      )
      .length;
  int get pendingCommandCount =>
      commands.where((command) => command.status == 'pending').length;

  factory _DevicesData.empty() => const _DevicesData(devices: [], commands: []);
}

String deviceTypeLabel(String value) {
  return switch (value) {
    'door' || 'gate' => '门禁',
    'coin' => '投币',
    'scan' || 'reader' => '读卡器',
    'gateway' => '网关',
    'power' => '电源',
    _ => '设备',
  };
}

String commandTypeLabel(String value) {
  return switch (value) {
    'door' => '门禁',
    'coin' => '投币',
    'scan' => '扫码',
    'power' => '电源',
    _ => '设备操作',
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
  if (command.ackedAt != null) return '确认：${_shortDateTime(command.ackedAt)}';
  if (command.expiredAt != null) {
    return '超时：${_shortDateTime(command.expiredAt)}';
  }
  return '等待设备响应';
}

String _shortDateTime(DateTime? value) {
  if (value == null) return '--';
  final local = value.toLocal();
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '${local.month}/${local.day} $hour:$minute';
}
