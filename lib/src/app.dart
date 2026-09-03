import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_state.dart';
import 'features/shell/auth_screen.dart';
import 'features/shell/home_shell.dart';

class PrismDashboardApp extends ConsumerWidget {
  const PrismDashboardApp({
    super.key,
    required this.lightTheme,
    required this.darkTheme,
  });

  final ThemeData lightTheme;
  final ThemeData darkTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appControllerProvider);
    return MaterialApp(
      title: 'prism_dashboard',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: state.when(
        loading: () => AuthScreen(
          appState: AppState(
            baseUrl: defaultBaseUrl,
            token: null,
            setupStatus: null,
            staff: null,
          ),
        ),
        error: (error, stackTrace) =>
            AuthScreen(initialError: error.toString()),
        data: (appState) {
          if (!appState.isInstalled || !appState.isAuthenticated) {
            return AuthScreen(appState: appState);
          }
          return HomeShell(appState: appState);
        },
      ),
    );
  }
}
