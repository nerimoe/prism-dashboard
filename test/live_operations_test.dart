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
    expect(
      player.sessions.first.pricingCharges.map((charge) => charge.planName),
      ['音游标准计费'],
    );
    expect(player.sessions.first.pricingSummary, '音游标准计费 · 日场');
  });

  test('live player model parses structured billing explanations', () {
    final player = LivePlayer.fromJson(
      _structuredLivePlayersJson['players'].single as Map<String, dynamic>,
    );

    expect(
      player.sessions.single.pricingSegments.first.actualStartedAt,
      DateTime.parse('2026-07-09T14:00:00.000Z'),
    );
    expect(player.globalCapWindows, hasLength(2));
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
        '/rpc/staff/players/player-1/checkout/confirm',
      );
      expect(requests[0].headers['Authorization'], 'Bearer staff-token');
    },
  );

  test('api client parses wrapped checkout preview responses', () async {
    final requests = <http.Request>[];
    final client = PrismApiClient(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      httpClient: MockClient((request) async {
        requests.add(request);
        if (request.url.path.endsWith('/checkout/preview')) {
          return http.Response(
            jsonEncode(_checkoutPreviewJson),
            200,
            headers: {'content-type': 'application/json'},
          );
        }
        return http.Response('{}', 404);
      }),
    );

    final all = await client.previewAllCheckout('player-1');
    final single = await client.previewCheckout('player-1');

    expect(all.playerId, 'player-1');
    expect(all.sessionIds, ['session-1', 'session-2']);
    expect(all.total, 56);
    expect(all.status, 'preview');
    expect(all.sessionPreviews.map((preview) => preview.sessionId), [
      'session-1',
      'session-2',
    ]);
    expect(single.playerId, 'player-1');
    expect(single.sessionIds, ['session-1', 'session-2']);
    expect(single.total, 56);
    expect(
      requests.map((request) => request.url.path),
      containsAll(['/rpc/staff/players/player-1/checkout/preview']),
    );
  });

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
    expect(find.textContaining('1 项计时中'), findsOneWidget);
    expect(find.text('2 项费用'), findsOneWidget);
    expect(find.text('2 小时 08 分'), findsWidgets);
    expect(find.text('音游区间'), findsWidgets);
    expect(find.text('四口麻将'), findsWidgets);
    expect(
      find.textContaining(_expectedDateTime('2026-07-04T10:35:00.000Z')),
      findsWidgets,
    );
    expect(
      find.textContaining(
        '停止 ${_expectedDateTime('2026-07-04T12:43:00.000Z')}',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('10:35 开始'), findsNothing);
    expect(find.textContaining('最早入场'), findsNothing);
    expect(find.textContaining('一名玩家只占一行'), findsNothing);
    expect(find.textContaining('平级展示'), findsNothing);
    expect(find.textContaining('session'), findsNothing);
    expect(find.text('计时项'), findsWidgets);
    expect(find.text('音游标准计费'), findsWidgets);
    expect(find.text('日场'), findsOneWidget);
    expect(find.text('+¥64'), findsOneWidget);
    expect(find.text('麻将四口加价'), findsOneWidget);
    expect(find.text('A 桌'), findsOneWidget);
    expect(find.text('+¥5'), findsOneWidget);
    expect(find.text('-¥13'), findsOneWidget);
    expect(find.text('已停止'), findsOneWidget);
    expect(find.text('待结账'), findsOneWidget);
    expect(find.text('音游按时收费'), findsNothing);
    expect(find.text('停止'), findsOneWidget);
  });

  testWidgets('renders every structured billing segment and cap window', (
    tester,
  ) async {
    final api = PrismApiClient(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      httpClient: MockClient(
        (request) async => http.Response(
          jsonEncode(_structuredLivePlayersJson),
          200,
          headers: {'content-type': 'application/json'},
        ),
      ),
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

    await tester.ensureVisible(find.text('查看计费明细'));
    await tester.tap(find.text('查看计费明细'));
    await tester.pumpAndSettle();

    expect(find.textContaining('实际计费：2026-07-09'), findsOneWidget);
    expect(
      find.text(
        '实际计费：${_expectedDateTime('2026-07-09T14:00:00.000Z')} 至 ${_expectedDateTime('2026-07-09T16:00:00.000Z')} · 2 小时',
      ),
      findsOneWidget,
    );
    expect(find.text('规则时段：22:00 至 次日 00:00'), findsOneWidget);
    expect(find.text('本段费用 ¥100'), findsOneWidget);
    expect(find.text('区间内封顶 ¥100 · 已达到'), findsOneWidget);
    expect(find.text('凌晨方案 · 凌晨'), findsOneWidget);
    expect(find.text('白天方案 · 白天'), findsOneWidget);
    expect(find.text('2026-07-09 夜间'), findsOneWidget);
    expect(find.text('2026-07-10 白天'), findsOneWidget);
    expect(
      find.text(
        '${_expectedDateTime('2026-07-09T14:00:00.000Z')} 至 ${_expectedDateTime('2026-07-09T16:00:00.000Z')}',
      ),
      findsOneWidget,
    );
    expect(
      find.text('历史已计入 ¥80 · 本次参与金额 ¥50 · 封顶至 ¥100 · 本次计入 ¥20'),
      findsOneWidget,
    );
    expect(
      find.text('历史已计入 ¥10 · 本次参与金额 ¥30 · 封顶至 ¥120 · 本次计入 ¥30'),
      findsOneWidget,
    );
    expect(find.textContaining('区间内封顶 ¥120'), findsNothing);

    await tester.ensureVisible(find.text('2026-07-09 夜间'));
    await tester.tap(find.text('2026-07-09 夜间'));
    await tester.pumpAndSettle();
    expect(find.text('参与项目：session-structured ¥20'), findsOneWidget);

    await tester.ensureVisible(find.text('2026-07-10 白天'));
    await tester.tap(find.text('2026-07-10 白天'));
    await tester.pumpAndSettle();
    expect(find.text('参与项目：session-structured ¥30'), findsOneWidget);
  });

  testWidgets('shows unavailable billing detail for legacy session summaries', (
    tester,
  ) async {
    final api = PrismApiClient(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      httpClient: MockClient(
        (request) async => http.Response(
          jsonEncode(_livePlayersJson),
          200,
          headers: {'content-type': 'application/json'},
        ),
      ),
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

    await tester.ensureVisible(find.text('查看计费明细').first);
    await tester.tap(find.text('查看计费明细').first);
    await tester.pumpAndSettle();

    expect(find.text('计费明细暂不可用'), findsOneWidget);
  });

  testWidgets('keeps session billing expansion after refresh', (tester) async {
    final api = PrismApiClient(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      httpClient: MockClient(
        (request) async => http.Response(
          jsonEncode(_structuredLivePlayersJson),
          200,
          headers: {'content-type': 'application/json'},
        ),
      ),
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

    await tester.ensureVisible(find.text('查看计费明细'));
    await tester.tap(find.text('查看计费明细'));
    await tester.pumpAndSettle();
    expect(find.textContaining('实际计费：2026-07-09'), findsOneWidget);

    await tester.ensureVisible(find.byTooltip('刷新'));
    await tester.tap(find.byTooltip('刷新'));
    await tester.pumpAndSettle();
    expect(find.textContaining('实际计费：2026-07-09'), findsOneWidget);
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
          if (request.url.path == '/rpc/staff/pricing-configs') {
            return http.Response(
              jsonEncode(_pricingConfigsJson),
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

  testWidgets(
    'player checkout preview opens confirmation and settles all fees',
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
          if (request.url.path.endsWith('/checkout/preview')) {
            return http.Response(
              jsonEncode(_checkoutPreviewJson),
              200,
              headers: {'content-type': 'application/json'},
            );
          }
          if (request.url.path.endsWith('/checkout/confirm')) {
            return http.Response(
              jsonEncode(_checkoutResultJson),
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

      await tester.ensureVisible(find.text('给 A 结账'));
      await tester.tap(find.text('给 A 结账'));
      await tester.pumpAndSettle();
      expect(find.text('结清 A'), findsOneWidget);
      expect(find.textContaining('2 笔未结费用'), findsOneWidget);
      expect(find.text('会把 A 现在的 2 笔未结费用一起结掉，预计扣款 ¥56。'), findsOneWidget);
      await tester.tap(find.text('确认结账'));
      await tester.pumpAndSettle();

      expect(
        requests.any(
          (request) =>
              request.method == 'POST' &&
              request.url.path ==
                  '/rpc/staff/players/player-1/checkout/preview',
        ),
        isTrue,
      );
      expect(
        requests.any(
          (request) =>
              request.method == 'POST' &&
              request.url.path ==
                  '/rpc/staff/players/player-1/checkout/confirm',
        ),
        isTrue,
      );
      expect(find.text('A 已结账。'), findsOneWidget);
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
        if (request.url.path == '/rpc/staff/pricing-configs') {
          return http.Response(
            jsonEncode(_pricingConfigsJson),
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
    expect(find.text('使用的计费方案'), findsOneWidget);
    expect(find.text('音游标准计费'), findsWidgets);
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
    expect(jsonDecode(start.body), {
      'label': '四口麻将',
      'pricingConfigIds': ['pricing-music'],
    });
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
          'endedAt': null,
          'elapsedMinutes': 128,
          'currentImpact': 64,
          'status': 'active',
          'pricingCharges': [
            {
              'pricingConfigId': 'pricing-music',
              'planName': '音游标准计费',
              'ruleLabel': '日场',
              'amount': 64,
            },
          ],
        },
        {
          'id': 'session-2',
          'label': '四口麻将',
          'startedAt': '2026-07-04T11:20:00.000Z',
          'endedAt': '2026-07-04T12:43:00.000Z',
          'elapsedMinutes': 83,
          'currentImpact': -8,
          'status': 'closed',
          'pricingCharges': [
            {
              'pricingConfigId': 'pricing-mahjong-a',
              'planName': '麻将四口加价',
              'ruleLabel': 'A 桌',
              'amount': 5,
            },
            {
              'pricingConfigId': 'asset-month-pass',
              'planName': '月卡折抵',
              'ruleLabel': '会员权益',
              'amount': -13,
            },
          ],
        },
      ],
    },
  ],
};

const Map<String, dynamic> _structuredLivePlayersJson = {
  'players': [
    {
      'playerId': 'player-structured',
      'displayName': '计费明细玩家',
      'status': 'active',
      'walletTotal': 200,
      'stayDurationMinutes': 660,
      'estimatedTotal': 175,
      'globalCapWindows': [
        {
          'key': '2026-07-09-night',
          'capConfigId': 'night-cap',
          'capRuleId': 'night-rule',
          'ruleLabel': '夜间',
          'windowStartedAt': '2026-07-09T14:00:00.000Z',
          'windowEndedAt': '2026-07-09T16:00:00.000Z',
          'priceCap': 100,
          'paidBefore': 80,
          'currentAmount': 50,
          'amountApplied': 20,
          'priceCapReached': true,
          'contributions': [
            {
              'sessionId': 'session-structured',
              'pricingConfigId': 'night',
              'amount': 20,
            },
          ],
        },
        {
          'key': '2026-07-10-day',
          'capConfigId': 'day-cap',
          'capRuleId': 'day-rule',
          'ruleLabel': '白天',
          'windowStartedAt': '2026-07-10T01:00:00.000Z',
          'windowEndedAt': '2026-07-10T04:00:00.000Z',
          'priceCap': 120,
          'paidBefore': 10,
          'currentAmount': 30,
          'amountApplied': 30,
          'priceCapReached': false,
          'contributions': [
            {
              'sessionId': 'session-structured',
              'pricingConfigId': 'day',
              'amount': 30,
            },
          ],
        },
      ],
      'sessions': [
        {
          'id': 'session-structured',
          'label': '夜间计时',
          'startedAt': '2026-07-09T14:00:00.000Z',
          'endedAt': null,
          'elapsedMinutes': 660,
          'currentImpact': 175,
          'status': 'active',
          'pricingCharges': [],
          'pricingSegments': [
            {
              'pricingConfigId': 'night',
              'planName': '夜间方案',
              'providerId': 'time.priority',
              'ruleId': 'night-rule',
              'ruleLabel': '夜间',
              'actualStartedAt': '2026-07-09T14:00:00.000Z',
              'actualEndedAt': '2026-07-09T16:00:00.000Z',
              'ruleTimeRange': {'start': '22:00', 'end': '00:00'},
              'amount': 100,
              'intervalCap': 100,
              'intervalCapReached': true,
            },
            {
              'pricingConfigId': 'early',
              'planName': '凌晨方案',
              'providerId': 'time.priority',
              'ruleId': 'early-rule',
              'ruleLabel': '凌晨',
              'actualStartedAt': '2026-07-09T16:00:00.000Z',
              'actualEndedAt': '2026-07-10T01:00:00.000Z',
              'ruleTimeRange': {'start': '00:00', 'end': '09:00'},
              'amount': 45,
              'intervalCap': 100,
              'intervalCapReached': false,
            },
            {
              'pricingConfigId': 'day',
              'planName': '白天方案',
              'providerId': 'time.priority',
              'ruleId': 'day-rule',
              'ruleLabel': '白天',
              'actualStartedAt': '2026-07-10T01:00:00.000Z',
              'actualEndedAt': '2026-07-10T03:00:00.000Z',
              'ruleTimeRange': {'start': '09:00', 'end': '22:00'},
              'amount': 30,
              'intervalCap': 120,
              'intervalCapReached': false,
            },
          ],
        },
      ],
    },
  ],
};

const Map<String, dynamic> _checkoutPreviewJson = {
  'settlementPreview': {
    'playerId': 'player-1',
    'sessionIds': ['session-1', 'session-2'],
    'subtotal': 64,
    'total': 56,
    'status': 'preview',
    'previewedAt': '2026-07-04T12:43:00.000Z',
  },
  'sessionPreviews': [
    {'sessionId': 'session-1', 'subtotal': 64, 'total': 64},
    {'sessionId': 'session-2', 'subtotal': 0, 'total': -8},
  ],
  'chargeItems': [],
  'adjustments': [],
  'assetHoldings': [],
};

const Map<String, dynamic> _checkoutResultJson = {
  'playerSettlement': {
    'playerId': 'player-1',
    'sessionIds': ['session-1', 'session-2'],
    'subtotal': 64,
    'total': 56,
    'status': 'settled',
    'settledAt': '2026-07-04T12:44:00.000Z',
  },
  'settlements': [],
  'chargeItems': [],
  'adjustments': [],
  'assetLedgerEntries': [],
  'assetHoldings': [],
};

String _expectedDateTime(String iso) {
  final local = DateTime.parse(iso).toLocal();
  String two(int value) => value.toString().padLeft(2, '0');
  return '${local.year}-${two(local.month)}-${two(local.day)} ${two(local.hour)}:${two(local.minute)}';
}

const Map<String, dynamic> _pricingConfigsJson = {
  'pricingConfigs': [
    {
      'id': 'pricing-music',
      'kind': 'time.priority',
      'name': '音游标准计费',
      'enabled': true,
      'status': 'active',
      'provider': {
        'id': 'time.music',
        'rules': [
          {
            'id': 'rule-day',
            'label': '日间',
            'priority': 0,
            'timeRange': {'start': '10:00', 'end': '22:00'},
            'pricing': {
              'unitMinutes': 30,
              'unitPrice': 10,
              'roundGraceMinutes': 5,
              'priceCap': 80,
            },
          },
        ],
      },
    },
  ],
};
