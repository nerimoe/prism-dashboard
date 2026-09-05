import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api_client.dart';
import 'api/models.dart';
import 'shared/admin_time_zone.dart';
import 'version.dart';

const _baseUrlKey = 'prism.dashboard.api.baseurl';
const _tokenKey = 'prism.dashboard.admin.token';
const _usernameKey = 'prism.dashboard.admin.username';
const _passwordKey = 'prism.dashboard.admin.password';

final appControllerProvider = AsyncNotifierProvider<AppController, AppState>(
  AppController.new,
);

final apiClientProvider = Provider<PrismApiClient>((ref) {
  final state = ref.watch(appControllerProvider).value;
  return PrismApiClient(
    baseUrl: state?.baseUrl ?? defaultBaseUrl,
    token: state?.token,
  );
});

String get defaultBaseUrl {
  final uri = Uri.base;
  return defaultBaseUrlFor(uri);
}

String defaultBaseUrlFor(Uri uri) {
  if (!uri.hasScheme || uri.host.isEmpty) return 'http://localhost:8787';
  if (uri.host == 'localhost' || uri.host == '127.0.0.1' || uri.host == '::1') {
    return '${uri.scheme}://${uri.host}:8787';
  }
  return '';
}

class AppState {
  const AppState({
    required this.baseUrl,
    required this.token,
    required this.setupStatus,
    required this.staff,
    this.savedUsername = '',
    this.savedPassword = '',
    this.backendVersion,
    this.oneTimeApiTokens = const [],
  });

  final String baseUrl;
  final String? token;
  final SetupStatus? setupStatus;
  final CurrentStaff? staff;
  final String savedUsername;
  final String savedPassword;
  final PrismVersion? backendVersion;
  final List<ApiToken> oneTimeApiTokens;

  bool get isInstalled => setupStatus?.installed ?? true;
  bool get isAuthenticated => staff != null && token != null;

  AppState copyWith({
    String? baseUrl,
    String? token,
    bool clearToken = false,
    SetupStatus? setupStatus,
    CurrentStaff? staff,
    bool clearStaff = false,
    String? savedUsername,
    String? savedPassword,
    PrismVersion? backendVersion,
    bool clearBackendVersion = false,
    List<ApiToken>? oneTimeApiTokens,
    bool clearOneTimeApiTokens = false,
  }) {
    return AppState(
      baseUrl: baseUrl ?? this.baseUrl,
      token: clearToken ? null : token ?? this.token,
      setupStatus: setupStatus ?? this.setupStatus,
      staff: clearStaff ? null : staff ?? this.staff,
      savedUsername: savedUsername ?? this.savedUsername,
      savedPassword: savedPassword ?? this.savedPassword,
      backendVersion: clearBackendVersion
          ? null
          : backendVersion ?? this.backendVersion,
      oneTimeApiTokens: clearOneTimeApiTokens
          ? const []
          : oneTimeApiTokens ?? this.oneTimeApiTokens,
    );
  }
}

class AppController extends AsyncNotifier<AppState> {
  late final Future<SharedPreferences> _prefs;

