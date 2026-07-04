import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/features/devices/devices_screen.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  testWidgets('device dashboard summarizes device health', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildDevicesScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('设备看板'), findsOneWidget);
    expect(find.text('在线设备'), findsOneWidget);
    expect(find.text('离线设备'), findsOneWidget);
    expect(find.text('需要关注'), findsOneWidget);
    expect(find.text('1'), findsWidgets);
    expect(find.text('前门闸机'), findsOneWidget);
    expect(find.text('投币控制器'), findsOneWidget);
    expect(find.text('智能网关'), findsOneWidget);
    expect(find.text('已锁定'), findsOneWidget);
    expect(find.text('在线'), findsOneWidget);
    expect(find.text('离线'), findsOneWidget);
    expect(find.text('故障'), findsOneWidget);
    expect(find.textContaining('metadata'), findsNothing);
    expect(find.textContaining('locked'), findsNothing);
  });

  testWidgets('command audit renders staff-facing statuses and times', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildDevicesScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('设备指令'), findsOneWidget);
    expect(find.text('门禁'), findsWidgets);
    expect(find.text('投币'), findsWidgets);
    expect(find.text('扫码'), findsOneWidget);
    expect(find.text('待执行'), findsOneWidget);
    expect(find.text('已确认'), findsOneWidget);
    expect(find.text('已超时'), findsOneWidget);
    expect(find.text('玩家 player-1'), findsWidgets);
    expect(find.text('员工 staff-1'), findsOneWidget);
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
            request.url.path == '/rpc/staff/device-commands',
      ),
      true,
    );
  });
}

Widget _buildDevicesScreen(List<http.Request> requests) {
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
      home: const Scaffold(body: DevicesScreen()),
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
          'type': 'door',
          'label': '前门闸机',
          'status': 'online',
          'state': 'locked',
          'metadata': {'battery': 91},
          'reportedAt': '2026-07-04T12:35:00.000Z',
          'reportedBy': 'agent-front',
        },
        {
          'deviceId': 'coin-1',
          'type': 'coin',
          'label': '投币控制器',
          'status': 'offline',
          'state': 'unknown',
          'metadata': null,
          'reportedAt': '2026-07-04T12:30:00.000Z',
          'reportedBy': 'agent-coin',
        },
        {
          'deviceId': 'gateway-1',
          'type': 'gateway',
          'label': '智能网关',
          'status': 'degraded',
          'state': 'slow',
          'metadata': null,
          'reportedAt': '2026-07-04T12:32:00.000Z',
          'reportedBy': 'agent-gateway',
        },
      ],
    };
  }
  if (path == '/rpc/staff/device-commands') {
    return {
      'commands': [
        {
          'id': 'cmd-1',
          'type': 'door',
          'deviceId': 'door-1',
          'playerId': 'player-1',
          'staffId': null,
          'status': 'pending',
          'requestedAt': '2026-07-04T12:30:00.000Z',
          'ackedAt': null,
          'expiredAt': null,
        },
        {
          'id': 'cmd-2',
          'type': 'coin',
          'deviceId': 'coin-1',
          'playerId': null,
          'staffId': 'staff-1',
          'status': 'acked',
          'requestedAt': '2026-07-04T12:31:00.000Z',
          'ackedAt': '2026-07-04T12:31:03.000Z',
          'expiredAt': null,
        },
        {
          'id': 'cmd-3',
          'type': 'scan',
          'deviceId': 'reader-1',
          'playerId': 'player-1',
          'staffId': null,
          'status': 'expired',
          'requestedAt': '2026-07-04T12:32:00.000Z',
          'ackedAt': null,
          'expiredAt': '2026-07-04T12:33:00.000Z',
        },
      ],
    };
  }
  return {};
}
