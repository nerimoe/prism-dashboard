import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:prism_dashboard/src/api/models.dart';
import 'package:prism_dashboard/src/features/shell/auth_screen.dart';

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
  });
}
