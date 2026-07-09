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
  PrismApiClient({required this.baseUrl, this.token, http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  final String baseUrl;
  final String? token;
  final http.Client _http;

  PrismApiClient withAuth({String? baseUrl, String? token}) {
    return PrismApiClient(
      baseUrl: baseUrl ?? this.baseUrl,
      token: token ?? this.token,
      httpClient: _http,
    );
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
        'owner': {
          'username': username,
          'displayName': displayName,
          'password': password,
        },
        'coinCooldownMs': coinCooldownMs,
      },
    );
  }

  Future<(String token, CurrentStaff staff)> login({
    required String username,
    required String password,
  }) async {
    final json = await post(
      '/rpc/admin/login',
      auth: false,
      body: {'username': username, 'password': password},
    );
    return (
      ((json['session'] as Map?)?['token'] as String?) ?? '',
      CurrentStaff.fromJson(
        ((json['staff'] as Map?) ?? {}).cast<String, dynamic>(),
      ),
    );
  }

  Future<CurrentStaff> me() async {
    final json = await get('/rpc/staff/me');
    return CurrentStaff.fromJson(
      ((json['staff'] as Map?) ?? {}).cast<String, dynamic>(),
    );
  }

  Future<List<LivePlayer>> listLivePlayers() async {
    final json = await get('/rpc/staff/live-players');
    return listOf(json['players'], LivePlayer.fromJson);
  }

  Future<SettlementPreview> previewAllCheckout(String playerId) async {
    return _settlementPreviewFromResponse(
      await post('/rpc/staff/players/$playerId/checkout/preview'),
      playerId: playerId,
    );
  }

  Future<SettlementPreview> previewCheckout(String playerId) async {
    return _settlementPreviewFromResponse(
      await post('/rpc/staff/players/$playerId/checkout/preview'),
      playerId: playerId,
    );
  }

  Future<void> checkout(String playerId) async {
    await post('/rpc/staff/players/$playerId/checkout/confirm');
  }

  Future<void> checkoutWithOverride(
    String playerId, {
    required num total,
    required String reason,
  }) async {
    await post(
      '/rpc/staff/players/$playerId/checkout/override',
      body: {'total': total, 'reason': reason},
    );
  }

  Future<void> confirmAllCheckout(String playerId) async {
    await post('/rpc/staff/players/$playerId/checkout/confirm');
  }

  Future<void> bulkCheckoutActiveSessions() async {
    await post('/rpc/staff/sessions/active/checkout');
  }

  Future<void> stopPlayerSession({
    required String playerId,
    required String sessionId,
  }) async {
    await post('/rpc/staff/players/$playerId/sessions/$sessionId/stop');
  }

  Future<void> startPlayerSession(
    String playerId, {
    List<String>? pricingConfigIds,
    String? label,
  }) async {
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
    return listOf(json['staffUsers'] ?? json['users'], StaffUser.fromJson);
  }

  Future<StaffUser> createStaffUser({
    required String username,
    required String displayName,
    required String role,
    required String password,
  }) async {
    final json = await post(
      '/rpc/staff/users',
      body: {
        'username': username,
        'displayName': displayName,
        'role': role,
        'password': password,
      },
    );
    return StaffUser.fromJson(
      (json['staffUser'] as Map).cast<String, dynamic>(),
    );
  }

  Future<StaffUser> updateStaffUser(
    String staffUserId, {
    String? displayName,
    String? role,
    bool? isArchived,
  }) async {
    final json = await patch(
      '/rpc/staff/users/$staffUserId',
      body: {
        if (displayName != null) 'displayName': displayName,
        if (role != null) 'role': role,
        if (isArchived != null) 'status': isArchived ? 'disabled' : 'active',
      },
    );
    return StaffUser.fromJson(
      (json['staffUser'] as Map).cast<String, dynamic>(),
    );
  }

  Future<void> resetStaffUserPassword(
    String staffUserId, {
    required String password,
  }) async {
    await post(
      '/rpc/staff/users/$staffUserId/password',
      body: {'password': password},
    );
  }

  Future<SettingsData> getSettings() async {
    final json = await get('/rpc/staff/settings');
    return SettingsData.fromJson(
      (json['settings'] as Map).cast<String, dynamic>(),
    );
  }

  Future<Map<String, dynamic>> getRawSettings() async {
    final json = await get('/rpc/staff/settings');
    return (json['settings'] as Map).cast<String, dynamic>();
  }

  Future<Map<String, dynamic>> updateRawSettings(
    Map<String, dynamic> body,
  ) async {
    final json = await put('/rpc/staff/settings', body: body);
    return (json['settings'] as Map).cast<String, dynamic>();
  }

  Future<SettingsData> updateSettings({
    required String storeName,
    required String timeZone,
    required int coinCooldownMs,
  }) async {
    final json = await put(
      '/rpc/staff/settings',
      body: {
        'store': {'name': storeName, 'timeZone': timeZone},
        'operations': {'coinCooldownMs': coinCooldownMs},
      },
    );
    return SettingsData.fromJson(
      (json['settings'] as Map).cast<String, dynamic>(),
    );
  }

  Future<List<ApiToken>> listApiTokens() async {
    final json = await get('/rpc/staff/api-tokens');
    return listOf(json['apiTokens'] ?? json['tokens'], ApiToken.fromJson);
  }

  Future<ApiToken> createApiToken({
    required String label,
    String role = 'integration',
  }) async {
    final json = await post(
      '/rpc/staff/api-tokens',
      body: {'label': label, 'role': role},
    );
    return ApiToken.fromJson((json['apiToken'] as Map).cast<String, dynamic>());
  }

  Future<void> revokeApiToken(String tokenId) async {
    await post('/rpc/staff/api-tokens/$tokenId/revoke');
  }

  Future<List<Player>> listPlayers() async {
    final json = await get('/rpc/staff/players');
    return listOf(json['players'], Player.fromJson);
  }

  Future<Player> createPlayer({
    required String displayName,
    Map<String, num>? initialGrants,
  }) async {
    final json = await post(
      '/rpc/staff/players',
      body: {
        'displayName': displayName,
        if (initialGrants != null)
          'initialGrants': [
            for (final entry in initialGrants.entries)
              {
                'assetType': entry.key.contains(':')
                    ? entry.key.split(':').first
                    : 'currency',
                'assetCode': entry.key.contains(':')
                    ? entry.key.split(':').last
                    : entry.key,
                'amount': entry.value,
              },
          ],
      },
    );
    return Player.fromJson((json['player'] as Map).cast<String, dynamic>());
  }

  Future<void> updatePlayerStatus(
    String playerId, {
    required String status,
  }) async {
    await patch(
      '/rpc/staff/players/$playerId/status',
      body: {'status': status},
    );
  }

  Future<void> bindPlayerIdentity(
    String playerId, {
    required String provider,
    required String subject,
  }) async {
    await post(
      '/rpc/staff/players/$playerId/identities',
      body: {'provider': provider, 'subject': subject},
    );
  }

  Future<void> deletePlayerIdentity(
    String playerId, {
    required String provider,
    required String subject,
  }) async {
    await delete(
      '/rpc/staff/players/$playerId/identities/${Uri.encodeComponent(provider)}/${Uri.encodeComponent(subject)}',
    );
  }

  Future<void> grantAssets(
    String playerId, {
    required String assetType,
    required String assetCode,
    required num amount,
    required String reason,
  }) async {
    await post(
      '/rpc/staff/players/$playerId/assets/grants',
      body: {
        'grants': [
          {
            'assetType': assetType,
            'assetCode': assetCode,
            'amount': amount,
            'mergeStrategy': 'stack',
            'activeAt': null,
            'expiresAt': null,
          },
        ],
        'reason': reason,
      },
    );
  }

  Future<void> adjustAssets(
    String playerId, {
    required String assetType,
    required String assetCode,
    required num amount,
    required String reason,
  }) async {
    await post(
      '/rpc/staff/players/$playerId/assets/adjustments',
      body: {
        'adjustments': [
          {
            'assetType': assetType,
            'assetCode': assetCode,
            'quantityDelta': amount,
            'reason': reason,
          },
        ],
      },
    );
  }

  Future<PlayerAssets> getPlayerAssets(String playerId) async {
    final json = await get('/rpc/staff/players/$playerId/assets');
    return PlayerAssets.fromJson(json);
  }

  Future<List<LiveSession>> getPlayerSessionHistory(String playerId) async {
    final json = await get('/rpc/staff/players/$playerId/sessions/history');
    return listOf(json['sessions'], LiveSession.fromJson);
  }

  Future<List<PlayerRedeemRecord>> getPlayerRedeemRecords(
    String playerId,
  ) async {
    final json = await get('/rpc/staff/players/$playerId/redeem-records');
    return listOf(json['redeemRecords'], PlayerRedeemRecord.fromJson);
  }

  Future<List<LiveSession>> listActiveSessions() async {
    final json = await get('/rpc/staff/sessions/active');
    return listOf(json['sessions'], LiveSession.fromJson);
  }

  Future<Map<String, dynamic>> getPlayerSessionHistoryDetail(
    String playerId,
    String sessionId,
  ) async {
    return get('/rpc/staff/players/$playerId/sessions/$sessionId/history');
  }

  Future<RedeemCode> createRedeemCode({
    required String code,
    String? presentId,
    List<Map<String, dynamic>>? grants,
    int? usageLimit,
    int? maxUseCount,
    String? activeAt,
    String? expiresAt,
  }) async {
    final json = await post(
      '/rpc/staff/redeem-codes',
      body: {
        'code': code,
        'presentId': presentId ?? '',
        'activeAt': activeAt,
        'expiresAt': expiresAt,
        'maxUseCount': maxUseCount ?? usageLimit ?? 1,
      },
    );
    return RedeemCode.fromJson(
      (json['redeemCode'] as Map).cast<String, dynamic>(),
    );
  }

  Future<List<RedeemCode>> listRedeemCodes() async {
    final json = await get('/rpc/staff/redeem-codes');
    return listOf(json['redeemCodes'], RedeemCode.fromJson);
  }

  Future<List<RedeemCode>> createRedeemCodeBatch({
    required int count,
    required String presentId,
    String prefix = 'CDK',
    List<Map<String, dynamic>>? grants,
    int? usageLimit,
    int? maxUseCount,
    String? activeAt,
    String? expiresAt,
  }) async {
    final json = await post(
      '/rpc/staff/redeem-codes/batch',
      body: {
        'count': count,
        'prefix': prefix,
        'presentId': presentId,
        'activeAt': activeAt,
        'expiresAt': expiresAt,
        'maxUseCount': maxUseCount ?? usageLimit ?? 1,
      },
    );
    return listOf(json['redeemCodes'], RedeemCode.fromJson);
  }

  Future<void> revokeRedeemCode(String codeId) async {
    await post('/rpc/staff/redeem-codes/$codeId/revoke');
  }

  Future<Present> createPresent({
    required String name,
    required List<Map<String, dynamic>> grants,
    bool oncePerPlayer = false,
    String? activeAt,
    String? expiresAt,
  }) async {
    final json = await post(
      '/rpc/staff/presents',
      body: {
        'name': name,
        'grants': grants,
        'oncePerPlayer': oncePerPlayer,
        'activeAt': activeAt,
        'expiresAt': expiresAt,
      },
    );
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
    return listOf(
      json['assetDefinitions'] ?? json['definitions'],
      AssetDefinition.fromJson,
    );
  }

  Future<List<PricingEffect>> listPricingEffects() async {
    final json = await get('/rpc/staff/pricing-effects');
    return listOf(json['pricingEffects'], PricingEffect.fromJson);
  }

  Future<void> savePricingEffect(
    String effectId, {
    required String name,
    required String type,
    required String scope,
    num? value,
    bool consumable = false,
    int? limitPerDay,
    String? activeAt,
    String? expiresAt,
    Map<String, dynamic>? config,
  }) async {
    await put(
      '/rpc/staff/pricing-effects/$effectId',
      body: {
        'name': name,
        'type': type,
        'scope': scope,
        'value': value,
        'consumable': consumable,
        'limitPerDay': limitPerDay,
        'activeAt': activeAt,
        'expiresAt': expiresAt,
        'config': config,
      },
    );
  }

  Future<void> saveAssetDefinition(
    String assetType,
    String assetCode, {
    required String displayName,
    bool stackable = true,
    String? pricingEffectId,
    String? activeAt,
    String? expiresAt,
    Map<String, dynamic>? metadata,
  }) async {
    await put(
      '/rpc/staff/asset-definitions/$assetType/$assetCode',
      body: {
        'name': displayName,
        'stackable': stackable,
        'pricingEffectId': pricingEffectId,
        'activeAt': activeAt,
        'expiresAt': expiresAt,
        if (metadata != null) 'metadata': metadata,
      },
    );
  }

  Future<void> archiveAssetDefinition(
    String assetType,
    String assetCode,
  ) async {
    await post('/rpc/staff/asset-definitions/$assetType/$assetCode/archive');
  }

  Future<void> restoreAssetDefinition(
    String assetType,
    String assetCode,
  ) async {
    await post('/rpc/staff/asset-definitions/$assetType/$assetCode/restore');
  }

  Future<List<BusinessItem>> listBusinessItems() async {
    final json = await get('/rpc/staff/business-items');
    return listOf(
      json['businessItems'] ?? json['items'],
      BusinessItem.fromJson,
    );
  }

  Future<BusinessItem> createBusinessItem({
    required String name,
    required num price,
    required String kind,
    String? assetType,
    String? assetCode,
    DateTime? activeAt,
    DateTime? expiresAt,
    Map<String, dynamic>? metadata,
  }) async {
    final json = await post(
      '/rpc/staff/business-items',
      body: {
        'kind': kind,
        'name': name,
        'price': price,
        'assetType': assetType,
        'assetCode': assetCode,
        'activeAt': activeAt?.toUtc().toIso8601String(),
        'expiresAt': expiresAt?.toUtc().toIso8601String(),
        'metadata': metadata,
      },
    );
    final item = (json['businessItem'] ?? json['item']) as Map;
    return BusinessItem.fromJson(item.cast<String, dynamic>());
  }

  Future<void> archiveBusinessItem(String businessItemId) async {
    await post('/rpc/staff/business-items/$businessItemId/archive');
  }

  Future<void> restoreBusinessItem(String businessItemId) async {
    await post('/rpc/staff/business-items/$businessItemId/restore');
  }

  Future<List<BusinessItemOrder>> listBusinessItemOrders() async {
    final json = await get('/rpc/staff/business-item-orders');
    return listOf(
      json['businessItemOrders'] ?? json['orders'],
      BusinessItemOrder.fromJson,
    );
  }

  Future<void> fulfillBusinessItemOrder(String orderId) async {
    await post('/rpc/staff/business-item-orders/$orderId/fulfill');
  }

  Future<void> cancelBusinessItemOrder(String orderId) async {
    await post('/rpc/staff/business-item-orders/$orderId/cancel');
  }

  Future<List<PricingConfig>> listPricingConfigs() async {
    final json = await get('/rpc/staff/pricing-configs');
    return listOf(
      json['pricingConfigs'] ?? json['configs'],
      PricingConfig.fromJson,
    );
  }

  Future<PricingTimeline> getPricingTimeline(
    String pricingConfigId, {
    required String localDate,
  }) async {
    final json = await get(
      '/rpc/staff/pricing-configs/$pricingConfigId/timeline',
      query: {'date': localDate},
    );
    return PricingTimeline.fromJson(json);
  }

  Future<List<Map<String, dynamic>>> listPricingExtensions() async {
    final json = await get('/rpc/staff/pricing-extensions');
    return [
      for (final item in (json['pricingExtensions'] as List? ?? const []))
        if (item is Map) item.cast<String, dynamic>(),
    ];
  }

  Future<PricingTimeline> previewPricingTimeline({
    required String name,
    required String kind,
    required List<Map<String, dynamic>> rules,
    required String localDate,
    String? providerId,
    List<String> includedPricingConfigIds = const [],
  }) async {
    final json = await post(
      '/rpc/staff/pricing-timeline/preview',
      body: {
        'localDate': localDate,
        'provider': kind == 'time.cap'
            ? _timeCapProvider(
                rules: rules,
                providerId: providerId,
                includedPricingConfigIds: includedPricingConfigIds,
              )
            : _timePricingProvider(rules: rules, providerId: providerId),
      },
    );
    return PricingTimeline.fromJson(json);
  }

  Future<PricingConfig> createPricingConfig({
    required String name,
    required String kind,
    required List<Map<String, dynamic>> rules,
    bool enabled = true,
    String? providerId,
    List<String> includedPricingConfigIds = const [],
  }) async {
    final json = await post(
      '/rpc/staff/pricing-configs',
      body: {
        'name': name,
        'kind': kind,
        'enabled': enabled,
        'provider': kind == 'time.cap'
            ? _timeCapProvider(
                rules: rules,
                providerId: providerId,
                includedPricingConfigIds: includedPricingConfigIds,
              )
            : _timePricingProvider(rules: rules, providerId: providerId),
      },
    );
    final config = (json['pricingConfig'] ?? json['config']) as Map;
    return PricingConfig.fromJson(config.cast<String, dynamic>());
  }

  Future<PricingConfig> updatePricingConfig(
    String pricingConfigId, {
    required String name,
    required List<Map<String, dynamic>> rules,
    required bool isActive,
    String? providerId,
    String kind = 'time.priority',
    List<String> includedPricingConfigIds = const [],
  }) async {
    final json = await patch(
      '/rpc/staff/pricing-configs/$pricingConfigId',
      body: {
        'name': name,
        'enabled': isActive,
        'provider': kind == 'time.cap'
            ? _timeCapProvider(
                rules: rules,
                providerId: providerId,
                includedPricingConfigIds: includedPricingConfigIds,
              )
            : _timePricingProvider(rules: rules, providerId: providerId),
      },
    );
    final config = (json['pricingConfig'] ?? json['config']) as Map;
    return PricingConfig.fromJson(config.cast<String, dynamic>());
  }

  Future<PricingConfig> createFixedChargePricingConfig({
    required String name,
    required String label,
    required num amount,
    bool enabled = true,
    String? providerId,
  }) async {
    final json = await post(
      '/rpc/staff/pricing-configs',
      body: {
        'name': name,
        'kind': 'charge.fixed',
        'enabled': enabled,
        'provider': {
          'id': providerId ?? 'fixed.${DateTime.now().millisecondsSinceEpoch}',
          'label': label,
          'amount': amount,
        },
      },
    );
    final config = (json['pricingConfig'] ?? json['config']) as Map;
    return PricingConfig.fromJson(config.cast<String, dynamic>());
  }

  Future<PricingConfig> updateFixedChargePricingConfig(
    String pricingConfigId, {
    required String name,
    required String label,
    required num amount,
    required bool isActive,
    String? providerId,
  }) async {
    final json = await patch(
      '/rpc/staff/pricing-configs/$pricingConfigId',
      body: {
        'name': name,
        'enabled': isActive,
        'provider': {
          'id': providerId ?? 'fixed.$pricingConfigId',
          'label': label,
          'amount': amount,
        },
      },
    );
    final config = (json['pricingConfig'] ?? json['config']) as Map;
    return PricingConfig.fromJson(config.cast<String, dynamic>());
  }

  Future<void> archivePricingConfig(String pricingConfigId) async {
    await post('/rpc/staff/pricing-configs/$pricingConfigId/archive');
  }

  Future<void> restorePricingConfig(String pricingConfigId) async {
    await post('/rpc/staff/pricing-configs/$pricingConfigId/restore');
  }

  Future<List<DeviceState>> listDeviceStates() async {
    final json = await get('/rpc/staff/device-states');
    return listOf(
      json['deviceStates'] ?? json['devices'],
      DeviceState.fromJson,
    );
  }

  Future<List<MachineConnection>> listMachineConnections() async {
    final json = await get('/rpc/staff/machine-connections');
    return listOf(
      json['machineConnections'] ?? json['machines'],
      MachineConnection.fromJson,
    );
  }

  Future<List<DeviceCommand>> listDeviceCommands() async {
    final json = await get('/rpc/staff/device-commands');
    return listOf(json['commands'], DeviceCommand.fromJson);
  }

  Future<DeviceCommand> requestStaffDeviceAction({
    required String type,
    required String targetKind,
    required String deviceId,
    Map<String, dynamic>? payload,
  }) async {
    final json = await post(
      '/rpc/staff/device-actions',
      body: {
        'type': type,
        'target': {'kind': targetKind, 'id': deviceId},
        if (payload != null) 'payload': payload,
      },
    );
    final action = (json['action'] ?? json['command']) as Map;
    return DeviceCommand.fromJson(action.cast<String, dynamic>());
  }

  Future<ReportSummary> reportsSummary({String? start, String? end}) async {
    final json = await get(
      '/rpc/staff/reports/summary',
      query: {if (start != null) 'from': start, if (end != null) 'to': end},
    );
    final summary = json['summary'] ?? json;
    return ReportSummary.fromJson((summary as Map).cast<String, dynamic>());
  }

  Future<List<SettlementReportRow>> reportSettlements({
    String? start,
    String? end,
  }) async {
    final json = await get(
      '/rpc/staff/reports/settlements',
      query: {if (start != null) 'from': start, if (end != null) 'to': end},
    );
    return listOf(json['settlements'], SettlementReportRow.fromJson);
  }

  Future<List<PlayerReportRow>> reportPlayers({
    String? start,
    String? end,
  }) async {
    final json = await get(
      '/rpc/staff/reports/players',
      query: {if (start != null) 'from': start, if (end != null) 'to': end},
    );
    return listOf(json['players'], PlayerReportRow.fromJson);
  }

  Future<Map<String, dynamic>> get(
    String path, {
    bool auth = true,
    Map<String, dynamic>? query,
  }) {
    return _request('GET', path, auth: auth, query: query);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    bool auth = true,
    Object? body,
  }) {
    return _request('POST', path, auth: auth, body: body);
  }

  Future<Map<String, dynamic>> put(
    String path, {
    bool auth = true,
    Object? body,
  }) {
    return _request('PUT', path, auth: auth, body: body);
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    bool auth = true,
    Object? body,
  }) {
    return _request('PATCH', path, auth: auth, body: body);
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    bool auth = true,
    Object? body,
  }) {
    return _request('DELETE', path, auth: auth, body: body);
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
      final stringQuery = query.map(
        (key, value) => MapEntry(key, value?.toString()),
      );
      stringQuery.removeWhere((key, value) => value == null);
      uri = uri.replace(
        queryParameters: {...uri.queryParameters, ...stringQuery},
      );
    }

    final headers = <String, String>{'Accept': 'application/json'};
    if (body != null) headers['Content-Type'] = 'application/json';
    if (auth && token != null) headers['Authorization'] = 'Bearer $token';

    final response = switch (method) {
      'GET' => await _http.get(uri, headers: headers),
      'POST' => await _http.post(
        uri,
        headers: headers,
        body: body == null ? null : jsonEncode(body),
      ),
      'PUT' => await _http.put(
        uri,
        headers: headers,
        body: body == null ? null : jsonEncode(body),
      ),
      'PATCH' => await _http.patch(
        uri,
        headers: headers,
        body: body == null ? null : jsonEncode(body),
      ),
      'DELETE' => await _http.delete(
        uri,
        headers: headers,
        body: body == null ? null : jsonEncode(body),
      ),
      _ => throw ArgumentError.value(method, 'method'),
    };

    Object? decoded;
    try {
      decoded = response.body.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(response.body);
    } on FormatException {
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw PrismApiException(
          '服务器返回了无法读取的错误内容。',
          'HTTP_${response.statusCode}',
          response.statusCode,
        );
      }
      throw PrismApiException(
        '服务器返回内容格式不正确。',
        'INVALID_JSON',
        response.statusCode,
      );
    }
    final json = decoded is Map
        ? decoded.cast<String, dynamic>()
        : <String, dynamic>{};

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final error =
          (json['error'] as Map?)?.cast<String, dynamic>() ?? const {};
      throw PrismApiException(
        error['message'] as String? ?? '请求没有成功，请稍后再试。',
        error['code'] as String? ?? 'HTTP_${response.statusCode}',
        response.statusCode,
      );
    }
    return json;
  }

  Map<String, dynamic> _timePricingProvider({
    required List<Map<String, dynamic>> rules,
    String? providerId,
  }) {
    return {
      'id': providerId ?? 'time.default',
      'rules': rules.map(_pricingRuleBody).toList(),
    };
  }

  Map<String, dynamic> _timeCapProvider({
    required List<Map<String, dynamic>> rules,
    String? providerId,
    List<String> includedPricingConfigIds = const [],
  }) {
    return {
      'id': providerId ?? 'cap.default',
      'includedPricingConfigIds': includedPricingConfigIds,
      'rules': rules.map(_capRuleBody).toList(),
    };
  }

  SettlementPreview _settlementPreviewFromResponse(
    Map<String, dynamic> json, {
    required String playerId,
  }) {
    final preview = ((json['settlementPreview'] as Map?) ?? json)
        .cast<String, dynamic>();
    final rawSessionPreviews =
        (json['sessionPreviews'] as List?) ?? const <dynamic>[];
    final sessionPreviews = rawSessionPreviews
        .whereType<Map>()
        .map((item) => item.cast<String, dynamic>())
        .toList();
    final sessionIds = (preview['sessionIds'] as List?)
        ?.whereType<String>()
        .toList();
    final singleSessionId = preview['sessionId'];
    return SettlementPreview.fromJson({
      ...preview,
      'playerId': preview['playerId'] ?? playerId,
      'sessionIds':
          sessionIds ??
          [
            if (singleSessionId is String && singleSessionId.isNotEmpty)
              singleSessionId,
          ],
      'sessionPreviews': sessionPreviews,
    });
  }

  Map<String, dynamic> _pricingRuleBody(Map<String, dynamic> rule) {
    if ((rule.containsKey('timeRange') || rule.containsKey('dateTimeRange')) &&
        rule.containsKey('pricing')) {
      return rule;
    }
    final pricing = (rule['pricing'] as Map?)?.cast<String, dynamic>();
    return {
      'id': rule['id'] ?? rule['label'] ?? 'rule',
      'label': rule['label'] ?? '计费规则',
      'priority': rule['priority'] ?? 0,
      'status': rule['status'] ?? 'active',
      if (rule['dateTimeRange'] != null) 'dateTimeRange': rule['dateTimeRange'],
      if (rule['dateTimeRange'] == null || rule['timeRange'] != null)
        'timeRange': {
          'start': rule['startTime'] ?? '00:00',
          'end': rule['endTime'] ?? '00:00',
        },
      if (rule['weekdays'] != null) 'weekdays': rule['weekdays'],
      if (rule['specificDates'] != null) 'specificDates': rule['specificDates'],
      if (rule['specificDate'] != null) 'specificDates': [rule['specificDate']],
      'pricing': {
        'unitMinutes': rule['unitMinutes'] ?? pricing?['unitMinutes'] ?? 30,
        'unitPrice': rule['unitPrice'] ?? pricing?['unitPrice'] ?? 0,
        'roundGraceMinutes':
            rule['graceMinutes'] ?? pricing?['roundGraceMinutes'] ?? 0,
        if (rule['priceCap'] != null || pricing?['priceCap'] != null)
          'priceCap': rule['priceCap'] ?? pricing?['priceCap'],
      },
    };
  }

  Map<String, dynamic> _capRuleBody(Map<String, dynamic> rule) {
    if ((rule.containsKey('timeRange') || rule.containsKey('dateTimeRange')) &&
        rule.containsKey('priceCap') &&
        !rule.containsKey('pricing')) {
      return rule;
    }
    final pricing = (rule['pricing'] as Map?)?.cast<String, dynamic>();
    return {
      'id': rule['id'] ?? rule['label'] ?? 'rule',
      'label': rule['label'] ?? '封顶规则',
      'priority': rule['priority'] ?? 0,
      'status': rule['status'] ?? 'active',
      if (rule['dateTimeRange'] != null) 'dateTimeRange': rule['dateTimeRange'],
      if (rule['dateTimeRange'] == null || rule['timeRange'] != null)
        'timeRange': {
          'start': rule['startTime'] ?? '00:00',
          'end': rule['endTime'] ?? '00:00',
        },
      if (rule['weekdays'] != null) 'weekdays': rule['weekdays'],
      if (rule['specificDates'] != null) 'specificDates': rule['specificDates'],
      if (rule['specificDate'] != null) 'specificDates': [rule['specificDate']],
      'priceCap': rule['priceCap'] ?? pricing?['priceCap'] ?? 0,
    };
  }
}
