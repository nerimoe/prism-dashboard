import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/api/models.dart';
import 'package:prism_dashboard/src/features/shell/auth_screen.dart';
import 'package:prism_dashboard/src/version.dart';

void main() {
  testWidgets('login screen shows the frontend build version', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AuthScreen(
            appState: AppState(
              baseUrl: 'https://prism.example',
              token: null,
              setupStatus: SetupStatus(installed: true),
              staff: null,
            ),
          ),
        ),
      ),
    );

    expect(
      find.byKey(const ValueKey('dashboard-login-version')),
      findsOneWidget,
    );
    expect(find.text('前端版本 dev'), findsOneWidget);
    expect(find.text('登录'), findsOneWidget);
    expect(find.text('账号'), findsOneWidget);
  });

  testWidgets('initial screen combines server and login fields', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AuthScreen(
            appState: AppState(
              baseUrl: '',
              token: null,
              setupStatus: null,
              staff: null,
            ),
          ),
        ),
      ),
    );

    expect(find.text('服务器地址'), findsOneWidget);
    expect(find.text('账号'), findsOneWidget);
    expect(find.text('密码'), findsOneWidget);
    expect(find.text('登录'), findsOneWidget);
    expect(find.text('连接服务器'), findsNothing);
  });

  testWidgets('auth screen populates and updates saved credentials', (
    tester,
  ) async {
    const initialState = AppState(
      baseUrl: 'http://localhost:8787',
      token: null,
      setupStatus: null,
      staff: null,
      savedUsername: '',
      savedPassword: '',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: AuthScreen(appState: initialState),
      ),
    );

    final usernameFinder = find.widgetWithText(TextField, '账号');
    final passwordFinder = find.widgetWithText(TextField, '密码');
    expect(tester.widget<TextField>(usernameFinder).controller?.text, '');
    expect(tester.widget<TextField>(passwordFinder).controller?.text, '');

    const restoredState = AppState(
      baseUrl: 'http://localhost:8787',
      token: null,
      setupStatus: null,
      staff: null,
      savedUsername: 'admin_user',
      savedPassword: 'secret_password',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: AuthScreen(appState: restoredState),
      ),
    );

    expect(
      tester.widget<TextField>(usernameFinder).controller?.text,
      'admin_user',
    );
    expect(
      tester.widget<TextField>(passwordFinder).controller?.text,
      'secret_password',
    );
  });

  test('PrismVersion display returns revision when version is dev or matches revision', () {
    const devWithRev = PrismVersion(version: 'dev', revision: '5881b21');
    expect(devWithRev.display, '5881b21');

    const revOnly = PrismVersion(version: '5881b21', revision: '5881b21');
    expect(revOnly.display, '5881b21');
  });

  test('PrismVersion display returns semver and revision when both are specific', () {
    const release = PrismVersion(version: '1.0.0', revision: '5881b21');
    expect(release.display, '1.0.0 (5881b21)');
  });

  test('PrismVersion display falls back to version when revision is unknown', () {
    const devUnknown = PrismVersion(version: 'dev', revision: 'unknown');
    expect(devUnknown.display, 'dev');
  });
}
