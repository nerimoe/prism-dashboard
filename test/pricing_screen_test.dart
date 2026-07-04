import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/features/pricing/pricing_screen.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  testWidgets('renders pricing config editor with structured controls', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('计费配置'), findsOneWidget);
    expect(find.text('基础计费'), findsWidgets);
    expect(find.byIcon(Icons.schedule), findsWidgets);
    expect(find.byType(Stepper), findsNothing);
    expect(find.byType(TextField), findsNothing);
    expect(find.textContaining('provider'), findsNothing);
    expect(find.textContaining('metadata'), findsNothing);
  });

  testWidgets('migrated pricing names are shown as staff-facing copy', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(
      _buildPricingScreen(requests, configName: 'Legacy time priority pricing'),
    );
    await tester.pumpAndSettle();

    expect(find.text('迁移计时规则'), findsWidgets);
    expect(find.textContaining('Legacy time priority pricing'), findsNothing);
  });

  testWidgets('preview draft posts localDate and provider rules', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('预览草稿').first);
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/pricing-timeline/preview',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    expect(body['localDate'], '2026-07-05');
    expect(body['provider']['rules'].first['timeRange']['start'], '10:00');
    expect(body['provider']['rules'].first['pricing']['unitMinutes'], 30);
    expect(body['provider']['rules'].first['pricing']['roundGraceMinutes'], 5);
  });

  testWidgets('save existing config patches complete backend body', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('保存规则').last);
    await tester.tap(find.text('保存规则').last);
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'PATCH' &&
          request.url.path == '/rpc/staff/pricing-configs/pricing-1',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    expect(body['name'], '基础计费');
    expect(body['enabled'], true);
    expect(body['provider']['rules'].first['pricing']['unitPrice'], 10);
  });

  testWidgets('archive and restore call pricing endpoints', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests, archived: true));
    await tester.pumpAndSettle();

    await tester.tap(find.text('恢复'));
    await tester.pumpAndSettle();
    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/pricing-configs/pricing-1/restore',
      ),
      true,
    );
  });
}

Widget _buildPricingScreen(
  List<http.Request> requests, {
  bool archived = false,
  String configName = '基础计费',
}) {
  final api = PrismApiClient(
    baseUrl: 'https://prism.example',
    token: 'staff-token',
    httpClient: MockClient((request) async {
      requests.add(request);
      return http.Response(
        jsonEncode(
          _responseFor(request, archived: archived, configName: configName),
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
      home: const Scaffold(body: PricingScreen()),
    ),
  );
}

Map<String, dynamic> _responseFor(
  http.Request request, {
  required bool archived,
  String configName = '基础计费',
}) {
  final path = request.url.path;
  if (path == '/rpc/staff/pricing-configs') {
    return {
      'pricingConfigs': [
        _pricingConfigJson(archived: archived, name: configName),
      ],
    };
  }
  if (path == '/rpc/staff/pricing-extensions') {
    return {
      'pricingExtensions': [
        {'id': 'time.priority', 'name': '按时计费', 'status': 'ready'},
      ],
    };
  }
  if (path == '/rpc/staff/pricing-timeline/preview' ||
      path.contains('/timeline')) {
    return {
      'timeline': {
        'providerId': 'time.default',
        'localDate': '2026-07-05',
        'timeZone': 'Asia/Shanghai',
        'segments': [
          {
            'ruleId': 'base',
            'label': '基础按时计费',
            'priority': 0,
            'startMinute': 600,
            'endMinute': 1320,
            'startLabel': '10:00',
            'endLabel': '22:00',
            'pricing': {'unitPrice': 10},
          },
        ],
      },
    };
  }
  if (path == '/rpc/staff/pricing-configs/pricing-1') {
    return {'pricingConfig': _pricingConfigJson(archived: false)};
  }
  if (path.contains('/archive') || path.contains('/restore')) {
    return {
      'pricingConfig': _pricingConfigJson(archived: path.contains('/archive')),
    };
  }
  return {};
}

Map<String, dynamic> _pricingConfigJson({
  required bool archived,
  String name = '基础计费',
}) {
  return {
    'id': 'pricing-1',
    'kind': 'time.priority',
    'name': name,
    'enabled': !archived,
    'status': archived ? 'archived' : 'active',
    'provider': {
      'id': 'time.default',
      'rules': [
        {
          'id': 'base',
          'label': '基础',
          'priority': 0,
          'timeRange': {'start': '00:00', 'end': '00:00'},
          'pricing': {
            'unitMinutes': 30,
            'unitPrice': 10,
            'roundGraceMinutes': 5,
            'priceCap': 80,
          },
        },
      ],
    },
    'createdAt': '2026-07-05T00:00:00.000Z',
    'updatedAt': '2026-07-05T00:00:00.000Z',
  };
}
