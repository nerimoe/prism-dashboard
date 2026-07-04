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

  // Staff APIs from rpc manifest
  Future<List<StaffUser>> listStaffUsers() async {
    final json = await get('/rpc/staff/users');
    return listOf(json['users'], StaffUser.fromJson);
  }

  Future<StaffUser> createStaffUser({
    required String username,
    required String displayName,
    required String role,
    required String password,
  }) async {
    final json = await post('/rpc/staff/users', body: {
      'username': username,
      'displayName': displayName,
      'role': role,
      'password': password,
    });
    return StaffUser.fromJson((json['staffUser'] as Map).cast<String, dynamic>());
  }

  Future<StaffUser> updateStaffUser(
    String staffUserId, {
    String? displayName,
    String? role,
    bool? isArchived,
  }) async {
    final json = await patch('/rpc/staff/users/$staffUserId', body: {
      if (displayName != null) 'displayName': displayName,
      if (role != null) 'role': role,
      if (isArchived != null) 'isArchived': isArchived,
    });
    return StaffUser.fromJson((json['staffUser'] as Map).cast<String, dynamic>());
  }

  Future<void> resetStaffUserPassword(String staffUserId, {required String password}) async {
    await post('/rpc/staff/users/$staffUserId/password', body: {'password': password});
  }

  Future<SettingsData> getSettings() async {
    final json = await get('/rpc/staff/settings');
    return SettingsData.fromJson((json['settings'] as Map).cast<String, dynamic>());
  }

  Future<SettingsData> updateSettings({
    required String storeName,
    required String timeZone,
    required int coinCooldownMs,
  }) async {
    final json = await put('/rpc/staff/settings', body: {
      'storeName': storeName,
      'timeZone': timeZone,
      'coinCooldownMs': coinCooldownMs,
    });
    return SettingsData.fromJson((json['settings'] as Map).cast<String, dynamic>());
  }

  Future<List<ApiToken>> listApiTokens() async {
    final json = await get('/rpc/staff/api-tokens');
    return listOf(json['tokens'], ApiToken.fromJson);
  }

  Future<ApiToken> createApiToken({required String label}) async {
    final json = await post('/rpc/staff/api-tokens', body: {'label': label});
    return ApiToken.fromJson((json['apiToken'] as Map).cast<String, dynamic>());
  }

  Future<void> revokeApiToken(String tokenId) async {
    await post('/rpc/staff/api-tokens/$tokenId/revoke');
  }

  Future<List<Player>> listPlayers() async {
    final json = await get('/rpc/staff/players');
    return listOf(json['players'], Player.fromJson);
  }

  Future<Player> createPlayer({required String displayName, Map<String, num>? initialGrants}) async {
    final json = await post('/rpc/staff/players', body: {
      'displayName': displayName,
      if (initialGrants != null) 'initialGrants': initialGrants,
    });
    return Player.fromJson((json['player'] as Map).cast<String, dynamic>());
  }

  Future<void> updatePlayerStatus(String playerId, {required String status}) async {
    await patch('/rpc/staff/players/$playerId/status', body: {'status': status});
  }

  Future<void> bindPlayerIdentity(String playerId, {required String provider, required String subject}) async {
    await post('/rpc/staff/players/$playerId/identities', body: {
      'provider': provider,
      'subject': subject,
    });
  }

  Future<void> grantAssets(
    String playerId, {
    required String assetType,
    required String assetCode,
    required num amount,
    required String reason,
  }) async {
    await post('/rpc/staff/players/$playerId/assets/grants', body: {
      'assetType': assetType,
      'assetCode': assetCode,
      'amount': amount,
      'reason': reason,
    });
  }

  Future<void> adjustAssets(
    String playerId, {
    required String assetType,
    required String assetCode,
    required num amount,
    required String reason,
  }) async {
    await post('/rpc/staff/players/$playerId/assets/adjustments', body: {
      'assetType': assetType,
      'assetCode': assetCode,
      'amount': amount,
      'reason': reason,
    });
  }

  Future<PlayerAssets> getPlayerAssets(String playerId) async {
    final json = await get('/rpc/staff/players/$playerId/assets');
    return PlayerAssets.fromJson(json);
  }

  Future<List<LiveSession>> getPlayerSessionHistory(String playerId) async {
    final json = await get('/rpc/staff/players/$playerId/sessions/history');
    return listOf(json['sessions'], LiveSession.fromJson);
  }

  Future<RedeemCode> createRedeemCode({
    required String code,
    required List<Map<String, dynamic>> grants,
    required int usageLimit,
    String? expiresAt,
  }) async {
    final json = await post('/rpc/staff/redeem-codes', body: {
      'code': code,
      'grants': grants,
      'usageLimit': usageLimit,
      if (expiresAt != null) 'expiresAt': expiresAt,
    });
    return RedeemCode.fromJson((json['redeemCode'] as Map).cast<String, dynamic>());
  }

  Future<List<RedeemCode>> listRedeemCodes() async {
    final json = await get('/rpc/staff/redeem-codes');
    return listOf(json['redeemCodes'], RedeemCode.fromJson);
  }

  Future<List<RedeemCode>> createRedeemCodeBatch({
    required int count,
    required List<Map<String, dynamic>> grants,
    required int usageLimit,
    String? expiresAt,
  }) async {
    final json = await post('/rpc/staff/redeem-codes/batch', body: {
      'count': count,
      'grants': grants,
      'usageLimit': usageLimit,
      if (expiresAt != null) 'expiresAt': expiresAt,
    });
    return listOf(json['redeemCodes'], RedeemCode.fromJson);
  }

  Future<void> revokeRedeemCode(String codeId) async {
    await post('/rpc/staff/redeem-codes/$codeId/revoke');
  }

  Future<Present> createPresent({
    required String name,
    required List<Map<String, dynamic>> grants,
  }) async {
    final json = await post('/rpc/staff/presents', body: {
      'name': name,
      'grants': grants,
    });
    return Present.fromJson((json['present'] as Map).cast<String, dynamic>());
  }

  Future<List<Present>> listPresents() async {
    final json = await get('/rpc/staff/presents');
    return listOf(json['presents'], Present.fromJson);
  }

  Future<void> archivePresent(String presentId) async {
    await post('/rpc/staff/presents/$presentId/archive');
  }

  Future<void> restorePresent(String presentId) async {
    await post('/rpc/staff/presents/$presentId/restore');
  }

  Future<List<AssetDefinition>> listAssetDefinitions() async {
    final json = await get('/rpc/staff/asset-definitions');
    return listOf(json['definitions'], AssetDefinition.fromJson);
  }

  Future<void> saveAssetDefinition(String assetType, String assetCode, {required String displayName}) async {
    await put('/rpc/staff/asset-definitions/$assetType/$assetCode', body: {'displayName': displayName});
  }

  Future<void> archiveAssetDefinition(String assetType, String assetCode) async {
    await post('/rpc/staff/asset-definitions/$assetType/$assetCode/archive');
  }

  Future<void> restoreAssetDefinition(String assetType, String assetCode) async {
    await post('/rpc/staff/asset-definitions/$assetType/$assetCode/restore');
  }

  Future<List<BusinessItem>> listBusinessItems() async {
    final json = await get('/rpc/staff/business-items');
    return listOf(json['items'], BusinessItem.fromJson);
  }

  Future<BusinessItem> createBusinessItem({
    required String name,
    required num price,
    required String kind,
  }) async {
    final json = await post('/rpc/staff/business-items', body: {
      'name': name,
      'price': price,
      'kind': kind,
    });
    return BusinessItem.fromJson((json['item'] as Map).cast<String, dynamic>());
  }

  Future<void> archiveBusinessItem(String businessItemId) async {
    await post('/rpc/staff/business-items/$businessItemId/archive');
  }

  Future<void> restoreBusinessItem(String businessItemId) async {
    await post('/rpc/staff/business-items/$businessItemId/restore');
  }

  Future<List<BusinessItemOrder>> listBusinessItemOrders() async {
    final json = await get('/rpc/staff/business-item-orders');
    return listOf(json['orders'], BusinessItemOrder.fromJson);
  }

  Future<void> fulfillBusinessItemOrder(String orderId) async {
    await post('/rpc/staff/business-item-orders/$orderId/fulfill');
  }

  Future<void> cancelBusinessItemOrder(String orderId) async {
    await post('/rpc/staff/business-item-orders/$orderId/cancel');
  }

  Future<List<PricingConfig>> listPricingConfigs() async {
    final json = await get('/rpc/staff/pricing-configs');
    return listOf(json['configs'], PricingConfig.fromJson);
  }

  Future<PricingTimeline> getPricingTimeline(String pricingConfigId) async {
    final json = await get('/rpc/staff/pricing-configs/$pricingConfigId/timeline');
    return PricingTimeline.fromJson(json);
  }

  Future<PricingTimeline> previewPricingTimeline({
    required String name,
    required String kind,
    required List<Map<String, dynamic>> rules,
  }) async {
    final json = await post('/rpc/staff/pricing-timeline/preview', body: {
      'name': name,
      'kind': kind,
      'rules': rules,
    });
    return PricingTimeline.fromJson(json);
  }

  Future<PricingConfig> createPricingConfig({
    required String name,
    required String kind,
    required List<Map<String, dynamic>> rules,
  }) async {
    final json = await post('/rpc/staff/pricing-configs', body: {
      'name': name,
      'kind': kind,
      'rules': rules,
    });
    return PricingConfig.fromJson((json['config'] as Map).cast<String, dynamic>());
  }

  Future<PricingConfig> updatePricingConfig(
    String pricingConfigId, {
    String? name,
    List<Map<String, dynamic>>? rules,
    bool? isActive,
  }) async {
    final json = await patch('/rpc/staff/pricing-configs/$pricingConfigId', body: {
      if (name != null) 'name': name,
      if (rules != null) 'rules': rules,
      if (isActive != null) 'isActive': isActive,
    });
    return PricingConfig.fromJson((json['config'] as Map).cast<String, dynamic>());
  }

  Future<void> archivePricingConfig(String pricingConfigId) async {
    await post('/rpc/staff/pricing-configs/$pricingConfigId/archive');
  }

  Future<void> restorePricingConfig(String pricingConfigId) async {
    await post('/rpc/staff/pricing-configs/$pricingConfigId/restore');
  }

  Future<List<DeviceState>> listDeviceStates() async {
    final json = await get('/rpc/staff/device-states');
    return listOf(json['devices'], DeviceState.fromJson);
  }

  Future<List<DeviceCommand>> listDeviceCommands() async {
    final json = await get('/rpc/staff/device-commands');
    return listOf(json['commands'], DeviceCommand.fromJson);
  }

  Future<ReportSummary> reportsSummary({String? start, String? end}) async {
    final json = await get('/rpc/staff/reports/summary', query: {
      if (start != null) 'start': start,
      if (end != null) 'end': end,
    });
    return ReportSummary.fromJson(json);
  }

  Future<List<SettlementReportRow>> reportSettlements({String? start, String? end}) async {
    final json = await get('/rpc/staff/reports/settlements', query: {
      if (start != null) 'start': start,
      if (end != null) 'end': end,
    });
    return listOf(json['settlements'], SettlementReportRow.fromJson);
  }

  Future<List<PlayerReportRow>> reportPlayers({String? start, String? end}) async {
    final json = await get('/rpc/staff/reports/players', query: {
      if (start != null) 'start': start,
      if (end != null) 'end': end,
    });
    return listOf(json['players'], PlayerReportRow.fromJson);
  }

  Future<Map<String, dynamic>> get(String path, {bool auth = true, Map<String, dynamic>? query}) {
    return _request('GET', path, auth: auth, query: query);
  }

  Future<Map<String, dynamic>> post(String path, {bool auth = true, Object? body}) {
    return _request('POST', path, auth: auth, body: body);
  }

  Future<Map<String, dynamic>> put(String path, {bool auth = true, Object? body}) {
    return _request('PUT', path, auth: auth, body: body);
  }

  Future<Map<String, dynamic>> patch(String path, {bool auth = true, Object? body}) {
    return _request('PATCH', path, auth: auth, body: body);
  }

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    required bool auth,
    Object? body,
    Map<String, dynamic>? query,
  }) async {
    var uri = Uri.parse(baseUrl).resolve(path);
    if (query != null && query.isNotEmpty) {
      final stringQuery = query.map((key, value) => MapEntry(key, value?.toString()));
      stringQuery.removeWhere((key, value) => value == null);
      uri = uri.replace(queryParameters: {
        ...uri.queryParameters,
        ...stringQuery,
      });
    }

    final headers = <String, String>{'Accept': 'application/json'};
    if (body != null) headers['Content-Type'] = 'application/json';
    if (auth && token != null) headers['Authorization'] = 'Bearer $token';

    final response = switch (method) {
      'GET' => await _http.get(uri, headers: headers),
      'POST' => await _http.post(uri, headers: headers, body: body == null ? null : jsonEncode(body)),
      'PUT' => await _http.put(uri, headers: headers, body: body == null ? null : jsonEncode(body)),
      'PATCH' => await _http.patch(uri, headers: headers, body: body == null ? null : jsonEncode(body)),
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
