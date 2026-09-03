import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/api/models.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/features/system/system_screen.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  testWidgets('updates store settings with staff-facing controls', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildSystemScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('店铺设置'), findsWidgets);
    expect(find.text('PRiSM 店铺'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, '店铺名称'), '新店名');
    await tester.tap(find.text('保存设置'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'PUT' && request.url.path == '/rpc/staff/settings',
    );
    expect(jsonDecode(request.body), {
      'store': {'name': '新店名', 'timeZone': 'Asia/Shanghai'},
      'operations': {'coinCooldownMs': 1500},
      'homeAssistantConnection': {
        'url': 'https://ha.example',
        'token': 'ha-secret',
      },
      'homeAssistantDevices': [],
      'registration': {'defaultPresentId': null},
    });
    expect(find.text('店铺设置已保存。'), findsOneWidget);
  });

  testWidgets('selects the default registration present', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildSystemScreen(requests));
    await tester.pumpAndSettle();

    expect(find.text('新用户注册礼物包'), findsOneWidget);
    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('新用户欢迎包').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存设置'));
    await tester.pumpAndSettle();

    final request = requests.singleWhere(
      (request) =>
          request.method == 'PUT' && request.url.path == '/rpc/staff/settings',
    );
    expect((jsonDecode(request.body) as Map)['registration'], {
      'defaultPresentId': 'present-welcome',
    });
  });

  testWidgets('creates staff user and resets password', (tester) async {
    final requests = <http.Request>[];
    await tester.pumpWidget(_buildSystemScreen(requests));
    await tester.pumpAndSettle();

    await tester.tap(find.text('员工权限').first);
    await tester.pumpAndSettle();
    expect(find.text('店长小林'), findsOneWidget);
    expect(find.textContaining('店长'), findsWidgets);

    await tester.tap(find.text('添加员工'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '登录名'), 'cashier');
    await tester.enterText(find.widgetWithText(TextField, '员工姓名'), '收银员');
    await tester.tap(find.text('添加').last);
    await tester.pumpAndSettle();

    final create = requests.singleWhere(
      (request) =>
          request.method == 'POST' && request.url.path == '/rpc/staff/users',
    );
    expect((jsonDecode(create.body) as Map)['username'], 'cashier');

    await tester.tap(find.byIcon(Icons.lock_reset).first);
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '新密码'), 'newpass123');
    await tester.tap(find.text('重置密码').last);
    await tester.pumpAndSettle();
    expect(
      requests.any(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/users/staff-2/password' &&
            (jsonDecode(request.body) as Map)['password'] == 'newpass123',
      ),
      true,
    );
  });

  testWidgets(
    'creates API token for integration role, shows business roles, and revokes token',
    (tester) async {
      final requests = <http.Request>[];
      await tester.pumpWidget(_buildSystemScreen(requests));
      await tester.pumpAndSettle();

      await tester.tap(find.text('接入密钥').first);
      await tester.pumpAndSettle();
      expect(find.text('机器通道'), findsOneWidget);
      expect(find.textContaining('机器软件接入'), findsOneWidget);
      expect(find.text('可使用'), findsOneWidget);

      await tester.tap(find.text('新建密钥'));
      await tester.pumpAndSettle();
      expect(find.text('机器人/店内入口'), findsOneWidget);
      expect(find.text('设备接入'), findsNothing);
      expect(find.text('玩家接口'), findsNothing);

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      expect(find.text('机器人/店内入口'), findsWidgets);
      expect(find.text('机器软件接入'), findsWidgets);
      expect(find.text('设备接入'), findsNothing);
      expect(find.text('玩家接口'), findsNothing);
      await tester.tap(find.text('机器人/店内入口').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, '用途名称'), '机器人验证');
      await tester.tap(find.text('创建').last);
      await tester.pumpAndSettle();
      expect(find.text('integration_secret_once'), findsOneWidget);
      await tester.tap(find.text('我已保存'));
      await tester.pumpAndSettle();

      final create = requests.singleWhere(
        (request) =>
            request.method == 'POST' &&
            request.url.path == '/rpc/staff/api-tokens',
      );
      expect(jsonDecode(create.body), {
        'label': '机器人验证',
        'role': 'integration',
      });

      await tester.tap(find.text('撤销').first);
      await tester.pumpAndSettle();
      expect(
        requests.any(
          (request) =>
              request.method == 'POST' &&
              request.url.path == '/rpc/staff/api-tokens/token-1/revoke',
        ),
        true,
      );
    },
  );

  testWidgets('shows an error when API token creation fails', (tester) async {
    final requests = <http.Request>[];
    final api = PrismApiClient(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      httpClient: MockClient((request) async {
        requests.add(request);
        if (request.url.path == '/rpc/staff/api-tokens' &&
            request.method == 'POST') {
          return http.Response(
            jsonEncode({
              'error': {
                'code': 'FORBIDDEN',
                'message': 'Staff role manager or owner required.',
              },
            }),
            403,
            headers: {'content-type': 'application/json'},
          );
        }
        return http.Response(
          jsonEncode(_responseFor(request)),
          200,
          headers: {'content-type': 'application/json'},
        );
      }),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [apiClientProvider.overrideWithValue(api)],
        child: MaterialApp(
          theme: buildPrismDashboardTheme(
            ColorScheme.fromSeed(seedColor: prismSeedColor),
          ),
          home: Scaffold(body: SystemScreen(api: api, canWrite: true)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('接入密钥').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('新建密钥'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, '用途名称'), '机器人验证');
    await tester.tap(find.text('创建').last);
    await tester.pumpAndSettle();

    expect(
      find.text('创建失败：Staff role manager or owner required.'),
      findsOneWidget,
    );
    expect(find.text('新建接入密钥'), findsOneWidget);
  });

  testWidgets('manager loads settings without owner-only resources', (
    tester,
  ) async {
    final requests = <http.Request>[];
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

    await tester.pumpWidget(
      ProviderScope(
        overrides: [apiClientProvider.overrideWithValue(api)],
        child: MaterialApp(
          theme: buildPrismDashboardTheme(
            ColorScheme.fromSeed(seedColor: prismSeedColor),
          ),
          home: Scaffold(
            body: SystemScreen(
              api: api,
              canWrite: true,
              role: StaffRole.manager,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('PRiSM 店铺'), findsOneWidget);
    expect(
      requests.where((request) => request.url.path == '/rpc/staff/users'),
      isEmpty,
    );
    expect(
      requests.where((request) => request.url.path == '/rpc/staff/api-tokens'),
      isEmpty,
    );
    await tester.tap(find.text('员工权限').first);
    await tester.pumpAndSettle();
    expect(find.text('仅店主可管理员工'), findsOneWidget);
    await tester.tap(find.text('接入密钥').first);
    await tester.pumpAndSettle();
    expect(find.text('仅店主可管理接入密钥'), findsOneWidget);
  });
}

Widget _buildSystemScreen(List<http.Request> requests) {
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
      home: Scaffold(body: SystemScreen(canWrite: true)),
    ),
  );
}

Map<String, dynamic> _responseFor(http.Request request) {
  final path = request.url.path;
  if (path == '/rpc/staff/settings') {
    if (request.method == 'PUT') return {'settings': jsonDecode(request.body)};
    return {
      'settings': {
        'store': {'name': 'PRiSM 店铺', 'timeZone': 'Asia/Shanghai'},
        'operations': {'coinCooldownMs': 1500},
        'homeAssistantConnection': {
          'url': 'https://ha.example',
          'token': 'ha-secret',
        },
        'homeAssistantDevices': [],
        'registration': {'defaultPresentId': null},
      },
    };
  }
  if (path == '/rpc/staff/presents') {
    return {
      'presents': [
        {
          'id': 'present-welcome',
          'name': '新用户欢迎包',
          'status': 'active',
          'oncePerPlayer': false,
          'grants': [],
        },
      ],
    };
  }
  if (path == '/rpc/staff/users') {
    if (request.method == 'POST') {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      return {
        'staffUser': {
          'id': 'staff-new',
          'status': 'active',
          'createdAt': '2026-07-05T00:00:00.000Z',
          'updatedAt': '2026-07-05T00:00:00.000Z',
          ...body,
        },
      };
    }
    return {
      'staffUsers': [_staffUserJson()],
    };
  }
  if (path == '/rpc/staff/users/staff-2/password') {
    return {'staffUser': _staffUserJson()};
  }
  if (path == '/rpc/staff/api-tokens') {
    if (request.method == 'POST') {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      return {
        'apiToken': {
          'id': 'token-new',
          'token': 'integration_secret_once',
          'tokenPrefix': 'integ',
          'status': 'active',
          'createdAt': '2026-07-05T00:00:00.000Z',
          ...body,
        },
      };
    }
    return {
      'apiTokens': [_apiTokenJson()],
    };
  }
  if (path == '/rpc/staff/api-tokens/token-1/revoke') {
    return {'apiToken': _apiTokenJson(revoked: true)};
  }
  return {};
}

Map<String, dynamic> _staffUserJson() => {
  'id': 'staff-2',
  'username': 'manager',
  'displayName': '店长小林',
  'role': 'manager',
  'status': 'active',
  'createdAt': '2026-07-05T00:00:00.000Z',
  'updatedAt': '2026-07-05T00:00:00.000Z',
};

Map<String, dynamic> _apiTokenJson({bool revoked = false}) => {
  'id': 'token-1',
  'label': '机器通道',
  'role': 'machine',
  'tokenPrefix': 'mach',
  'status': revoked ? 'revoked' : 'active',
  'createdAt': '2026-07-05T00:00:00.000Z',
  'lastUsedAt': null,
  'revokedAt': revoked ? '2026-07-05T01:00:00.000Z' : null,
};
