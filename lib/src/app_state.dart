import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api_client.dart';
import 'api/models.dart';
import 'shared/admin_time_zone.dart';
import 'version.dart';

const _baseUrlKey = 'prism.dashboard.api.baseurl';
const _tokenKey = 'prism.dashboard.admin.token';

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
  if (uri.hasScheme && uri.host.isNotEmpty) {
    return '${uri.scheme}://${uri.host}:8787';
  }
  return 'http://localhost:8787';
}

class AppState {
  const AppState({
    required this.baseUrl,
    required this.token,
    required this.setupStatus,
    required this.staff,
    this.backendVersion,
    this.oneTimeApiTokens = const [],
  });

  final String baseUrl;
  final String? token;
  final SetupStatus? setupStatus;
  final CurrentStaff? staff;
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
  late SharedPreferences _prefs;

  @override
  Future<AppState> build() async {
    _prefs = await SharedPreferences.getInstance();
    final baseUrl = _prefs.getString(_baseUrlKey) ?? defaultBaseUrl;
    final token = _prefs.getString(_tokenKey);
    final client = PrismApiClient(baseUrl: baseUrl, token: token);

    SetupStatus? setupStatus;
    CurrentStaff? staff;
    PrismVersion? backendVersion;
    try {
      backendVersion = await client.getVersion();
    } catch (_) {
      backendVersion = null;
    }
    try {
      setupStatus = await client.setupStatus();
      if (token != null && setupStatus.installed) staff = await client.me();
    } on PrismApiException {
      if (token != null) await _prefs.remove(_tokenKey);
    } catch (_) {
      setupStatus = null;
    }
    if (staff != null) {
      try {
        setAdminTimeZone((await client.getSettings()).timeZone);
      } catch (_) {
        setAdminTimeZone(defaultAdminTimeZone);
      }
    }

    return AppState(
      baseUrl: baseUrl,
      token: staff == null ? null : token,
      setupStatus: setupStatus,
      staff: staff,
      backendVersion: backendVersion,
    );
  }

  Future<void> updateBaseUrl(String value) async {
    final current = state.value;
    await _prefs.setString(_baseUrlKey, value);
    await _prefs.remove(_tokenKey);
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
    PrismVersion? backendVersion;
    try {
      backendVersion = await client.getVersion();
    } catch (_) {
      backendVersion = null;
    }
    final setup = await client.setupStatus();
    state = AsyncData(
      current.copyWith(
        setupStatus: setup,
        backendVersion: backendVersion,
        clearBackendVersion: backendVersion == null,
      ),
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
    await _prefs.setString(_tokenKey, result.$1);
    state = AsyncData(
      current.copyWith(
        token: result.$1,
        staff: result.$2,
        backendVersion: backendVersion,
      ),
    );
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
    await _prefs.remove(_tokenKey);
    if (current != null) {
      state = AsyncData(current.copyWith(clearToken: true, clearStaff: true));
    }
  }

  void clearOneTimeApiTokens() {
    final current = state.value;
    if (current == null || current.oneTimeApiTokens.isEmpty) return;
    state = AsyncData(current.copyWith(clearOneTimeApiTokens: true));
  }
}
