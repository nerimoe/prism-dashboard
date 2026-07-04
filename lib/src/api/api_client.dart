import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';

class PrismApiException implements Exception {
  const PrismApiException(this.message, this.code, this.status);

  final String message;
  final String code;
  final int status;

  @override
  String toString() => '$code ($status): $message';
}

class PrismApiClient {
  PrismApiClient({required this.baseUrl, this.token, http.Client? httpClient}) : _http = httpClient ?? http.Client();

  final String baseUrl;
  final String? token;
  final http.Client _http;

  PrismApiClient withAuth({String? baseUrl, String? token}) {
    return PrismApiClient(baseUrl: baseUrl ?? this.baseUrl, token: token ?? this.token, httpClient: _http);
  }

  Future<SetupStatus> setupStatus() async {
    return SetupStatus.fromJson(await get('/rpc/setup/status', auth: false));
  }

  Future<Map<String, dynamic>> install({
    required String storeName,
    required String timeZone,
    required String username,
    required String displayName,
    required String password,
    required int coinCooldownMs,
  }) {
    return post(
      '/rpc/setup/install',
      auth: false,
      body: {
        'storeName': storeName,
        'timeZone': timeZone,
        'owner': {'username': username, 'displayName': displayName, 'password': password},
        'coinCooldownMs': coinCooldownMs,
      },
    );
  }

  Future<(String token, CurrentStaff staff)> login({required String username, required String password}) async {
    final json = await post('/rpc/admin/login', auth: false, body: {'username': username, 'password': password});
    return (
      ((json['session'] as Map?)?['token'] as String?) ?? '',
      CurrentStaff.fromJson(((json['staff'] as Map?) ?? {}).cast<String, dynamic>()),
    );
  }

  Future<CurrentStaff> me() async {
    final json = await get('/rpc/staff/me');
    return CurrentStaff.fromJson(((json['staff'] as Map?) ?? {}).cast<String, dynamic>());
  }

  Future<List<LivePlayer>> listLivePlayers() async {
    final json = await get('/rpc/staff/live-players');
    return listOf(json['players'], LivePlayer.fromJson);
  }

  Future<SettlementPreview> previewAllCheckout(String playerId) async {
    return SettlementPreview.fromJson(await post('/rpc/staff/players/$playerId/checkout/preview-all'));
  }

  Future<void> confirmAllCheckout(String playerId) async {
    await post('/rpc/staff/players/$playerId/checkout/confirm-all');
  }

  Future<void> stopPlayerSession({required String playerId, required String sessionId}) async {
    await post('/rpc/staff/players/$playerId/sessions/$sessionId/stop');
  }

  Future<void> startPlayerSession(String playerId, {List<String>? pricingConfigIds, String? label}) async {
    await post(
      '/rpc/staff/players/$playerId/session/start',
      body: {
        if (pricingConfigIds != null) 'pricingConfigIds': pricingConfigIds,
        if (label != null && label.isNotEmpty) 'label': label,
      },
    );
  }

  Future<Map<String, dynamic>> get(String path, {bool auth = true}) {
    return _request('GET', path, auth: auth);
  }

  Future<Map<String, dynamic>> post(String path, {bool auth = true, Object? body}) {
    return _request('POST', path, auth: auth, body: body);
  }

  Future<Map<String, dynamic>> _request(String method, String path, {required bool auth, Object? body}) async {
    final uri = Uri.parse(baseUrl).resolve(path);
    final headers = <String, String>{'Accept': 'application/json'};
    if (body != null) headers['Content-Type'] = 'application/json';
    if (auth && token != null) headers['Authorization'] = 'Bearer $token';

    final response = switch (method) {
      'GET' => await _http.get(uri, headers: headers),
      'POST' => await _http.post(uri, headers: headers, body: body == null ? null : jsonEncode(body)),
      _ => throw ArgumentError.value(method, 'method'),
    };

    final decoded = response.body.isEmpty ? <String, dynamic>{} : jsonDecode(response.body);
    final json = decoded is Map ? decoded.cast<String, dynamic>() : <String, dynamic>{};

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final error = (json['error'] as Map?)?.cast<String, dynamic>() ?? const {};
      throw PrismApiException(
        error['message'] as String? ?? '请求没有成功，请稍后再试。',
        error['code'] as String? ?? 'HTTP_${response.statusCode}',
        response.statusCode,
      );
    }
    return json;
  }
}
