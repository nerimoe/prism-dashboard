import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:prism_dashboard/src/api/api_client.dart';
import 'package:prism_dashboard/src/api/models.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/features/shell/home_shell.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  testWidgets('HomeShell navigation switches between new feature screens', (tester) async {
    // 1. Set screen size to desktop view
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.binding.setSurfaceSize(const Size(1280, 720));

    // 2. Prepare Mock API Client and AppState
    final mockApi = PrismApiClient(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      httpClient: MockClient((request) async {
        if (request.url.path == '/rpc/staff/live-players') {
          return http.Response(
            '{"players": []}',
            200,
            headers: {'content-type': 'application/json'},
          );
        }
        return http.Response('{}', 200, headers: {'content-type': 'application/json'});
      }),
    );

    const staff = CurrentStaff(
      id: 'staff-1',
      displayName: '店长张三',
      role: StaffRole.owner,
      canWrite: true,
    );

    final appState = AppState(
      baseUrl: 'https://prism.example',
      token: 'staff-token',
      setupStatus: const SetupStatus(installed: true),
      staff: staff,
    );

    // 3. Pump widget
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiClientProvider.overrideWithValue(mockApi),
        ],
        child: MaterialApp(
          theme: buildPrismDashboardTheme(
            ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
          ),
          home: HomeShell(appState: appState),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 4. Assert default screen is OperationsScreen (现场工作台)
    expect(find.text('在场玩家'), findsWidgets);

    // 5. Navigate to 玩家档案
    await tester.tap(find.text('玩家档案'));
    await tester.pumpAndSettle();
    expect(find.text('暂未选中玩家'), findsOneWidget); // EmptyState in PlayersScreen
    expect(find.text('新建玩家'), findsNothing); // Removed old _ActionTile

    // 6. Navigate to 礼包与兑换码 (Wires to assets destination)
    await tester.tap(find.text('礼包与兑换码'));
    await tester.pumpAndSettle();
    expect(find.text('资产与礼包'), findsWidgets);
    expect(find.text('暂无资产配置数据'), findsOneWidget);

    // 7. Navigate to 设备管理 (Wires to devices destination)
    await tester.tap(find.text('设备管理'));
    await tester.pumpAndSettle();
    expect(find.text('设备看板'), findsWidgets);
    expect(find.text('暂无在线设备'), findsOneWidget);

    // 8. Navigate to 按时计费 (Wires to pricing destination)
    await tester.tap(find.text('按时计费'));
    await tester.pumpAndSettle();
    expect(find.text('计费配置'), findsWidgets);
    expect(find.text('暂无计费配置'), findsOneWidget);

    // 9. Navigate to 服务项目 (Wires to services destination)
    await tester.tap(find.text('服务项目'));
    await tester.pumpAndSettle();
    expect(find.text('服务项目与订单'), findsWidgets);
    expect(find.text('暂无订单记录'), findsOneWidget);

    // 10. Navigate to 营业报表 (Wires to reports destination)
    await tester.tap(find.text('营业报表'));
    await tester.pumpAndSettle();
    expect(find.text('营业报表'), findsWidgets);
    expect(find.text('暂无报表数据'), findsOneWidget);

    // 11. Navigate to 员工权限 (Wires to system destination)
    await tester.tap(find.text('员工权限'));
    await tester.pumpAndSettle();
    expect(find.text('员工与系统'), findsWidgets);
    expect(find.text('设置项加载中'), findsOneWidget);
  });
}
