import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/features/assets/assets_screen.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  testWidgets('renders asset definitions, presents, and redeem codes tabs', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('资产与礼包'), findsOneWidget);
    expect(find.text('实存余额'), findsOneWidget);
    expect(find.text('余额资产'), findsOneWidget);
    expect(find.text('currency/paid'), findsNothing);

    await tester.tap(find.text('礼包'));
    await tester.pumpAndSettle();
    expect(find.text('新手礼包'), findsOneWidget);
    expect(find.text('1 项发放内容'), findsOneWidget);

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();
    expect(find.text('WELCOME001'), findsOneWidget);
    expect(find.textContaining('可用 1 次'), findsOneWidget);
  });

  testWidgets('asset definition create and archive use backend contract', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('添加资产'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(1), 'coupon');
    await tester.enterText(fields.at(2), '优惠券');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    final save = requests.singleWhere(
      (request) =>
          request.method == 'PUT' &&
          request.url.path == '/rpc/staff/asset-definitions/currency/coupon',
    );
    expect(jsonDecode(save.body), {'name': '优惠券', 'stackable': true});

    await tester.tap(find.text('归档').first);
    await tester.pumpAndSettle();
    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path ==
                '/rpc/staff/asset-definitions/currency/paid/archive',
      ),
      true,
    );
  });

  testWidgets('present creation includes grant rows', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('添加礼包'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), '周末礼包');
    await tester.enterText(fields.at(3), '20');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'POST' && request.url.path == '/rpc/staff/presents',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    expect(body['name'], '周末礼包');
    expect(body['oncePerPlayer'], false);
    expect(body['grants'].first['mergeStrategy'], 'stack');
    expect(body['grants'].first['amount'], 20);
  });

  testWidgets('redeem code creation and revoke use presentId and maxUseCount', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('生成兑换码'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'WEEKEND001');
    await tester.enterText(fields.at(1), 'present-1');
    await tester.enterText(fields.at(2), '2');
    await tester.tap(find.text('生成'));
    await tester.pumpAndSettle();

    final create = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/redeem-codes',
    );
    expect(jsonDecode(create.body), {
      'code': 'WEEKEND001',
      'presentId': 'present-1',
      'activeAt': null,
      'expiresAt': null,
      'maxUseCount': 2,
    });

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('撤销'));
    await tester.pumpAndSettle();
    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/redeem-codes/code-1/revoke',
      ),
      true,
    );
  });
}

Widget _buildAssetsScreen(List<http.Request> requests) {
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
      home: const Scaffold(body: AssetsScreen()),
    ),
  );
}

Map<String, dynamic> _responseFor(http.Request request) {
  final path = request.url.path;
  if (path == '/rpc/staff/asset-definitions') {
    return {
      'assetDefinitions': [
        {
          'type': 'currency',
          'code': 'paid',
          'name': '实存余额',
          'stackable': true,
          'status': 'active',
          'metadata': null,
        },
      ],
    };
  }
  if (path == '/rpc/staff/presents') {
    if (request.method == 'POST') {
      return {
        'present': {
          'id': 'present-new',
          'name': jsonDecode(request.body)['name'],
          'oncePerPlayer': false,
          'status': 'active',
          'grants': jsonDecode(request.body)['grants'],
        },
      };
    }
    return {
      'presents': [
        {
          'id': 'present-1',
          'name': '新手礼包',
          'oncePerPlayer': false,
          'status': 'active',
          'grants': [
            {'assetType': 'currency', 'assetCode': 'free', 'amount': 10},
          ],
        },
      ],
    };
  }
  if (path == '/rpc/staff/redeem-codes') {
    if (request.method == 'POST') {
      return {
        'redeemCode': {
          'id': 'code-new',
          'code': jsonDecode(request.body)['code'],
          'presentId': jsonDecode(request.body)['presentId'],
          'activeAt': null,
          'expiresAt': null,
          'maxUseCount': jsonDecode(request.body)['maxUseCount'],
        },
      };
    }
    return {
      'redeemCodes': [
        {
          'id': 'code-1',
          'code': 'WELCOME001',
          'presentId': 'present-1',
          'activeAt': null,
          'expiresAt': null,
          'maxUseCount': 1,
        },
      ],
    };
  }
  if (path.contains('/asset-definitions/')) {
    return {
      'assetDefinition': {
        'type': 'currency',
        'code': 'paid',
        'name': '实存余额',
        'stackable': true,
        'status': path.endsWith('/archive') ? 'archived' : 'active',
        'metadata': null,
      },
    };
  }
  if (path.contains('/redeem-codes/')) {
    return {
      'redeemCode': {
        'id': 'code-1',
        'code': 'WELCOME001',
        'presentId': 'present-1',
        'activeAt': null,
        'expiresAt': null,
        'maxUseCount': 0,
      },
    };
  }
  return {};
}
