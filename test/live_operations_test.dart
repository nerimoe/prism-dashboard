import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/api/models.dart';
import 'package:prism_dashboard/src/features/operations/operations_screen.dart';
import 'package:prism_dashboard/src/features/pricing/pricing_screen.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  test('live player model keeps sessions flat under the player', () {
    final player = LivePlayer.fromJson(
      _livePlayersJson['players'].first as Map<String, dynamic>,
    );

    expect(player.displayName, 'A');
    expect(player.sessionCount, 2);
    expect(formatDurationMinutes(player.stayDurationMinutes), '2 小时 08 分');
    expect(player.sessions.map((session) => session.title), ['音游区间', '四口麻将']);
    expect(player.sessions.last.currentImpact, -8);
  });

  test(
    'api client uses player-level checkout and explicit stop endpoints',
    () async {
      final requests = <http.Request>[];
      final client = PrismApiClient(
        baseUrl: 'https://prism.example',
        token: 'staff-token',
        httpClient: MockClient((request) async {
          requests.add(request);
          return http.Response(
            '{}',
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );

      await client.stopPlayerSession(
        playerId: 'player-1',
        sessionId: 'session-2',
      );
      await client.confirmAllCheckout('player-1');

      expect(requests[0].method, 'POST');
      expect(
        requests[0].url.path,
        '/rpc/staff/players/player-1/sessions/session-2/stop',
      );
      expect(
        requests[1].url.path,
        '/rpc/staff/players/player-1/checkout/confirm-all',
      );
      expect(requests[0].headers['Authorization'], 'Bearer staff-token');
    },
  );

  testWidgets('operations page shows stay duration and flat session details', (
    tester,
  ) async {
    final api = PrismApiClient(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      httpClient: MockClient((request) async {
        expect(request.url.path, '/rpc/staff/live-players');
        return http.Response(
          jsonEncode(_livePlayersJson),
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildPrismDashboardTheme(
            ColorScheme.fromSeed(seedColor: prismSeedColor),
          ),
          home: OperationsScreen(api: api),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('在场玩家'), findsWidgets);
    expect(find.text('2 小时 08 分'), findsWidgets);
    expect(find.text('音游区间'), findsWidgets);
    expect(find.text('四口麻将'), findsWidgets);
    expect(find.textContaining('最早入场'), findsNothing);
    expect(find.textContaining('一名玩家只占一行'), findsNothing);
    expect(find.textContaining('平级展示'), findsNothing);
    expect(find.textContaining('session'), findsNothing);
    expect(find.text('计时项'), findsWidgets);
    expect(find.text('停止'), findsNWidgets(2));
  });

  testWidgets(
    'manual adjustment submits checkout override for the player bill',
    (tester) async {
      final requests = <http.Request>[];
      final api = PrismApiClient(
        baseUrl: 'https://prism.example',
        token: 'staff-token',
        httpClient: MockClient((request) async {
          requests.add(request);
          if (request.url.path == '/rpc/staff/live-players') {
            return http.Response(
              jsonEncode(_livePlayersJson),
              200,
              headers: {'content-type': 'application/json'},
            );
          }
          return http.Response(
            '{}',
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: buildPrismDashboardTheme(
              ColorScheme.fromSeed(seedColor: prismSeedColor),
            ),
            home: OperationsScreen(api: api),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('现场改价'));
      await tester.tap(find.text('现场改价'));
      await tester.pumpAndSettle();
      expect(find.text('临时金额'), findsOneWidget);
      expect(find.text('处理原因'), findsOneWidget);

      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), '45');
      await tester.enterText(fields.at(1), '店内临时处理');
      await tester.tap(find.text('确认改价'));
      await tester.pumpAndSettle();

      final override = requests.singleWhere(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/players/player-1/checkout/override',
      );
      expect(jsonDecode(override.body), {'total': 45, 'reason': '店内临时处理'});
    },
  );

  testWidgets('live header actions start an extra timer and bulk checkout', (
    tester,
  ) async {
    final requests = <http.Request>[];
    final api = PrismApiClient(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      httpClient: MockClient((request) async {
        requests.add(request);
        if (request.url.path == '/rpc/staff/live-players') {
          return http.Response(
            jsonEncode(_livePlayersJson),
            200,
            headers: {'content-type': 'application/json'},
          );
        }
        return http.Response(
          '{}',
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildPrismDashboardTheme(
            ColorScheme.fromSeed(seedColor: prismSeedColor),
          ),
          home: OperationsScreen(api: api),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('给玩家加开计时'));
    await tester.pumpAndSettle();
    expect(find.text('计时名称'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '四口麻将');
    await tester.tap(find.text('开始计时'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('闭店统一结账'));
    await tester.pumpAndSettle();
    expect(find.text('会结清所有仍在计时的玩家，请确认已经核对现场账单。'), findsOneWidget);
    await tester.tap(find.text('统一结账'));
    await tester.pumpAndSettle();

    final start = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/players/player-1/session/start',
    );
    expect(jsonDecode(start.body), {'label': '四口麻将'});
    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/sessions/active/checkout',
      ),
      isTrue,
    );
  });

  testWidgets('live panels keep natural height when content fits', (
    tester,
  ) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.binding.setSurfaceSize(const Size(1280, 720));

    final api = PrismApiClient(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      httpClient: MockClient((request) async {
        expect(request.url.path, '/rpc/staff/live-players');
        return http.Response(
          jsonEncode(_livePlayersJson),
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildPrismDashboardTheme(
            ColorScheme.fromSeed(seedColor: prismSeedColor),
          ),
          home: OperationsScreen(api: api),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final listHeight = tester
        .getSize(find.byKey(const ValueKey('live-player-list-panel')))
        .height;
    final pageHeight = tester.getSize(find.byType(OperationsScreen)).height;
    expect(listHeight, lessThan(pageHeight * 0.45));
    expect(listHeight, greaterThan(140));

    final billHeight = tester
        .getSize(find.byKey(const ValueKey('live-player-bill-panel')))
        .height;
    expect(billHeight, lessThan(pageHeight * 0.8));
  });

  testWidgets(
    'pricing module uses pickers and controls instead of raw time inputs',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: buildPrismDashboardTheme(
            ColorScheme.fromSeed(seedColor: prismSeedColor),
          ),
          home: const PricingScreen(),
        ),
      );

      expect(find.text('计费配置'), findsOneWidget);
      expect(find.textContaining('HH:mm'), findsNothing);
      expect(find.textContaining('millisecond'), findsNothing);
    },
  );
}

const Map<String, dynamic> _livePlayersJson = {
  'players': [
    {
      'playerId': 'player-1',
      'displayName': 'A',
      'status': 'active',
      'walletTotal': 132,
      'stayDurationMinutes': 128,
      'estimatedTotal': 56,
      'sessions': [
        {
          'id': 'session-1',
          'label': '音游区间',
          'startedAt': '2026-07-04T10:35:00.000Z',
          'elapsedMinutes': 128,
          'currentImpact': 64,
          'status': 'active',
        },
        {
          'id': 'session-2',
          'label': '四口麻将',
          'startedAt': '2026-07-04T11:20:00.000Z',
          'elapsedMinutes': 83,
          'currentImpact': -8,
          'status': 'active',
        },
      ],
    },
  ],
};
