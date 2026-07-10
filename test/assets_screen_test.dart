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

    expect(find.text('资产与礼物'), findsOneWidget);
    expect(find.textContaining(['礼', '包'].join()), findsNothing);
    expect(find.widgetWithText(ListTile, '实存余额'), findsOneWidget);
    expect(find.text('余额资产'), findsWidgets);
    expect(find.text('归档资产（1）'), findsOneWidget);
    expect(find.text('旧月卡'), findsNothing);
    expect(find.text('currency/paid'), findsNothing);

    await tester.tap(find.text('礼物'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ListTile, '新手礼物'), findsOneWidget);
    expect(find.text('礼物详情'), findsOneWidget);
    expect(find.text('绑定兑换码'), findsOneWidget);
    expect(find.text('全部 28'), findsOneWidget);
    expect(find.text('可用 26'), findsOneWidget);
    expect(find.text('已用完 1'), findsOneWidget);
    expect(find.text('包含内容'), findsOneWidget);
    expect(find.text('赠送余额'), findsOneWidget);
    expect(find.text('currency / free'), findsNothing);
    expect(find.textContaining('建议归档后新建礼物'), findsOneWidget);
    expect(find.text('1 项内容'), findsOneWidget);
    expect(find.text('归档礼物（1）'), findsOneWidget);
    expect(find.text('老码礼物'), findsNothing);

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();
    expect(find.text('WELCOME001'), findsOneWidget);
    expect(find.textContaining('已用 1 / 1'), findsWidgets);

    await tester.ensureVisible(find.byTooltip('复制兑换码').first);
    await tester.tap(find.byTooltip('复制兑换码').first);
    await tester.pump();
    expect(find.text('兑换码已复制。'), findsOneWidget);
  });

  testWidgets('asset tabs switch content without waiting for tab animation', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('计费效果'));
    await tester.pump();
    expect(find.widgetWithText(FilledButton, '添加计费效果'), findsOneWidget);
    expect(find.byIcon(Icons.price_change_outlined), findsOneWidget);
    expect(find.byIcon(Icons.savings), findsNothing);

    await tester.tap(find.text('兑换码'));
    await tester.pump();
    expect(find.text('兑换码概览'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '生成兑换码'), findsOneWidget);

    await tester.tap(find.text('礼物'));
    await tester.pump();
    expect(find.widgetWithText(FilledButton, '新建礼物'), findsOneWidget);
  });

  testWidgets('asset definition create and archive use backend contract', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('添加资产'));
    await tester.pumpAndSettle();
    expect(find.text('资产类别'), findsOneWidget);
    expect(find.text('CUSTOM（自定义类别）'), findsOneWidget);
    expect(find.text('资产类型'), findsNothing);
    await tester.enterText(find.widgetWithText(TextField, '店内编号'), 'coupon');
    await tester.enterText(find.widgetWithText(TextField, '资产名称'), '优惠券');
    await tester.ensureVisible(find.text('保存资产'));
    await tester.tap(find.text('保存资产'));
    await tester.pumpAndSettle();

    final save = requests.singleWhere(
      (request) =>
          request.method == 'PUT' &&
          request.url.path == '/rpc/staff/asset-definitions/currency/coupon',
    );
    expect(jsonDecode(save.body), {
      'name': '优惠券',
      'stackable': true,
      'pricingEffectId': null,
      'activeAt': null,
      'expiresAt': null,
    });

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

  testWidgets('asset definitions open an editable detail pane', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, '实存余额'));
    await tester.pumpAndSettle();

    expect(find.text('资产详情'), findsOneWidget);
    expect(find.text('店内编号 paid'), findsOneWidget);
    expect(find.text('当前状态 正常'), findsOneWidget);
    expect(find.text('保存修改'), findsOneWidget);

    final nameField = find.widgetWithText(TextField, '资产名称');
    expect(nameField, findsOneWidget);
    await tester.enterText(nameField, '实存余额（可赠送）');
    await tester.ensureVisible(find.text('保存修改'));
    await tester.tap(find.text('保存修改'));
    await tester.pumpAndSettle();

    final save = requests.lastWhere(
      (request) =>
          request.method == 'PUT' &&
          request.url.path == '/rpc/staff/asset-definitions/currency/paid',
    );
    expect(jsonDecode(save.body)['name'], '实存余额（可赠送）');
  });

  testWidgets('present creation includes grant rows', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('礼物'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('新建礼物'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('新礼物草稿'), findsOneWidget);
    expect(find.text('发放资产'), findsOneWidget);
    expect(find.text('发放资产类型'), findsNothing);
    expect(find.text('发放资产代码'), findsNothing);
    await tester.enterText(find.widgetWithText(TextField, '礼物名称'), '周末礼物');
    await tester.enterText(find.widgetWithText(TextField, '数量'), '20');
    await tester.ensureVisible(find.text('保存'));
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'POST' && request.url.path == '/rpc/staff/presents',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    expect(body['name'], '周末礼物');
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

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('生成兑换码'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('兑换码生成台'), findsOneWidget);
    expect(find.text('选择礼物'), findsOneWidget);
    expect(find.text('礼物 ID'), findsNothing);
    await tester.enterText(find.widgetWithText(TextField, '兑换码'), 'WEEKEND001');
    await tester.enterText(find.widgetWithText(TextField, '可使用次数'), '2');
    await tester.ensureVisible(find.text('确认生成'));
    await tester.tap(find.text('确认生成'));
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
    await tester.ensureVisible(find.text('撤销').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('撤销').first);
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

  testWidgets('redeem codes show summary instead of a full code dump', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();

    expect(find.text('兑换码概览'), findsOneWidget);
    expect(find.text('按礼物筛选'), findsOneWidget);
    expect(find.text('按玩家筛选'), findsOneWidget);
    expect(find.text('兑换时间'), findsOneWidget);
    expect(find.text('排序方式'), findsOneWidget);
    expect(find.text('全部状态'), findsNothing);
    expect(find.textContaining('新手礼物'), findsWidgets);
    expect(find.text('老码礼物'), findsNothing);
    expect(find.text('已使用 2', skipOffstage: false), findsOneWidget);
    expect(find.text('不可使用 1', skipOffstage: false), findsOneWidget);
    expect(find.text('已过期'), findsOneWidget);
    expect(find.textContaining('已用 1 / 1'), findsWidgets);
    expect(find.text('最近 20 条'), findsOneWidget);
    expect(find.text('BULK-0001'), findsOneWidget);
    expect(find.text('BULK-0021'), findsNothing);
  });

  testWidgets('redeem codes can be filtered by gift', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('全部礼物'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('老码礼物').last);
    await tester.pumpAndSettle();

    expect(find.text('OLD-USED'), findsOneWidget);
    expect(find.text('WELCOME001'), findsNothing);
  });

  testWidgets('redeem codes can be filtered by usage status', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();

    final usedFilter = find.text('已使用 2', skipOffstage: false);
    await tester.ensureVisible(usedFilter);
    await tester.pumpAndSettle();
    await tester.tap(usedFilter);
    await tester.pumpAndSettle();
    expect(find.text('WELCOME-USED'), findsOneWidget);
    expect(find.text('OLD-USED'), findsOneWidget);
    expect(find.text('WELCOME001'), findsNothing);
    expect(find.text('EXPIRED001'), findsNothing);
    expect(find.textContaining('A · 2026-07-05 12:34'), findsOneWidget);

    final unavailableFilter = find.text('不可使用 1', skipOffstage: false);
    await tester.ensureVisible(unavailableFilter);
    await tester.pumpAndSettle();
    await tester.tap(unavailableFilter);
    await tester.pumpAndSettle();
    expect(find.text('EXPIRED001'), findsOneWidget);
    expect(find.text('WELCOME-USED'), findsNothing);
    expect(find.text('WELCOME001'), findsNothing);
  });

  testWidgets('redeem codes can filter by player, redeemed date, and sort', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, '按玩家筛选'), 'A');
    await tester.pumpAndSettle();
    expect(find.text('WELCOME-USED'), findsOneWidget);
    expect(find.text('OLD-USED'), findsNothing);

    await tester.tap(find.text('最近创建'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('即将过期').last);
    await tester.pumpAndSettle();
    expect(find.text('排序方式'), findsOneWidget);
  });

  testWidgets('used redeem codes can jump to the player profile', (
    tester,
  ) async {
    String? openedPlayerId;
    await tester.pumpWidget(
      _buildAssetsScreen(
        <http.Request>[],
        onOpenPlayer: (playerId) => openedPlayerId = playerId,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('已使用 2', skipOffstage: false));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('查看玩家').first);
    await tester.tap(find.text('查看玩家').first);
    await tester.pumpAndSettle();

    expect(openedPlayerId, 'player-a');
  });

  testWidgets('redeem code creation supports batch generation', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('兑换码'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('生成兑换码'));
    await tester.pumpAndSettle();

    expect(find.text('批量生成'), findsOneWidget);
    await tester.tap(find.text('批量生成'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, '兑换码前缀'), 'SUMMER');
    await tester.enterText(find.widgetWithText(TextField, '生成数量'), '100');
    await tester.enterText(find.widgetWithText(TextField, '可使用次数'), '3');
    await tester.ensureVisible(find.text('确认生成'));
    await tester.tap(find.text('确认生成'));
    await tester.pumpAndSettle();

    final create = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/redeem-codes/batch',
    );
    expect(jsonDecode(create.body), {
      'count': 100,
      'prefix': 'SUMMER',
      'presentId': 'present-1',
      'activeAt': null,
      'expiresAt': null,
      'maxUseCount': 3,
    });
  });

  testWidgets('pricing effect can target timer names and pricing rules', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildAssetsScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('计费效果'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('添加计费效果'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('计费效果草稿'), findsOneWidget);

    expect(find.text('只对这些计时名称生效'), findsOneWidget);
    expect(find.text('只对这些计费方案生效'), findsOneWidget);
    expect(find.text('只对这些计费时段生效'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, '效果编号'),
      'effect-mahjong-four',
    );
    await tester.enterText(find.widgetWithText(TextField, '显示名称'), '四口麻将抵扣');
    await tester.enterText(
      find.widgetWithText(TextField, '只对这些计时名称生效'),
      '四口麻将',
    );
    await tester.ensureVisible(find.text('音游标准计费'));
    await tester.tap(find.text('音游标准计费'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('音游标准计费 · 日间'));
    await tester.tap(find.text('音游标准计费 · 日间'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存计费效果'));
    await tester.pumpAndSettle();

    final save = requests.singleWhere(
      (request) =>
          request.method == 'PUT' &&
          request.url.path == '/rpc/staff/pricing-effects/effect-mahjong-four',
    );
    final body = jsonDecode(save.body) as Map<String, dynamic>;
    expect(body['config'], {
      'applicableSessionLabels': ['四口麻将'],
      'applicablePricingConfigIds': ['pricing-music'],
      'applicableRuleIds': ['rule-day'],
    });
  });
}

Widget _buildAssetsScreen(
  List<http.Request> requests, {
  ValueChanged<String>? onOpenPlayer,
}) {
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
      home: Scaffold(body: AssetsScreen(onOpenPlayer: onOpenPlayer)),
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
        {
          'type': 'currency',
          'code': 'free',
          'name': '赠送余额',
          'stackable': true,
          'status': 'active',
          'metadata': null,
        },
        {
          'type': 'pass',
          'code': 'old-monthly',
          'name': '旧月卡',
          'stackable': true,
          'status': 'archived',
          'metadata': null,
        },
      ],
    };
  }
  if (path == '/rpc/staff/pricing-effects') {
    return {
      'pricingEffects': [
        {
          'id': 'effect-monthly',
          'name': '月卡免时费',
          'type': 'free',
          'scope': 'session',
          'value': null,
          'consumable': false,
          'limitPerDay': null,
          'activeAt': null,
          'expiresAt': null,
          'status': 'active',
        },
      ],
    };
  }
  if (path == '/rpc/staff/pricing-configs') {
    return {
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
  }
  if (path.startsWith('/rpc/staff/pricing-effects/')) {
    return {
      'pricingEffect': {
        'id': path.split('/').last,
        'name': jsonDecode(request.body)['name'],
        'type': jsonDecode(request.body)['type'],
        'scope': jsonDecode(request.body)['scope'],
        'value': jsonDecode(request.body)['value'],
        'consumable': jsonDecode(request.body)['consumable'],
        'limitPerDay': jsonDecode(request.body)['limitPerDay'],
        'activeAt': null,
        'expiresAt': null,
        'status': 'active',
        'config': jsonDecode(request.body)['config'],
      },
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
          'name': '新手礼物',
          'oncePerPlayer': false,
          'status': 'active',
          'grants': [
            {'assetType': 'currency', 'assetCode': 'free', 'amount': 10},
          ],
        },
        {
          'id': 'present-old',
          'name': '老码礼物',
          'oncePerPlayer': false,
          'status': 'archived',
          'grants': [
            {'assetType': 'pass', 'assetCode': 'old-monthly', 'amount': 1},
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
          'usageCount': 0,
        },
        {
          'id': 'used-1',
          'code': 'WELCOME-USED',
          'presentId': 'present-1',
          'activeAt': null,
          'expiresAt': null,
          'maxUseCount': 1,
          'usageCount': 1,
          'redemptions': [
            {
              'playerId': 'player-a',
              'playerDisplayName': 'A',
              'redeemedAt': '2026-07-05T12:34:00.000+08:00',
            },
          ],
        },
        {
          'id': 'expired-1',
          'code': 'EXPIRED001',
          'presentId': 'present-1',
          'activeAt': null,
          'expiresAt': '2020-01-01T00:00:00.000Z',
          'maxUseCount': 1,
          'usageCount': 0,
        },
        for (var index = 1; index <= 25; index++)
          {
            'id': 'bulk-$index',
            'code': 'BULK-${index.toString().padLeft(4, '0')}',
            'presentId': 'present-1',
            'activeAt': null,
            'expiresAt': null,
            'maxUseCount': 1,
            'usageCount': 0,
          },
        {
          'id': 'old-used',
          'code': 'OLD-USED',
          'presentId': 'present-old',
          'activeAt': null,
          'expiresAt': null,
          'maxUseCount': 1,
          'usageCount': 1,
          'redemptions': [
            {
              'playerId': 'player-b',
              'playerDisplayName': 'B',
              'redeemedAt': '2026-07-04T19:20:00.000+08:00',
            },
          ],
        },
      ],
    };
  }
  if (path == '/rpc/staff/redeem-codes/batch') {
    return {
      'redeemCodes': [
        {
          'id': 'batch-1',
          'code': '${jsonDecode(request.body)['prefix']}-001',
          'presentId': jsonDecode(request.body)['presentId'],
          'activeAt': null,
          'expiresAt': null,
          'maxUseCount': jsonDecode(request.body)['maxUseCount'],
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
