import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/features/reports/reports_screen.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  testWidgets('renders summary, settlements, and player ranking', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildReportsScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('营业报表'), findsOneWidget);
    expect(find.text('营业收入'), findsOneWidget);
    expect(find.text('¥248'), findsOneWidget);
    expect(find.text('已结账单'), findsOneWidget);
    expect(find.text('资产入账笔数'), findsOneWidget);
    expect(find.text('投币指令'), findsOneWidget);
    expect(find.text('结算明细'), findsOneWidget);
    expect(find.text('玩家排行'), findsOneWidget);
    expect(find.text('A'), findsWidgets);
    expect(find.text('B'), findsWidgets);
    expect(find.text('2 小时 30 分钟'), findsWidgets);
    expect(find.textContaining('playerDisplayName'), findsNothing);
    expect(find.textContaining('settlementId'), findsNothing);
  });

  testWidgets('quick range change reloads report endpoints', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildReportsScreen(requests));
    await tester.pumpAndSettle();

    final initialCount = requests.length;
    await tester.tap(find.text('近 7 天'));
    await tester.pumpAndSettle();

    final newRequests = requests.skip(initialCount).toList();
    expect(newRequests.length, 3);
    expect(
      newRequests.every(
        (request) =>
            request.url.queryParameters.containsKey('from') &&
            request.url.queryParameters.containsKey('to'),
      ),
      true,
    );
    expect(
      newRequests.map((request) => request.url.path),
      containsAll([
        '/rpc/staff/reports/summary',
        '/rpc/staff/reports/settlements',
        '/rpc/staff/reports/players',
      ]),
    );
  });

  testWidgets('report dates use the configured store timezone', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildReportsScreen(requests));
    await tester.pumpAndSettle();

    final summary = requests.firstWhere(
      (request) => request.url.path == '/rpc/staff/reports/summary',
    );
    expect(summary.url.queryParameters['from'], '2026-07-03T16:00:00.000Z');
    expect(summary.url.queryParameters['to'], '2026-07-04T16:00:00.000Z');
  });

  testWidgets('settlement report can load the next page', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(
      _buildReportsScreen(requests, paginatedSettlements: true),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('加载更多结算'));
    await tester.pumpAndSettle();

    final nextPage = requests.singleWhere(
      (request) =>
          request.url.path == '/rpc/staff/reports/settlements' &&
          request.url.queryParameters['offset'] == '2',
    );
    expect(nextPage.url.queryParameters['limit'], '50');
    expect(find.text('C'), findsOneWidget);
    expect(find.text('加载更多结算'), findsNothing);
  });
}

Widget _buildReportsScreen(
  List<http.Request> requests, {
  bool paginatedSettlements = false,
}) {
  final api = PrismApiClient(
    baseUrl: 'https://prism.example',
    token: 'staff-token',
    httpClient: MockClient((request) async {
      requests.add(request);
      return http.Response(
        jsonEncode(
          _responseFor(request, paginatedSettlements: paginatedSettlements),
        ),
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
      home: Scaffold(body: ReportsScreen(initialToday: DateTime(2026, 7, 4))),
    ),
  );
}

Map<String, dynamic> _responseFor(
  http.Request request, {
  bool paginatedSettlements = false,
}) {
  final path = request.url.path;
  if (path == '/rpc/staff/reports/summary') {
    return {
      'summary': {
        'from': request.url.queryParameters['from'],
        'to': request.url.queryParameters['to'],
        'revenueTotal': 248,
        'sessionCount': 4,
        'assetGrantTotal': 3,
        'coinCommandCount': 6,
      },
    };
  }
  if (path == '/rpc/staff/reports/settlements') {
    if (paginatedSettlements && request.url.queryParameters['offset'] == '2') {
      return {
        'settlements': [
          {
            'settlementId': 'settlement-3',
            'sessionId': 'session-3',
            'playerId': 'player-3',
            'playerDisplayName': 'C',
            'startedAt': '2026-07-04T12:00:00.000Z',
            'endedAt': '2026-07-04T13:00:00.000Z',
            'settledAt': '2026-07-04T13:05:00.000Z',
            'durationMinutes': 60,
            'subtotal': 50,
            'total': 50,
          },
        ],
        'page': {'limit': 50, 'offset': 2, 'hasMore': false},
      };
    }
    return {
      'settlements': [
        {
          'settlementId': 'settlement-1',
          'sessionId': 'session-1',
          'playerId': 'player-1',
          'playerDisplayName': 'A',
          'startedAt': '2026-07-04T09:00:00.000Z',
          'endedAt': '2026-07-04T11:30:00.000Z',
          'settledAt': '2026-07-04T11:35:00.000Z',
          'durationMinutes': 150,
          'subtotal': 180,
          'total': 160,
        },
        {
          'settlementId': 'settlement-2',
          'sessionId': 'session-2',
          'playerId': 'player-2',
          'playerDisplayName': 'B',
          'startedAt': '2026-07-04T10:00:00.000Z',
          'endedAt': '2026-07-04T11:00:00.000Z',
          'settledAt': '2026-07-04T11:10:00.000Z',
          'durationMinutes': 60,
          'subtotal': 100,
          'total': 88,
        },
      ],
      'page': {'limit': 50, 'offset': 0, 'hasMore': paginatedSettlements},
    };
  }
  if (path == '/rpc/staff/reports/players') {
    return {
      'players': [
        {
          'playerId': 'player-1',
          'playerDisplayName': 'A',
          'settlementCount': 3,
          'totalDurationMinutes': 150,
          'revenueTotal': 160,
          'lastSettledAt': '2026-07-04T11:35:00.000Z',
        },
        {
          'playerId': 'player-2',
          'playerDisplayName': 'B',
          'settlementCount': 1,
          'totalDurationMinutes': 60,
          'revenueTotal': 88,
          'lastSettledAt': '2026-07-04T11:10:00.000Z',
        },
      ],
    };
  }
  return {};
}
