import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/features/services/services_screen.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  testWidgets('renders service items and orders with staff-facing copy', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildServicesScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('服务项目与订单'), findsOneWidget);
    expect(find.text('服务项目'), findsWidgets);
    expect(find.text('订单处理'), findsOneWidget);
    expect(find.text('周末挑战赛报名'), findsOneWidget);
    expect(find.text('活动报名'), findsOneWidget);
    expect(find.text('购买后发放：ticket/event.weekend'), findsOneWidget);
    expect(find.text('售卖中'), findsOneWidget);
    expect(find.textContaining('metadata'), findsNothing);
    expect(find.textContaining('sessionId'), findsNothing);

    await tester.tap(find.text('订单处理'));
    await tester.pumpAndSettle();
    expect(find.text('冰可乐'), findsOneWidget);
    expect(find.text('待出品'), findsOneWidget);
    expect(find.text('玩家 player-1'), findsOneWidget);
    expect(find.textContaining('session-1'), findsNothing);
  });

  testWidgets('service item creation posts complete backend body', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildServicesScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('添加服务'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '服务名称'), '包厢预约');
    await tester.enterText(find.widgetWithText(TextField, '发放内容类型'), 'ticket');
    await tester.enterText(
      find.widgetWithText(TextField, '发放内容编号'),
      'room.vip',
    );
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/business-items',
    );
    expect(jsonDecode(request.body), {
      'kind': 'event.entry',
      'name': '包厢预约',
      'price': 1200,
      'assetType': 'ticket',
      'assetCode': 'room.vip',
      'activeAt': null,
      'expiresAt': null,
      'metadata': null,
    });
  });

  testWidgets('archive and restore service items call backend actions', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildServicesScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('下架').first);
    await tester.pumpAndSettle();
    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/business-items/item-1/archive',
      ),
      true,
    );

    await tester.tap(find.text('恢复售卖').first);
    await tester.pumpAndSettle();
    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/business-items/item-2/restore',
      ),
      true,
    );
  });

  testWidgets('fulfill and cancel orders use confirmation dialogs', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildServicesScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('订单处理'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('核销').first);
    await tester.pumpAndSettle();
    expect(find.text('核销订单'), findsOneWidget);
    await tester.tap(find.text('核销').last);
    await tester.pumpAndSettle();
    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path ==
                '/rpc/staff/business-item-orders/order-1/fulfill',
      ),
      true,
    );

    await tester.tap(find.text('取消订单').first);
    await tester.pumpAndSettle();
    expect(find.text('取消订单'), findsWidgets);
    expect(find.textContaining('不会自动退款'), findsOneWidget);
    await tester.tap(find.text('取消订单').last);
    await tester.pumpAndSettle();
    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path ==
                '/rpc/staff/business-item-orders/order-1/cancel',
      ),
      true,
    );
  });
}

Widget _buildServicesScreen(List<http.Request> requests) {
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
      home: const Scaffold(body: ServicesScreen()),
    ),
  );
}

Map<String, dynamic> _responseFor(http.Request request) {
  final path = request.url.path;
  if (path == '/rpc/staff/business-items') {
    if (request.method == 'POST') {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      return {
        'businessItem': {
          'id': 'item-new',
          'status': 'active',
          'createdAt': '2026-07-04T12:00:00.000Z',
          'updatedAt': '2026-07-04T12:00:00.000Z',
          ...body,
        },
      };
    }
    return {
      'businessItems': [_businessItemJson(), _businessItemJson(archived: true)],
    };
  }
  if (path == '/rpc/staff/business-items/item-1/archive') {
    return {'businessItem': _businessItemJson(archived: true)};
  }
  if (path == '/rpc/staff/business-items/item-2/restore') {
    return {'businessItem': _businessItemJson()};
  }
  if (path == '/rpc/staff/business-item-orders') {
    return {
      'businessItemOrders': [_orderJson()],
    };
  }
  if (path == '/rpc/staff/business-item-orders/order-1/fulfill') {
    return {'businessItemOrder': _orderJson(status: 'fulfilled')};
  }
  if (path == '/rpc/staff/business-item-orders/order-1/cancel') {
    return {'businessItemOrder': _orderJson(status: 'cancelled')};
  }
  return {};
}

Map<String, dynamic> _businessItemJson({bool archived = false}) {
  return {
    'id': archived ? 'item-2' : 'item-1',
    'kind': archived ? 'food.drink' : 'event.entry',
    'name': archived ? '冰可乐' : '周末挑战赛报名',
    'status': archived ? 'archived' : 'active',
    'price': archived ? 350 : 1200,
    'assetType': archived ? 'drink' : 'ticket',
    'assetCode': archived ? 'cola' : 'event.weekend',
    'activeAt': '2026-07-04T10:00:00.000Z',
    'expiresAt': '2026-07-05T10:00:00.000Z',
    'metadata': {'capacity': 24},
    'createdAt': '2026-07-04T09:00:00.000Z',
    'updatedAt': '2026-07-04T09:00:00.000Z',
  };
}

Map<String, dynamic> _orderJson({String status = 'paid'}) {
  return {
    'id': 'order-1',
    'businessItemId': 'item-2',
    'businessItemKind': 'food.drink',
    'businessItemName': '冰可乐',
    'playerId': 'player-1',
    'sessionId': 'session-1',
    'status': status,
    'price': 350,
    'assetType': 'drink',
    'assetCode': 'cola',
    'metadata': {'channel': 'counter'},
    'createdAt': '2026-07-04T12:30:00.000Z',
    'updatedAt': '2026-07-04T12:31:00.000Z',
    'fulfilledAt': status == 'fulfilled' ? '2026-07-04T12:40:00.000Z' : null,
    'cancelledAt': status == 'cancelled' ? '2026-07-04T12:42:00.000Z' : null,
  };
}
