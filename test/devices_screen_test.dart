import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/features/devices/devices_screen.dart';
import 'package:prism_dashboard/src/shared/admin_time_zone.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  testWidgets('read-only staff cannot send device commands', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildDevicesScreen(requests, canWrite: false));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(FilledButton, '开门'), findsNothing);
    expect(find.widgetWithText(FilledButton, '投币'), findsNothing);
    expect(requests.where((request) => request.method == 'POST'), isEmpty);
  });

  testWidgets('device dashboard separates facilities and game machines', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildDevicesScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('设备看板'), findsOneWidget);
    expect(find.text('设施设备'), findsOneWidget);
    expect(find.text('游戏机器'), findsOneWidget);
    expect(find.text('在线机器'), findsOneWidget);
    expect(find.text('离线机器'), findsOneWidget);
    expect(find.text('设施异常'), findsOneWidget);
    expect(find.text('前门闸机'), findsOneWidget);
    expect(find.text('maimai-dx-1'), findsOneWidget);
    expect(find.text('chunithm-2'), findsOneWidget);
    expect(find.text('机厅空调'), findsOneWidget);
    expect(find.text('音游区电源'), findsOneWidget);
    expect(find.textContaining('已锁定'), findsOneWidget);
    expect(find.textContaining('已开启'), findsOneWidget);
    expect(find.text('开'), findsOneWidget);
    expect(find.text('关'), findsOneWidget);
    expect(find.text('在线'), findsWidgets);
    expect(find.text('离线'), findsOneWidget);
    expect(find.text('故障'), findsOneWidget);
    expect(find.textContaining('机器软件'), findsWidgets);
    expect(find.textContaining('可执行 2 项'), findsOneWidget);
    expect(find.text('Aime 扫卡'), findsWidgets);
    expect(find.textContaining('Home Assistant'), findsWidgets);
    expect(
      find.textContaining(_expectedDateTime('2026-07-04T12:35:00.000Z')),
      findsOneWidget,
    );
    expect(find.textContaining('metadata'), findsNothing);
    expect(find.textContaining('agent'), findsNothing);
    expect(find.textContaining('locked'), findsNothing);

    await tester.ensureVisible(find.text('关'));
    await tester.tap(find.text('关'));
    await tester.pumpAndSettle();

    final powerRequest = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/device-actions',
    );
    expect(jsonDecode(powerRequest.body), {
      'type': 'power.off',
      'target': {'kind': 'facility', 'id': 'switch.wacca'},
      'payload': {'state': 'off'},
    });
    expect(find.text('音游区电源 关机指令已发送'), findsOneWidget);
  });

  testWidgets('command audit renders staff-facing statuses and times', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildDevicesScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('指令记录'), findsOneWidget);
    expect(find.text('打开门禁'), findsOneWidget);
    expect(find.text('投币'), findsWidgets);
    expect(find.text('Aime 扫卡'), findsWidgets);
    expect(find.text('待执行'), findsOneWidget);
    expect(find.text('已确认'), findsOneWidget);
    expect(find.text('已超时'), findsOneWidget);
    expect(find.text('玩家 player-1'), findsWidgets);
    expect(find.text('员工 staff-1'), findsOneWidget);
    expect(find.text('所有设备'), findsOneWidget);
    expect(find.textContaining('null'), findsNothing);
    expect(find.text('coin controller timeout'), findsOneWidget);
    expect(
      find.text('完成 ${_expectedDateTime('2026-07-04T12:31:03.000Z')}'),
      findsOneWidget,
    );
    expect(
      find.text('失败 ${_expectedDateTime('2026-07-04T12:33:00.000Z')}'),
      findsOneWidget,
    );
    expect(find.textContaining('7/'), findsNothing);
    expect(find.textContaining('payload'), findsNothing);

    expect(
      requests.any(
        (request) =>
            request.method == 'GET' &&
            request.url.path == '/rpc/staff/device-states',
      ),
      true,
    );
    expect(
      requests.any(
        (request) =>
            request.method == 'GET' &&
            request.url.path == '/rpc/staff/machine-connections',
      ),
      true,
    );
    expect(
      requests.any(
        (request) =>
            request.method == 'GET' &&
            request.url.path == '/rpc/staff/device-commands',
      ),
      true,
    );
  });

  testWidgets('facility controls support doors and air conditioners', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildDevicesScreen(requests));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.widgetWithText(FilledButton, '开门'));
    await tester.tap(find.widgetWithText(FilledButton, '开门'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.widgetWithText(OutlinedButton, '设置温度'));
    await tester.tap(find.widgetWithText(OutlinedButton, '设置温度'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '目标温度（°C）'), '22');
    await tester.tap(find.text('发送指令'));
    await tester.pumpAndSettle();

    final actions = requests
        .where(
          (request) =>
              request.method == 'POST' &&
              request.url.path == '/rpc/staff/device-actions',
        )
        .map((request) => jsonDecode(request.body))
        .toList();
    expect(actions, [
      {
        'type': 'door.open',
        'target': {'kind': 'facility', 'id': 'door-1'},
      },
      {
        'type': 'ac.set_temperature',
        'target': {'kind': 'facility', 'id': 'climate.main'},
        'payload': {'temperature': 22},
      },
    ]);
  });

  testWidgets('online game machines expose their reported actions', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildDevicesScreen(requests));
    await tester.pumpAndSettle();

    final coin = find.widgetWithText(FilledButton, '投币');
    await tester.ensureVisible(coin);
    await tester.tap(coin);
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/device-actions',
    );
    expect(jsonDecode(request.body), {
      'type': 'coin',
      'target': {'kind': 'game_machine', 'id': 'maimai-dx-1'},
      'payload': {'count': 1},
    });
  });
}

