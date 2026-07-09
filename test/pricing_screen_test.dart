import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/api/models.dart';
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
    expect(find.text('当天生效圆环'), findsOneWidget);
    expect(find.text('计费时段'), findsOneWidget);
    expect(find.text('方案信息'), findsOneWidget);
    expect(find.text('编辑时段'), findsOneWidget);
    expect(find.textContaining('10:00-22:00'), findsOneWidget);
    expect(find.byIcon(Icons.schedule), findsWidgets);
    expect(find.byType(Stepper), findsNothing);
    expect(find.widgetWithText(TextField, '方案名称'), findsOneWidget);
    expect(find.widgetWithText(TextField, '时段名称'), findsOneWidget);
    expect(find.textContaining('计费方案 ID'), findsWidgets);
    expect(find.textContaining('pricing-1'), findsWidgets);
    expect(find.byIcon(Icons.copy_all_outlined), findsWidgets);
    expect(find.textContaining('provider'), findsNothing);
    expect(find.textContaining('metadata'), findsNothing);
  });

  testWidgets('pricing plan id is visible for bot configuration', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('计费方案 ID'), findsWidgets);
    expect(find.text('pricing-1'), findsWidgets);
    expect(find.byTooltip('复制计费方案 ID'), findsWidgets);
  });

  testWidgets(
    'pricing editor keeps preview on the left and editing on the right',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1280, 1000);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final requests = <http.Request>[];
      await tester.pumpWidget(_buildPricingScreen(requests));
      await tester.pumpAndSettle();

      final planBottom = tester.getBottomLeft(find.text('计费方案')).dy;
      final timelineTop = tester.getTopLeft(find.text('当天生效圆环')).dy;
      final timelineLeft = tester.getTopLeft(find.text('当天生效圆环')).dx;
      final rulesLeft = tester.getTopLeft(find.text('计费时段')).dx;
      final basicsLeft = tester.getTopLeft(find.text('方案信息')).dx;
      final formLeft = tester.getTopLeft(find.text('编辑时段')).dx;

      expect(timelineTop, greaterThan(planBottom));
      expect(timelineLeft, lessThan(basicsLeft));
      expect(rulesLeft, lessThan(formLeft));
    },
  );

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
    requests.clear();

    await tester.ensureVisible(find.text('预览草稿'));
    await tester.tap(find.text('预览草稿').first);
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/pricing-timeline/preview',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    expect(body['localDate'], '2026-07-05');
    expect(body['provider']['rules'], hasLength(2));
    expect(body['provider']['rules'].first['timeRange']['start'], '00:00');
    expect(body['provider']['rules'].first['pricing']['unitMinutes'], 30);
    expect(body['provider']['rules'].first['pricing']['roundGraceMinutes'], 5);
    expect(body['provider']['rules'][1]['id'], 'night');
  });

  testWidgets('global cap editor previews cap rules as a timeline', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();
    requests.clear();

    await tester.tap(find.text('新建方案'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('全局封顶'));
    await tester.pumpAndSettle();

    expect(find.text('当天生效圆环'), findsOneWidget);
    expect(find.text('全局封顶金额'), findsOneWidget);

    final request = requests.lastWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/pricing-timeline/preview',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    expect(body['provider']['id'].toString(), startsWith('cap.'));
    expect(body['provider']['rules'].first['priceCap'], 80);
    expect(body['provider']['rules'].first.containsKey('pricing'), false);
  });

  testWidgets('existing pricing configs keep their original kind', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();
    requests.clear();

    await tester.tap(find.text('全局封顶'));
    await tester.pumpAndSettle();

    expect(find.text('全局封顶金额'), findsNothing);
    expect(find.text('计费单位（分钟）'), findsOneWidget);
    expect(
      find.textContaining('已有方案不能直接切换类型'),
      findsOneWidget,
    );
    expect(
      requests.where(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/pricing-timeline/preview',
      ),
      isEmpty,
    );
  });

  testWidgets('saved global cap config reloads with cap timeline values', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests, includeCap: true));
    await tester.pumpAndSettle();
    requests.clear();

    await tester.tap(find.text('日场全局封顶'));
    await tester.pumpAndSettle();

    expect(find.text('当天生效圆环'), findsOneWidget);
    expect(find.text('全局封顶金额'), findsOneWidget);
    expect(find.text('计费单位（分钟）'), findsNothing);

    final request = requests.lastWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/pricing-timeline/preview',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    final rules = ((body['provider'] as Map<String, dynamic>)['rules'] as List)
        .cast<Map<String, dynamic>>();
    expect(body['provider']['id'], 'cap.day');
    expect(rules.first['priceCap'], 69);
    expect(rules.first.containsKey('pricing'), false);
  });

  testWidgets('migrated date scoped rules stay scoped in preview drafts', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests, scopedRules: true));
    await tester.pumpAndSettle();

    final request = requests.lastWhere(
      (request) =>
          request.method == 'POST' &&
          request.url.path == '/rpc/staff/pricing-timeline/preview',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    final rules = ((body['provider'] as Map<String, dynamic>)['rules'] as List)
        .cast<Map<String, dynamic>>();
    final newYear = rules.singleWhere((rule) => rule['id'] == 'new-year');
    final spring = rules.singleWhere((rule) => rule['id'] == 'spring');

    expect(newYear['specificDates'], ['2026-01-01']);
    expect(newYear['timeRange'], {'start': '01:30', 'end': '23:59'});
    expect(spring['dateTimeRange'], {
      'start': '2026-02-17T00:00:21.735Z',
      'end': '2026-03-03T20:00:21.735Z',
    });
    expect(spring.containsKey('timeRange'), false);
  });

  test('pricing config parses imported date range rules', () {
    final config = PricingConfig.fromJson(_scopedPricingConfigJson());
    final spring = config.rules.singleWhere((rule) => rule.id == 'spring');

    expect(spring.hasTimeRange, false);
    expect(spring.startDateTime, '2026-02-17T00:00:21.735Z');
    expect(spring.endDateTime, '2026-03-03T20:00:21.735Z');
    expect(spring.unitPrice, 3);
    expect(spring.graceMinutes, 3);
    expect(spring.priceCap, 30);
  });

  test('ring timeline selects segments from backend minutes', () {
    const segments = [
      UnitPricing(
        ruleId: 'closed',
        startMinute: 0,
        endMinute: 600,
        startTime: '00:00',
        endTime: '10:00',
        price: 0,
        isClosed: true,
      ),
      UnitPricing(
        ruleId: 'business',
        startMinute: 600,
        endMinute: 1440,
        startTime: '10:00',
        endTime: '24:00',
        price: 10,
      ),
    ];

    expect(
      RingTimeline.minuteFromPoint(
        const Offset(100, 0),
        const Offset(100, 100),
      ),
      0,
    );
    expect(
      RingTimeline.minuteFromPoint(
        const Offset(200, 100),
        const Offset(100, 100),
      ),
      360,
    );
    expect(RingTimeline.segmentForMinute(segments, 599)?.ruleId, 'closed');
    expect(RingTimeline.segmentForMinute(segments, 600)?.ruleId, 'business');
    expect(RingTimeline.segmentForMinute(segments, 1439)?.ruleId, 'business');
  });

  testWidgets('save existing config patches complete backend body', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('保存方案'));
    await tester.tap(find.text('保存方案'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'PATCH' &&
          request.url.path == '/rpc/staff/pricing-configs/pricing-1',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    expect(body['name'], '基础计费');
    expect(body['enabled'], true);
    expect(body['provider']['rules'], hasLength(2));
    expect(body['provider']['rules'].first['pricing']['unitPrice'], 10);
    expect(body['provider']['rules'][1]['id'], 'night');
  });

  testWidgets('save preserves decimal pricing amounts', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(
      _buildPricingScreen(requests, decimalPricing: true),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('保存方案'));
    await tester.tap(find.text('保存方案'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'PATCH' &&
          request.url.path == '/rpc/staff/pricing-configs/pricing-1',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    final pricing =
        (((body['provider'] as Map<String, dynamic>)['rules'] as List).first
                as Map<String, dynamic>)['pricing']
            as Map<String, dynamic>;
    expect(pricing['unitPrice'], 5.5);
    expect(pricing['priceCap'], 12.5);
  });

  testWidgets('new pricing plan button opens an empty draft and posts create', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();
    requests.clear();

    await tester.tap(find.text('新建方案'));
    await tester.pumpAndSettle();

    expect(find.text('新建计费方案'), findsOneWidget);

    await tester.ensureVisible(find.text('保存方案'));
    await tester.tap(find.text('保存方案'));
    await tester.pumpAndSettle();

    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/pricing-configs',
      ),
      true,
    );
    expect(
      requests.any(
        (request) =>
            request.method == 'PATCH' &&
            request.url.path == '/rpc/staff/pricing-configs/pricing-1',
      ),
      false,
    );
  });

  testWidgets('saved pricing rules are archived instead of removed', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();
    requests.clear();

    await tester.ensureVisible(find.text('归档时段'));
    await tester.tap(find.text('归档时段'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('保存方案'));
    await tester.tap(find.text('保存方案'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'PATCH' &&
          request.url.path == '/rpc/staff/pricing-configs/pricing-1',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    final rules = ((body['provider'] as Map<String, dynamic>)['rules'] as List)
        .cast<Map<String, dynamic>>();

    expect(rules, hasLength(2));
    expect(rules.first['id'], 'base');
    expect(rules.first['status'], 'archived');
    expect(rules.last['status'], 'active');
  });

  testWidgets('archived pricing rules move into their own section', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('归档时段'));
    await tester.tap(find.text('归档时段'));
    await tester.pumpAndSettle();

    expect(find.text('归档时段（1）'), findsOneWidget);
    expect(find.text('夜间'), findsWidgets);
    expect(find.text('基础'), findsNothing);

    await tester.ensureVisible(find.text('归档时段（1）'));
    await tester.tap(find.text('归档时段（1）'));
    await tester.pumpAndSettle();

    expect(find.text('基础'), findsOneWidget);
    expect(find.text('恢复时段'), findsNothing);

    await tester.tap(find.text('基础'));
    await tester.pumpAndSettle();

    expect(find.text('恢复时段'), findsOneWidget);
  });

  testWidgets('fixed charge configs are editable without fake time rules', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests, includeFixed: true));
    await tester.pumpAndSettle();

    await tester.tap(find.text('入场固定收费'));
    await tester.pumpAndSettle();
    expect(find.text('固定收费'), findsWidgets);
    expect(find.widgetWithText(TextField, '账单显示名称'), findsOneWidget);
    expect(find.textContaining('¥300'), findsWidgets);

    await tester.ensureVisible(find.text('保存方案'));
    await tester.tap(find.text('保存方案'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'PATCH' &&
          request.url.path == '/rpc/staff/pricing-configs/pricing-fixed',
    );
    final body = jsonDecode(request.body) as Map<String, dynamic>;
    expect(body['name'], '入场固定收费');
    expect(body['enabled'], true);
    expect(body['provider'], {
      'id': 'cover-charge',
      'label': '入场费',
      'amount': 300,
    });
  });

  testWidgets('archive and restore call pricing endpoints', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildPricingScreen(requests, archived: true));
    await tester.pumpAndSettle();

    expect(find.text('归档方案（1）'), findsOneWidget);
    await tester.tap(find.text('归档方案（1）'));
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

  testWidgets('archived pricing configs fold away from active plans', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(
      _buildPricingScreen(requests, archived: true, includeFixed: true),
    );
    await tester.pumpAndSettle();

    expect(find.text('入场固定收费'), findsWidgets);
    expect(find.text('归档方案（1）'), findsOneWidget);
    expect(find.text('基础计费'), findsNothing);

    await tester.tap(find.text('归档方案（1）'));
    await tester.pumpAndSettle();

    expect(find.text('基础计费'), findsOneWidget);
  });
}