  @override
  AppState build() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then(_restoreSavedPreferences).ignore();
    return AppState(
      baseUrl: defaultBaseUrl,
      token: null,
      setupStatus: null,
      staff: null,
    );
  }

  void _restoreSavedPreferences(SharedPreferences prefs) {
    final savedBaseUrl = prefs.getString(_baseUrlKey);
    final savedUsername = prefs.getString(_usernameKey) ?? '';
    final savedPassword = prefs.getString(_passwordKey) ?? '';
    final current = state.value;
    if (current == null || current.setupStatus != null) {
      return;
    }
    final nextBaseUrl =
        (savedBaseUrl != null && current.baseUrl == defaultBaseUrl)
            ? savedBaseUrl
            : current.baseUrl;
    state = AsyncData(
      current.copyWith(
        baseUrl: nextBaseUrl,
        savedUsername: savedUsername,
        savedPassword: savedPassword,
      ),
    );
  }

  Future<void> updateBaseUrl(String value) async {
    final current = state.value;
    if (current?.baseUrl == value && current?.setupStatus != null) return;
    _prefs.then((prefs) async {
      await prefs.setString(_baseUrlKey, value);
      await prefs.remove(_tokenKey);
    }).ignore();
    state = AsyncData(
      (current ??
              AppState(
                baseUrl: value,
                token: null,
                setupStatus: null,
                staff: null,
              ))
          .copyWith(
            baseUrl: value,
            clearToken: true,
            clearStaff: true,
            clearBackendVersion: true,
          ),
    );
    await refreshSetupStatus();
  }

  Future<void> refreshSetupStatus() async {
    final current = state.value;
    if (current == null) return;
    final client = PrismApiClient(baseUrl: current.baseUrl);
    final setup = await client.setupStatus();
    state = AsyncData(
      current.copyWith(setupStatus: setup, clearBackendVersion: true),
    );
  }

  Future<void> install({
    required String storeName,
    required String timeZone,
    required String username,
    required String displayName,
    required String password,
    required int coinCooldownMs,
  }) async {
    final current = state.value!;
    final installResult = await PrismApiClient(baseUrl: current.baseUrl)
        .install(
          storeName: storeName,
          timeZone: timeZone,
          username: username,
          displayName: displayName,
          password: password,
          coinCooldownMs: coinCooldownMs,
        );
    final oneTimeApiTokens = listOf(
      installResult['apiTokens'],
      ApiToken.fromJson,
    );
    setAdminTimeZone(timeZone);
    state = AsyncData(
      current.copyWith(setupStatus: const SetupStatus(installed: true)),
    );
    await login(username: username, password: password);
    final authenticated = state.value;
    if (authenticated != null && oneTimeApiTokens.isNotEmpty) {
      state = AsyncData(
        authenticated.copyWith(oneTimeApiTokens: oneTimeApiTokens),
      );
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final current = state.value!;
    final result = await PrismApiClient(
      baseUrl: current.baseUrl,
    ).login(username: username, password: password);
    PrismVersion? backendVersion = current.backendVersion;
    try {
      backendVersion = await PrismApiClient(
        baseUrl: current.baseUrl,
        token: result.$1,
      ).getVersion();
    } catch (_) {
      // Login remains available if an older backend has no version route.
    }
    try {
      final settings = await PrismApiClient(
        baseUrl: current.baseUrl,
        token: result.$1,
      ).getSettings();
      setAdminTimeZone(settings.timeZone);
    } catch (_) {
      setAdminTimeZone(defaultAdminTimeZone);
    }
    state = AsyncData(
      current.copyWith(
        token: result.$1,
        staff: result.$2,
        savedUsername: username,
        savedPassword: password,
        backendVersion: backendVersion,
      ),
    );
    _prefs.then((prefs) async {
      await prefs.setString(_tokenKey, result.$1);
      await prefs.setString(_usernameKey, username);
      await prefs.setString(_passwordKey, password);
    }).ignore();
  }

  Future<void> logout() async {
    final current = state.value;
    if (current?.token != null) {
      try {
        await PrismApiClient(
          baseUrl: current!.baseUrl,
          token: current.token,
        ).logout();
      } catch (_) {
        // Local logout still proceeds when the server is unreachable.
      }
    }
    if (current != null) {
      state = AsyncData(current.copyWith(clearToken: true, clearStaff: true));
    }
    _prefs.then((prefs) => prefs.remove(_tokenKey)).ignore();
  }

  void clearOneTimeApiTokens() {
    final current = state.value;
    if (current == null || current.oneTimeApiTokens.isEmpty) return;
    state = AsyncData(current.copyWith(clearOneTimeApiTokens: true));
  }
}
