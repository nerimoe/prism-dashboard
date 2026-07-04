import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api_client.dart';
import 'api/models.dart';

const _baseUrlKey = 'prism.dashboard.api.baseurl';
const _tokenKey = 'prism.dashboard.admin.token';

final appControllerProvider = AsyncNotifierProvider<AppController, AppState>(AppController.new);

final apiClientProvider = Provider<PrismApiClient>((ref) {
  final state = ref.watch(appControllerProvider).value;
  return PrismApiClient(baseUrl: state?.baseUrl ?? defaultBaseUrl, token: state?.token);
});

String get defaultBaseUrl {
  final uri = Uri.base;
  if (uri.hasScheme && uri.host.isNotEmpty) return '${uri.scheme}://${uri.host}:8787';
  return 'http://localhost:8787';
}

class AppState {
  const AppState({
    required this.baseUrl,
    required this.token,
    required this.setupStatus,
    required this.staff,
  });

  final String baseUrl;
  final String? token;
  final SetupStatus? setupStatus;
  final CurrentStaff? staff;

  bool get isInstalled => setupStatus?.installed ?? true;
  bool get isAuthenticated => staff != null && token != null;

  AppState copyWith({
    String? baseUrl,
    String? token,
    bool clearToken = false,
    SetupStatus? setupStatus,
    CurrentStaff? staff,
    bool clearStaff = false,
  }) {
    return AppState(
      baseUrl: baseUrl ?? this.baseUrl,
      token: clearToken ? null : token ?? this.token,
      setupStatus: setupStatus ?? this.setupStatus,
      staff: clearStaff ? null : staff ?? this.staff,
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
    try {
      setupStatus = await client.setupStatus();
      if (token != null && setupStatus.installed) staff = await client.me();
    } on PrismApiException {
      if (token != null) await _prefs.remove(_tokenKey);
    } catch (_) {
      setupStatus = null;
    }

    return AppState(baseUrl: baseUrl, token: staff == null ? null : token, setupStatus: setupStatus, staff: staff);
  }

  Future<void> updateBaseUrl(String value) async {
    final current = state.value;
    await _prefs.setString(_baseUrlKey, value);
    await _prefs.remove(_tokenKey);
    state = AsyncData(
      (current ?? AppState(baseUrl: value, token: null, setupStatus: null, staff: null))
          .copyWith(baseUrl: value, clearToken: true, clearStaff: true),
    );
    await refreshSetupStatus();
  }

  Future<void> refreshSetupStatus() async {
    final current = state.value;
    if (current == null) return;
    final setup = await PrismApiClient(baseUrl: current.baseUrl).setupStatus();
    state = AsyncData(current.copyWith(setupStatus: setup));
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
    await PrismApiClient(baseUrl: current.baseUrl).install(
      storeName: storeName,
      timeZone: timeZone,
      username: username,
      displayName: displayName,
      password: password,
      coinCooldownMs: coinCooldownMs,
    );
    state = AsyncData(current.copyWith(setupStatus: const SetupStatus(installed: true)));
    await login(username: username, password: password);
  }

  Future<void> login({required String username, required String password}) async {
    final current = state.value!;
    final result = await PrismApiClient(baseUrl: current.baseUrl).login(username: username, password: password);
    await _prefs.setString(_tokenKey, result.$1);
    state = AsyncData(current.copyWith(token: result.$1, staff: result.$2));
  }

  Future<void> logout() async {
    final current = state.value;
    await _prefs.remove(_tokenKey);
    if (current != null) state = AsyncData(current.copyWith(clearToken: true, clearStaff: true));
  }
}
