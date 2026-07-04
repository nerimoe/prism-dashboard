import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/api/models.dart';

void main() {
  group('Dart Models JSON parsing tests', () {
    test('Player parses correctly', () {
      final json = {
        'id': 'player-1',
        'displayName': '张三',
        'status': 'active',
        'walletTotal': 150.5,
        'stayDurationMinutes': 45,
        'createdAt': '2026-07-04T12:00:00.000Z',
      };
      final model = Player.fromJson(json);
      expect(model.id, 'player-1');
      expect(model.displayName, '张三');
      expect(model.status, 'active');
      expect(model.walletTotal, 150.5);
      expect(model.stayDurationMinutes, 45);
      expect(model.createdAt?.toUtc(), DateTime.utc(2026, 7, 4, 12, 0, 0));
    });

    test('AssetDefinition parses correctly', () {
      final json = {
        'type': 'currency',
        'code': 'paid',
        'name': '实存余额',
        'status': 'active',
      };
      final model = AssetDefinition.fromJson(json);
      expect(model.type, 'currency');
      expect(model.code, 'paid');
      expect(model.displayName, '实存余额');
      expect(model.isArchived, false);
    });

    test('PlayerAssets parses correctly', () {
      final json = {
        'playerId': 'player-1',
        'holdings': [
          {'assetType': 'currency', 'assetCode': 'paid', 'quantity': 100.0},
        ],
        'ledgerEntries': [
          {
            'id': 'ledger-1',
            'assetType': 'currency',
            'assetCode': 'paid',
            'delta': 100.0,
            'reason': '充值',
            'createdAt': '2026-07-04T12:05:00.000Z',
          },
        ],
      };
      final model = PlayerAssets.fromJson(json);
      expect(model.playerId, 'player-1');
      expect(model.holdings.first.assetCode, 'paid');
      expect(model.ledger.first.reason, '充值');
    });

    test('Present parses correctly', () {
      final json = {
        'id': 'present-1',
        'name': '新手大礼包',
        'grants': [
          {'assetType': 'currency', 'assetCode': 'free', 'amount': 20.0},
        ],
        'isArchived': false,
      };
      final model = Present.fromJson(json);
      expect(model.id, 'present-1');
      expect(model.name, '新手大礼包');
      expect(model.grants.first.amount, 20.0);
    });

    test('RedeemCode parses correctly', () {
      final json = {
        'id': 'code-1',
        'code': 'CDK12345',
        'grants': [
          {'assetType': 'currency', 'assetCode': 'paid', 'amount': 50.0},
        ],
        'maxUseCount': 1,
        'usageCount': 0,
        'expiresAt': '2026-08-04T12:00:00.000Z',
        'isRevoked': false,
        'createdAt': '2026-07-04T12:00:00.000Z',
      };
      final model = RedeemCode.fromJson(json);
      expect(model.id, 'code-1');
      expect(model.code, 'CDK12345');
      expect(model.usageLimit, 1);
      expect(model.usageCount, 0);
      expect(model.isRevoked, false);
    });

    test('PricingConfig parses correctly', () {
      final json = {
        'id': 'pricing-1',
        'name': '基础计费规则',
        'kind': 'time.priority',
        'provider': {
          'rules': [
            {
              'label': '日场计费',
              'priority': 1,
              'startTime': '08:00',
              'endTime': '22:00',
              'weekdays': [1, 2, 3, 4, 5],
              'specificDate': '2026-07-04',
              'unitMinutes': 30,
              'unitPrice': 10.0,
              'graceMinutes': 5,
              'priceCap': 50.0,
            },
          ],
        },
        'status': 'active',
        'enabled': true,
      };
      final model = PricingConfig.fromJson(json);
      expect(model.id, 'pricing-1');
      expect(model.name, '基础计费规则');
      expect(model.rules.first.label, '日场计费');
      expect(model.rules.first.weekdays, [1, 2, 3, 4, 5]);
      expect(model.rules.first.priceCap, 50.0);
    });

    test('BusinessItemOrder parses correctly', () {
      final json = {
        'id': 'order-1',
        'playerId': 'player-1',
        'businessItemId': 'item-1',
        'businessItemName': '冰可乐',
        'price': 3.5,
        'status': 'pending',
        'createdAt': '2026-07-04T12:30:00.000Z',
      };
      final model = BusinessItemOrder.fromJson(json);
      expect(model.id, 'order-1');
      expect(model.itemName, '冰可乐');
      expect(model.price, 3.5);
      expect(model.status, 'pending');
    });

    test('DeviceState parses correctly', () {
      final json = {
        'deviceId': 'device-1',
        'label': '前门闸机',
        'type': 'gate',
        'status': 'online',
        'reportedAt': '2026-07-04T12:35:00.000Z',
        'reportedBy': 'gateway-1',
      };
      final model = DeviceState.fromJson(json);
      expect(model.deviceId, 'device-1');
      expect(model.status, 'online');
    });

    test('DeviceCommand parses correctly', () {
      final json = {
        'id': 'cmd-1',
        'type': 'coin',
        'deviceId': 'coin-1',
        'staffId': 'staff-1',
        'status': 'acked',
        'requestedAt': '2026-07-04T12:30:00.000Z',
        'ackedAt': '2026-07-04T12:30:05.000Z',
      };
      final model = DeviceCommand.fromJson(json);
      expect(model.id, 'cmd-1');
      expect(model.status, 'acked');
    });

    test('StaffUser parses correctly', () {
      final json = {
        'id': 'staff-1',
        'username': 'admin',
        'displayName': '店长',
        'role': 'manager',
        'status': 'active',
      };
      final model = StaffUser.fromJson(json);
      expect(model.id, 'staff-1');
      expect(model.displayName, '店长');
      expect(model.role, StaffRole.manager);
    });

    test('ApiToken parses correctly', () {
      final json = {
        'id': 'token-1',
        'label': '网关密钥',
        'token': 'secret-xyz',
        'createdAt': '2026-07-04T12:00:00.000Z',
        'role': 'agent',
        'status': 'active',
      };
      final model = ApiToken.fromJson(json);
      expect(model.id, 'token-1');
      expect(model.token, 'secret-xyz');
      expect(model.isRevoked, false);
      expect(model.toJson().containsKey('token'), false);
      expect(model.toString().contains('secret-xyz'), false);
    });
  });

  group('PrismApiClient Staff Methods Tests', () {
    late PrismApiClient client;
    late List<http.Request> requests;

    setUp(() {
      requests = [];
      client = PrismApiClient(
        baseUrl: 'https://prism.example',
        token: 'test-token',
        httpClient: MockClient((request) async {
          requests.add(request);
          final path = request.url.path;

          if (path == '/rpc/staff/users' && request.method == 'GET') {
            return http.Response(
              jsonEncode({
                'staffUsers': [
                  {
                    'id': 'staff-1',
                    'username': 'admin',
                    'displayName': '店长',
                    'role': 'manager',
                    'status': 'active',
                  },
                ],
              }),
              200,
              headers: {'content-type': 'application/json'},
            );
          } else if (path == '/rpc/staff/users' && request.method == 'POST') {
            return http.Response(
              jsonEncode({
                'staffUser': {
                  'id': 'staff-2',
                  'username': 'cashier',
                  'displayName': '收银员',
                  'role': 'viewer',
                  'isArchived': false,
                },
              }),
              200,
              headers: {'content-type': 'application/json'},
            );
          } else if (path == '/rpc/staff/settings' && request.method == 'PUT') {
            return http.Response(
              jsonEncode({
                'settings': {
                  'store': {'name': 'New Store', 'timeZone': 'Asia/Shanghai'},
                  'operations': {'coinCooldownMs': 500},
                },
              }),
              200,
              headers: {'content-type': 'application/json'},
            );
          } else if (path == '/rpc/staff/players' && request.method == 'GET') {
            return http.Response(
              jsonEncode({
                'players': [
                  {
                    'id': 'p-1',
                    'displayName': '张三',
                    'status': 'active',
                    'walletTotal': 50.0,
                    'stayDurationMinutes': 10,
                  },
                ],
              }),
              200,
              headers: {'content-type': 'application/json'},
            );
          } else if (path == '/rpc/staff/reports/summary' &&
              request.method == 'GET') {
            expect(request.url.queryParameters['from'], '2026-07-01');
            return http.Response(
              jsonEncode({
                'summary': {
                  'revenueTotal': 1000.5,
                  'sessionCount': 25,
                  'assetGrantTotal': 5,
                  'coinCommandCount': 12,
                },
              }),
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
    });

    test('listStaffUsers requests correct endpoint', () async {
      final users = await client.listStaffUsers();
      expect(requests.first.method, 'GET');
      expect(requests.first.url.path, '/rpc/staff/users');
      expect(users.first.username, 'admin');
    });

    test('createStaffUser posts correct body', () async {
      final user = await client.createStaffUser(
        username: 'cashier',
        displayName: '收银员',
        role: 'viewer',
        password: 'password123',
      );
      expect(requests.first.method, 'POST');
      expect(requests.first.url.path, '/rpc/staff/users');
      final body = jsonDecode(requests.first.body);
      expect(body['username'], 'cashier');
      expect(body['password'], 'password123');
      expect(user.displayName, '收银员');
    });

    test('updateSettings puts correct body', () async {
      final settings = await client.updateSettings(
        storeName: 'New Store',
        timeZone: 'Asia/Shanghai',
        coinCooldownMs: 500,
      );
      expect(requests.first.method, 'PUT');
      expect(requests.first.url.path, '/rpc/staff/settings');
      final body = jsonDecode(requests.first.body);
      expect(body['store']['name'], 'New Store');
      expect(body['operations']['coinCooldownMs'], 500);
      expect(settings.storeName, 'New Store');
    });

    test('reportsSummary passes query parameters', () async {
      final summary = await client.reportsSummary(start: '2026-07-01');
      expect(requests.first.method, 'GET');
      expect(requests.first.url.path, '/rpc/staff/reports/summary');
      expect(summary.revenue, 1000.5);
    });
  });
}