Widget _buildPricingScreen(
  List<http.Request> requests, {
  bool archived = false,
  String configName = '基础计费',
  bool includeFixed = false,
  bool includeCap = false,
  bool scopedRules = false,
  bool decimalPricing = false,
}) {
  final api = PrismApiClient(
    baseUrl: 'https://prism.example',
    token: 'staff-token',
    httpClient: MockClient((request) async {
      requests.add(request);
      return http.Response(
        jsonEncode(
          _responseFor(
            request,
            archived: archived,
            configName: configName,
            includeFixed: includeFixed,
            includeCap: includeCap,
            scopedRules: scopedRules,
            decimalPricing: decimalPricing,
          ),
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
  bool includeFixed = false,
  bool includeCap = false,
  bool scopedRules = false,
  bool decimalPricing = false,
}) {
  final path = request.url.path;
  if (path == '/rpc/staff/pricing-configs') {
    return {
      'pricingConfigs': [
        if (scopedRules) _scopedPricingConfigJson(),
        if (!scopedRules)
          _pricingConfigJson(
            archived: archived,
            name: configName,
            decimalPricing: decimalPricing,
          ),
        if (includeFixed) _fixedPricingConfigJson(),
        if (includeCap) _capPricingConfigJson(),
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
  if (path == '/rpc/staff/pricing-configs/pricing-fixed') {
    return {'pricingConfig': _fixedPricingConfigJson()};
  }
  if (path.contains('/archive') || path.contains('/restore')) {
    return {
      'pricingConfig': _pricingConfigJson(archived: path.contains('/archive')),
    };
  }
  return {};
}

Map<String, dynamic> _fixedPricingConfigJson() {
  return {
    'id': 'pricing-fixed',
    'kind': 'charge.fixed',
    'name': '入场固定收费',
    'enabled': true,
    'status': 'active',
    'provider': {'id': 'cover-charge', 'label': '入场费', 'amount': 300},
    'createdAt': '2026-07-05T00:00:00.000Z',
    'updatedAt': '2026-07-05T00:00:00.000Z',
  };
}

Map<String, dynamic> _capPricingConfigJson() {
  return {
    'id': 'pricing-cap',
    'kind': 'time.cap',
    'name': '日场全局封顶',
    'enabled': true,
    'status': 'active',
    'provider': {
      'id': 'cap.day',
      'includedPricingConfigIds': ['pricing-1'],
      'rules': [
        {
          'id': 'day-cap',
          'label': '日场封顶',
          'priority': 10,
          'timeRange': {'start': '10:00', 'end': '22:00'},
          'priceCap': 69,
        },
      ],
    },
    'createdAt': '2026-07-05T00:00:00.000Z',
    'updatedAt': '2026-07-05T00:00:00.000Z',
  };
}

Map<String, dynamic> _pricingConfigJson({
  required bool archived,
  String name = '基础计费',
  bool decimalPricing = false,
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
            'unitPrice': decimalPricing ? 5.5 : 10,
            'roundGraceMinutes': 5,
            'priceCap': decimalPricing ? 12.5 : 80,
          },
        },
        {
          'id': 'night',
          'label': '夜间',
          'priority': 10,
          'timeRange': {'start': '22:00', 'end': '00:00'},
          'pricing': {
            'unitMinutes': 30,
            'unitPrice': 8,
            'roundGraceMinutes': 5,
            'priceCap': 40,
          },
        },
      ],
    },
    'createdAt': '2026-07-05T00:00:00.000Z',
    'updatedAt': '2026-07-05T00:00:00.000Z',
  };
}

Map<String, dynamic> _scopedPricingConfigJson() {
  return {
    'id': 'pricing-scoped',
    'kind': 'time.priority',
    'name': '迁移计时规则',
    'enabled': true,
    'status': 'active',
    'provider': {
      'id': 'legacy.time-priority',
      'rules': [
        {
          'id': 'new-year',
          'label': '2026 元旦整日',
          'priority': 3,
          'specificDates': ['2026-01-01'],
          'timeRange': {'start': '01:30', 'end': '23:59'},
          'pricing': {
            'unitMinutes': 30,
            'unitPrice': 3,
            'roundGraceMinutes': 5,
            'priceCap': 30,
          },
        },
        {
          'id': 'spring',
          'label': '春节',
          'priority': 3,
          'dateTimeRange': {
            'start': '2026-02-17T00:00:21.735Z',
            'end': '2026-03-03T20:00:21.735Z',
          },
          'pricing': {
            'unitMinutes': 30,
            'unitPrice': 3,
            'roundGraceMinutes': 3,
            'priceCap': 30,
          },
        },
      ],
    },
    'createdAt': '2026-07-05T00:00:00.000Z',
    'updatedAt': '2026-07-05T00:00:00.000Z',
  };
}
