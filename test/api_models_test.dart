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
        'identities': [
          {
            'provider': 'qq',
            'subject': '826225045',
            'createdAt': '2026-07-04T12:00:00.000Z',
          },
        ],
      };
      final model = Player.fromJson(json);
      expect(model.id, 'player-1');
      expect(model.displayName, '张三');
      expect(model.status, 'active');
      expect(model.walletTotal, 150.5);
      expect(model.stayDurationMinutes, 45);
      expect(model.createdAt?.toUtc(), DateTime.utc(2026, 7, 4, 12, 0, 0));
      expect(model.identities.single.provider, 'qq');
      expect(model.identities.single.subject, '826225045');
    });

    test('CurrentStaff infers write permission from role', () {
      final owner = CurrentStaff.fromJson({
        'id': 'staff-1',
        'displayName': '店长',
        'role': 'owner',
      });
      final viewer = CurrentStaff.fromJson({
        'id': 'staff-2',
        'displayName': '店员',
        'role': 'viewer',
      });
      expect(owner.canWrite, true);
      expect(viewer.canWrite, false);
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
        'name': '新手大礼物',
        'grants': [
          {'assetType': 'currency', 'assetCode': 'free', 'amount': 20.0},
        ],
        'isArchived': false,
      };
      final model = Present.fromJson(json);
      expect(model.id, 'present-1');
      expect(model.name, '新手大礼物');
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
        'redemptions': [
          {
            'playerId': 'player-a',
            'playerDisplayName': 'A',
            'redeemedAt': '2026-07-05T12:34:00.000+08:00',
          },
        ],
        'expiresAt': '2026-08-04T12:00:00.000Z',
        'isRevoked': false,
        'createdAt': '2026-07-04T12:00:00.000Z',
      };
      final model = RedeemCode.fromJson(json);
      expect(model.id, 'code-1');
      expect(model.code, 'CDK12345');
      expect(model.usageLimit, 1);
      expect(model.usageCount, 0);
      expect(model.redemptions.single.playerDisplayName, 'A');
      expect(model.isRevoked, false);
    });

    test('PlayerRedeemRecord parses correctly', () {
      final model = PlayerRedeemRecord.fromJson({
        'codeId': 'code-1',
        'code': 'CDK12345',
        'presentId': 'present-1',
        'presentName': '月饼礼物',
        'redeemedAt': '2026-07-05T12:34:00.000+08:00',
      });
      expect(model.presentName, '月饼礼物');
      expect(model.code, 'CDK12345');
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

    test('PricingConfig parses backend priority time provider shape', () {
      final json = {
        'id': 'pricing-1',
        'name': '基础计费',
        'kind': 'time.priority',
        'enabled': true,
        'status': 'active',
        'provider': {
          'id': 'time.default',
          'rules': [
            {
              'id': 'base',
              'label': '基础',
              'priority': 0,
              'status': 'active',
              'timeRange': {'start': '10:00', 'end': '22:00'},
              'weekdays': [1, 2, 3, 4, 5, 6, 7],
              'specificDate': '2026-07-05',
              'pricing': {
                'unitMinutes': 30,
                'unitPrice': 10,
                'roundGraceMinutes': 5,
                'priceCap': 80,
              },
            },
          ],
        },
      };

      final model = PricingConfig.fromJson(json);

      expect(model.isActive, true);
      expect(model.isArchived, false);
      expect(model.rules.single.id, 'base');
      expect(model.rules.single.startTime, '10:00');
      expect(model.rules.single.endTime, '22:00');
      expect(model.rules.single.unitMinutes, 30);
      expect(model.rules.single.unitPrice, 10);
      expect(model.rules.single.graceMinutes, 5);
    });

    test('PricingConfig parses migrated date-time range rules', () {
      final json = {
        'id': 'legacy:pricing-config:time-priority',
        'name': '历史计费',
        'kind': 'time.priority',
        'enabled': false,
        'status': 'active',
        'provider': {
          'id': 'legacy.time-priority',
          'rules': [
            {
              'id': 'legacy.rule.12',
              'label': '春节',
              'priority': 3,
              'pricing': {
                'priceCap': 30,
                'unitPrice': 3,
                'unitMinutes': 30,
                'roundGraceMinutes': 3,
              },
              'dateTimeRange': {
                'start': '2026-02-17T00:00:21.735Z',
                'end': '2026-03-03T20:00:21.735Z',
              },
            },
          ],
        },
      };

      final model = PricingConfig.fromJson(json);

      expect(model.rules.single.startDateTime, '2026-02-17T00:00:21.735Z');
      expect(model.rules.single.endDateTime, '2026-03-03T20:00:21.735Z');
      expect(model.rules.single.startTime, '08:00');
      expect(model.rules.single.endTime, '04:00');
    });

    test('PricingTimeline parses backend timeline segments', () {
      final json = {
        'timeline': {
          'providerId': 'time.default',
          'localDate': '2026-07-05',
          'timeZone': 'Asia/Shanghai',
          'segments': [
            {
              'ruleId': 'base',
              'label': '基础按时计费',
              'startLabel': '10:00',
              'endLabel': '22:00',
              'pricing': {'unitPrice': 10},
            },
          ],
        },
      };

      final model = PricingTimeline.fromJson(json);

      expect(model.pricingConfigId, 'time.default');
      expect(model.timeline.single.label, '基础按时计费');
      expect(model.timeline.single.startTime, '10:00');
      expect(model.timeline.single.endTime, '22:00');
      expect(model.timeline.single.price, 10);
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

    test('BusinessItem parses backend management fields', () {
      final json = {
        'id': 'item-1',
        'kind': 'event.entry',
        'name': '周末挑战赛报名',
        'status': 'active',
        'price': 1200,
        'assetType': 'ticket',
        'assetCode': 'event.weekend',
        'activeAt': '2026-06-08T01:00:00.000Z',
        'expiresAt': '2026-06-09T01:00:00.000Z',
        'metadata': {'capacity': 24},
        'createdAt': '2026-06-01T01:00:00.000Z',
        'updatedAt': '2026-06-02T01:00:00.000Z',
      };

      final model = BusinessItem.fromJson(json);

      expect(model.id, 'item-1');
      expect(model.kind, 'event.entry');
      expect(model.status, 'active');
      expect(model.isArchived, false);
      expect(model.assetType, 'ticket');
      expect(model.assetCode, 'event.weekend');
      expect(model.activeAt?.toUtc(), DateTime.utc(2026, 6, 8, 1));
      expect(model.expiresAt?.toUtc(), DateTime.utc(2026, 6, 9, 1));
      expect(model.metadata?['capacity'], 24);
    });

    test('BusinessItemOrder parses backend staff order fields', () {
      final json = {
        'id': 'order-1',
        'businessItemId': 'item-1',
        'businessItemKind': 'food.drink',
        'businessItemName': '冰可乐',
        'playerId': 'player-1',
        'sessionId': 'session-1',
        'status': 'paid',
        'price': 350,
        'assetType': 'drink',
        'assetCode': 'cola',
        'metadata': {'channel': 'counter'},
        'createdAt': '2026-07-04T12:30:00.000Z',
        'updatedAt': '2026-07-04T12:31:00.000Z',
        'fulfilledAt': null,
        'cancelledAt': null,
      };

      final model = BusinessItemOrder.fromJson(json);

      expect(model.id, 'order-1');
      expect(model.itemId, 'item-1');
      expect(model.businessItemKind, 'food.drink');
      expect(model.itemName, '冰可乐');
      expect(model.sessionId, 'session-1');
      expect(model.status, 'paid');
      expect(model.assetType, 'drink');
      expect(model.assetCode, 'cola');
      expect(model.metadata?['channel'], 'counter');
      expect(model.updatedAt?.toUtc(), DateTime.utc(2026, 7, 4, 12, 31));
    });

    test('DeviceState parses correctly', () {
      final json = {
        'deviceId': 'device-1',
        'label': '前门闸机',
        'type': 'gate',
        'status': 'online',
        'state': 'unlocked',
        'metadata': {'battery': 92},
        'reportedAt': '2026-07-04T12:35:00.000Z',
        'reportedBy': 'gateway-1',
      };
      final model = DeviceState.fromJson(json);
      expect(model.deviceId, 'device-1');
      expect(model.status, 'online');
      expect(model.state, 'unlocked');
      expect(model.metadata?['battery'], 92);
    });

    test('DeviceCommand parses correctly', () {
      final json = {
        'id': 'cmd-1',
        'type': 'coin',
        'deviceId': 'coin-1',
        'staffId': 'staff-1',
        'playerId': null,
        'status': 'acked',
        'requestedAt': '2026-07-04T12:30:00.000Z',
        'ackedAt': '2026-07-04T12:30:05.000Z',
        'expiredAt': null,
      };
      final model = DeviceCommand.fromJson(json);
      expect(model.id, 'cmd-1');
      expect(model.commandType, 'coin');
      expect(model.requester, 'staff-1');
      expect(model.status, 'acked');
      expect(model.playerId, null);
      expect(model.staffId, 'staff-1');
      expect(model.expiredAt, null);
    });

    test('StaffUser parses correctly', () {
      final json = {
        'id': 'staff-1',
        'username': 'admin',
        'displayName': '店长',
        'role': 'manager',
        'status': 'disabled',
      };
      final model = StaffUser.fromJson(json);
      expect(model.id, 'staff-1');
      expect(model.displayName, '店长');
      expect(model.role, StaffRole.manager);
      expect(model.isArchived, true);
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

    test('SettingsData parses nested store settings', () {
      final model = SettingsData.fromJson({
        'store': {'name': 'PRiSM 店铺', 'timeZone': 'Asia/Shanghai'},
        'operations': {'coinCooldownMs': 1500},
      });
      expect(model.storeName, 'PRiSM 店铺');
      expect(model.timeZone, 'Asia/Shanghai');
      expect(model.coinCooldownMs, 1500);
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
          } else if (path == '/rpc/staff/business-items' &&
              request.method == 'POST') {
            final body = jsonDecode(request.body) as Map<String, dynamic>;
            return http.Response(
              jsonEncode({
                'businessItem': {
                  'id': 'item-created',
                  'status': 'active',
                  'createdAt': '2026-07-04T12:00:00.000Z',
                  'updatedAt': '2026-07-04T12:00:00.000Z',
                  ...body,
                },
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
      expect(summary.settledSessionsCount, 25);
      expect(summary.assetGrantsCount, 5);
      expect(summary.coinCommandsCount, 12);
    });

    test('report rows parse staff report fields', () {
      final settlement = SettlementReportRow.fromJson({
        'settlementId': 'settlement-1',
        'sessionId': 'session-1',
        'playerId': 'player-1',
        'playerDisplayName': 'A',
        'durationMinutes': null,
        'subtotal': 120,
        'total': 100,
        'settledAt': '2026-07-04T12:30:00.000Z',
      });
      expect(settlement.displayName, 'A');
      expect(settlement.durationMinutes, isNull);
      expect(settlement.total, 100);

      final player = PlayerReportRow.fromJson({
        'playerId': 'player-1',
        'playerDisplayName': 'A',
        'settlementCount': 3,
        'totalDurationMinutes': 180,
        'revenueTotal': 240,
        'lastSettledAt': '2026-07-04T12:30:00.000Z',
      });
      expect(player.displayName, 'A');
      expect(player.revenue, 240);
      expect(player.totalDurationMinutes, 180);
    });

    test('createBusinessItem posts full backend body', () async {
      await client.createBusinessItem(
        name: '周末挑战赛报名',
        price: 1200,
        kind: 'event.entry',
        assetType: 'ticket',
        assetCode: 'event.weekend',
        activeAt: DateTime.utc(2026, 6, 8, 1),
        expiresAt: DateTime.utc(2026, 6, 9, 1),
        metadata: {'capacity': 24},
      );

      final request = requests.last;
      expect(request.method, 'POST');
      expect(request.url.path, '/rpc/staff/business-items');
      expect(jsonDecode(request.body), {
        'kind': 'event.entry',
        'name': '周末挑战赛报名',
        'price': 1200,
        'assetType': 'ticket',
        'assetCode': 'event.weekend',
        'activeAt': '2026-06-08T01:00:00.000Z',
        'expiresAt': '2026-06-09T01:00:00.000Z',
        'metadata': {'capacity': 24},
      });
    });
  });
}