Widget _buildDevicesScreen(List<http.Request> requests, {bool? canWrite}) {
  final api = PrismApiClient(
    baseUrl: 'https://prism.example',
    token: 'staff-token',
    httpClient: MockClient((request) async {
      requests.add(request);
      return http.Response(
        jsonEncode(_responseFor(request)),
        200,
        headers: {'content-type': 'application/json'},
      );
    }),
  );

  return ProviderScope(
    overrides: [apiClientProvider.overrideWithValue(api)],
    child: MaterialApp(
      theme: buildPrismDashboardTheme(
        ColorScheme.fromSeed(seedColor: prismSeedColor),
      ),
      home: Scaffold(body: DevicesScreen(canWrite: canWrite)),
    ),
  );
}

Map<String, dynamic> _responseFor(http.Request request) {
  final path = request.url.path;
  if (path == '/rpc/staff/device-states') {
    return {
      'deviceStates': [
        {
          'deviceId': 'door-1',
          'type': 'door.open',
          'targetKind': 'facility',
          'executorKind': 'home_assistant',
          'label': '前门闸机',
          'status': 'online',
          'state': 'locked',
          'metadata': {'battery': 91},
          'reportedAt': '2026-07-04T12:35:00.000Z',
          'reportedBy': 'agent-front',
        },
        {
          'deviceId': 'climate.main',
          'type': 'ac.set_temperature',
          'targetKind': 'facility',
          'executorKind': 'home_assistant',
          'label': '机厅空调',
          'status': 'degraded',
          'state': 'slow',
          'metadata': null,
          'reportedAt': '2026-07-04T12:32:00.000Z',
          'reportedBy': 'ha-main',
        },
        {
          'deviceId': 'switch.wacca',
          'type': 'switch',
          'targetKind': 'facility',
          'executorKind': 'home_assistant',
          'label': '音游区电源',
          'status': 'online',
          'state': '{"state":"on"}',
          'metadata': null,
          'reportedAt': '2026-07-04T12:36:00.000Z',
          'reportedBy': 'ha-main',
        },
      ],
    };
  }
  if (path == '/rpc/staff/machine-connections') {
    return {
      'machineConnections': [
        {
          'machineId': 'maimai-dx-1',
          'status': 'online',
          'capabilities': ['coin', 'aime.scan'],
          'connectedAt': '2026-07-04T12:00:00.000Z',
          'lastSeenAt': '2026-07-04T12:36:00.000Z',
          'disconnectedAt': null,
        },
        {
          'machineId': 'chunithm-2',
          'status': 'offline',
          'capabilities': ['coin'],
          'connectedAt': '2026-07-04T11:00:00.000Z',
          'lastSeenAt': '2026-07-04T12:10:00.000Z',
          'disconnectedAt': '2026-07-04T12:10:00.000Z',
        },
      ],
    };
  }
  if (path == '/rpc/staff/device-commands') {
    return {
      'commands': [
        {
          'id': 'cmd-1',
          'type': 'door.open',
          'deviceId': 'door-1',
          'target': {'kind': 'facility', 'id': 'door-1'},
          'executorKind': 'home_assistant',
          'playerId': 'player-1',
          'staffId': null,
          'status': 'pending',
          'requestedAt': '2026-07-04T12:30:00.000Z',
          'ackedAt': null,
          'expiredAt': null,
        },
        {
          'id': 'cmd-2',
          'type': 'power.off',
          'deviceId': null,
          'target': {'kind': 'facility', 'all': true},
          'executorKind': 'home_assistant',
          'playerId': null,
          'staffId': 'staff-1',
          'status': 'acked',
          'requestedAt': '2026-07-04T12:31:00.000Z',
          'ackedAt': '2026-07-04T12:31:03.000Z',
          'expiredAt': null,
        },
        {
          'id': 'cmd-3',
          'type': 'aime.scan',
          'deviceId': 'reader-1',
          'target': {'kind': 'game_machine', 'id': 'reader-1'},
          'executorKind': 'machine_ws',
          'playerId': 'player-1',
          'staffId': null,
          'status': 'expired',
          'requestedAt': '2026-07-04T12:32:00.000Z',
          'ackedAt': null,
          'expiredAt': '2026-07-04T12:33:00.000Z',
          'payload': {
            'machineAck': {
              'status': 'failed',
              'message': 'coin controller timeout',
            },
          },
        },
      ],
    };
  }
  if (path == '/rpc/staff/device-actions') {
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    final target = body['target'] as Map<String, dynamic>;
    return {
      'action': {
        'id': 'cmd-power-off',
        'type': body['type'],
        'deviceId': target['id'],
        'target': target,
        'executorKind': target['kind'] == 'facility'
            ? 'home_assistant'
            : 'machine_ws',
        'playerId': null,
        'staffId': 'staff',
        'status': 'acked',
        'payload': body['payload'],
        'requestedAt': '2026-07-04T12:37:00.000Z',
        'ackedAt': '2026-07-04T12:37:01.000Z',
        'expiredAt': null,
      },
    };
  }
  return {};
}

String _expectedDateTime(String iso) {
  final local = toAdminTime(DateTime.parse(iso));
  String two(int value) => value.toString().padLeft(2, '0');
  return '${local.year}-${two(local.month)}-${two(local.day)} ${two(local.hour)}:${two(local.minute)}';
}
