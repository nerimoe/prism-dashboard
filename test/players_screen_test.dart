import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/features/players/players_screen.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  testWidgets('renders player list and selected player detail', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPlayersScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('玩家档案'), findsOneWidget);
    expect(find.text('玩家名册'), findsOneWidget);
    expect(find.byKey(const ValueKey('player-search-field')), findsOneWidget);
    expect(find.text('A'), findsWidgets);
    expect(find.text('B'), findsWidgets);
    expect(find.text('在场'), findsWidgets);
    expect(find.text('离店'), findsOneWidget);
    expect(find.text('钱包资产'), findsOneWidget);
    expect(find.text('实存余额'), findsOneWidget);
    await tester.ensureVisible(find.text('资产流水'));
    expect(find.textContaining('迁移记录'), findsOneWidget);
    expect(find.textContaining('legacy.UPDATE'), findsNothing);
    expect(find.text('QQ 826225045'), findsWidgets);
    expect(find.text('计时记录'), findsOneWidget);
    expect(find.text('音游区间'), findsWidgets);
    expect(find.text('四口麻将'), findsWidgets);
    expect(find.text('2 项'), findsOneWidget);
  });

  testWidgets('filters player list by migrated QQ binding', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPlayersScreen(requests));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('player-search-field')),
      '826225045',
    );
    await tester.pumpAndSettle();

    expect(find.text('找到 1 名玩家'), findsOneWidget);
    expect(find.text('A'), findsWidgets);
    expect(find.text('B'), findsNothing);
    expect(find.text('QQ 826225045'), findsWidgets);
  });

  testWidgets('create player posts display name', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPlayersScreen(requests));
    await tester.pumpAndSettle();

    final addButton = find.widgetWithText(FilledButton, '添加玩家');
    await tester.ensureVisible(addButton);
    await tester.tap(addButton);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '新玩家');
    await tester.tap(find.widgetWithText(FilledButton, '保存'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'POST' && request.url.path == '/rpc/staff/players',
    );
    expect(jsonDecode(request.body)['displayName'], '新玩家');
  });

  testWidgets('bind identity uses staff-facing copy and calls endpoint', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPlayersScreen(requests));
    await tester.pumpAndSettle();

    final bindIdentityButton = find.widgetWithText(FilledButton, '绑定身份');
    await tester.ensureVisible(bindIdentityButton);
    await tester.tap(bindIdentityButton);
    await tester.pumpAndSettle();

    expect(find.text('身份来源'), findsOneWidget);
    expect(find.text('外部编号'), findsOneWidget);
    expect(find.textContaining('provider'), findsNothing);
    expect(find.textContaining('subject'), findsNothing);

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(1), 'qq');
    await tester.enterText(fields.at(2), '10001');
    await tester.tap(find.widgetWithText(FilledButton, '绑定'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/players/player-a/identities',
    );
    expect(jsonDecode(request.body), {'provider': 'qq', 'subject': '10001'});
  });

  testWidgets('grant and adjust assets call correct endpoints', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPlayersScreen(requests));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('发放资产'));
    await tester.tap(find.text('发放资产'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('发放资产').last);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('调整资产'));
    await tester.tap(find.text('调整资产'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('调整资产').last);
    await tester.pumpAndSettle();

    final grant = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/players/player-a/assets/grants',
    );
    expect(jsonDecode(grant.body)['grants'].first['amount'], 10);

    final adjustment = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/players/player-a/assets/adjustments',
    );
    expect(
      jsonDecode(adjustment.body)['adjustments'].first['quantityDelta'],
      -10,
    );
  });
}

Widget _buildPlayersScreen(List<http.Request> requests) {
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
      home: const Scaffold(body: PlayersScreen()),
    ),
  );
}

Map<String, dynamic> _responseFor(http.Request request) {
  final path = request.url.path;
  if (path == '/rpc/staff/players' && request.method == 'GET') {
    return {
      'players': [
        {
          'id': 'player-a',
          'displayName': 'A',
          'status': 'active',
          'walletTotal': 120,
          'activeSessionId': 'session-1',
          'identities': [
            {
              'provider': 'qq',
              'subject': '826225045',
              'createdAt': '2026-07-05T10:00:00.000Z',
            },
          ],
        },
        {
          'id': 'player-b',
          'displayName': 'B',
          'status': 'disabled',
          'walletTotal': 0,
        },
      ],
    };
  }
  if (path == '/rpc/staff/players' && request.method == 'POST') {
    return {
      'player': {
        'id': 'player-new',
        'displayName': jsonDecode(request.body)['displayName'],
        'status': 'active',
        'createdAt': '2026-07-05T10:00:00.000Z',
      },
    };
  }
  if (path == '/rpc/staff/players/player-a/assets') {
    return {
      'holdings': [
        {
          'id': 'holding-1',
          'assetType': 'currency',
          'assetCode': 'paid',
          'assetName': '实存余额',
          'quantity': 120,
          'activeAt': null,
          'expiresAt': null,
          'metadata': null,
        },
      ],
      'ledgerEntries': [
        {
          'id': 'ledger-1',
          'assetType': 'currency',
          'assetCode': 'paid',
          'assetName': '实存余额',
          'delta': 120,
          'reason': 'legacy.UPDATE',
          'refId': 'staff-1',
          'transactionId': 'tx-1',
          'createdAt': '2026-07-05T10:00:00.000Z',
        },
      ],
    };
  }
  if (path == '/rpc/staff/players/player-a/sessions/history') {
    return {
      'sessions': [
        {
          'sessionId': 'session-1',
          'label': '音游区间',
          'startedAt': '2026-07-05T10:00:00.000Z',
          'endedAt': null,
          'durationMinutes': 45,
          'subtotal': null,
          'total': null,
          'status': 'active',
          'settledAt': null,
        },
        {
          'sessionId': 'session-2',
          'label': '四口麻将',
          'startedAt': '2026-07-05T10:30:00.000Z',
          'endedAt': null,
          'durationMinutes': 15,
          'subtotal': null,
          'total': null,
          'status': 'active',
          'settledAt': null,
        },
      ],
    };
  }
  if (path == '/rpc/staff/players/player-b/assets') {
    return {'holdings': [], 'ledgerEntries': []};
  }
  if (path == '/rpc/staff/players/player-b/sessions/history') {
    return {'sessions': []};
  }
  return {};
}
