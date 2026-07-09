// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentStaff _$CurrentStaffFromJson(Map<String, dynamic> json) =>
    _CurrentStaff(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      role: $enumDecode(
        _$StaffRoleEnumMap,
        json['role'],
        unknownValue: StaffRole.viewer,
      ),
      canWrite: readCanWrite(json, 'canWrite') as bool? ?? false,
    );

Map<String, dynamic> _$CurrentStaffToJson(_CurrentStaff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'role': _$StaffRoleEnumMap[instance.role]!,
      'canWrite': instance.canWrite,
    };

const _$StaffRoleEnumMap = {
  StaffRole.owner: 'owner',
  StaffRole.manager: 'manager',
  StaffRole.viewer: 'viewer',
};

_SetupStatus _$SetupStatusFromJson(Map<String, dynamic> json) =>
    _SetupStatus(installed: json['installed'] as bool);

Map<String, dynamic> _$SetupStatusToJson(_SetupStatus instance) =>
    <String, dynamic>{'installed': instance.installed};

_LivePlayer _$LivePlayerFromJson(Map<String, dynamic> json) => _LivePlayer(
  playerId: json['playerId'] as String,
  displayName: json['displayName'] as String,
  status: json['status'] as String,
  walletTotal: json['walletTotal'] as num,
  stayDurationMinutes: (json['stayDurationMinutes'] as num).toInt(),
  estimatedTotal: json['estimatedTotal'] as num?,
  sessions: (json['sessions'] as List<dynamic>)
      .map((e) => LiveSession.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LivePlayerToJson(_LivePlayer instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'displayName': instance.displayName,
      'status': instance.status,
      'walletTotal': instance.walletTotal,
      'stayDurationMinutes': instance.stayDurationMinutes,
      'estimatedTotal': instance.estimatedTotal,
      'sessions': instance.sessions,
    };

_LiveSession _$LiveSessionFromJson(Map<String, dynamic> json) => _LiveSession(
  id: readSessionId(json, 'id') as String,
  label: json['label'] as String?,
  startedAt: DateTime.parse(json['startedAt'] as String),
  endedAt: json['endedAt'] == null
      ? null
      : DateTime.parse(json['endedAt'] as String),
  elapsedMinutes:
      (readElapsedMinutes(json, 'elapsedMinutes') as num?)?.toInt() ?? 0,
  currentImpact: readCurrentImpact(json, 'currentImpact') as num?,
  pricingCharges:
      (json['pricingCharges'] as List<dynamic>?)
          ?.map((e) => LivePricingCharge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  status: json['status'] as String? ?? 'closed',
);

Map<String, dynamic> _$LiveSessionToJson(_LiveSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'elapsedMinutes': instance.elapsedMinutes,
      'currentImpact': instance.currentImpact,
      'pricingCharges': instance.pricingCharges,
      'status': instance.status,
    };

_LivePricingCharge _$LivePricingChargeFromJson(Map<String, dynamic> json) =>
    _LivePricingCharge(
      pricingConfigId: json['pricingConfigId'] as String,
      planName: json['planName'] as String,
      ruleLabel: json['ruleLabel'] as String?,
      amount: json['amount'] as num,
    );

Map<String, dynamic> _$LivePricingChargeToJson(_LivePricingCharge instance) =>
    <String, dynamic>{
      'pricingConfigId': instance.pricingConfigId,
      'planName': instance.planName,
      'ruleLabel': instance.ruleLabel,
      'amount': instance.amount,
    };

_SettlementPreview _$SettlementPreviewFromJson(Map<String, dynamic> json) =>
    _SettlementPreview(
      playerId: json['playerId'] as String,
      sessionIds: (json['sessionIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      subtotal: json['subtotal'] as num,
      total: json['total'] as num,
      status: json['status'] as String,
      previewedAt: json['previewedAt'] == null
          ? null
          : DateTime.parse(json['previewedAt'] as String),
      sessionPreviews: (json['sessionPreviews'] as List<dynamic>)
          .map((e) => SessionPreview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SettlementPreviewToJson(_SettlementPreview instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'sessionIds': instance.sessionIds,
      'subtotal': instance.subtotal,
      'total': instance.total,
      'status': instance.status,
      'previewedAt': instance.previewedAt?.toIso8601String(),
      'sessionPreviews': instance.sessionPreviews,
    };

_SessionPreview _$SessionPreviewFromJson(Map<String, dynamic> json) =>
    _SessionPreview(
      sessionId: json['sessionId'] as String,
      subtotal: json['subtotal'] as num,
      total: json['total'] as num,
    );

Map<String, dynamic> _$SessionPreviewToJson(_SessionPreview instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'subtotal': instance.subtotal,
      'total': instance.total,
    };

_PlayerIdentity _$PlayerIdentityFromJson(Map<String, dynamic> json) =>
    _PlayerIdentity(
      provider: json['provider'] as String,
      subject: json['subject'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PlayerIdentityToJson(_PlayerIdentity instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'subject': instance.subject,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_Player _$PlayerFromJson(Map<String, dynamic> json) => _Player(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  status: json['status'] as String,
  walletTotal: json['walletTotal'] as num? ?? 0,
  activeSessionId: json['activeSessionId'] as String?,
  stayDurationMinutes: (json['stayDurationMinutes'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  identities:
      (json['identities'] as List<dynamic>?)
          ?.map((e) => PlayerIdentity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$PlayerToJson(_Player instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'status': instance.status,
  'walletTotal': instance.walletTotal,
  'activeSessionId': instance.activeSessionId,
  'stayDurationMinutes': instance.stayDurationMinutes,
  'createdAt': instance.createdAt?.toIso8601String(),
  'identities': instance.identities,
};

_PricingEffect _$PricingEffectFromJson(Map<String, dynamic> json) =>
    _PricingEffect(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      scope: json['scope'] as String,
      value: json['value'] as num?,
      consumable: json['consumable'] as bool? ?? false,
      limitPerDay: (json['limitPerDay'] as num?)?.toInt(),
      activeAt: json['activeAt'] == null
          ? null
          : DateTime.parse(json['activeAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      config: readMap(json, 'config') as Map<String, dynamic>?,
      isArchived: readIsArchived(json, 'isArchived') as bool? ?? false,
    );

Map<String, dynamic> _$PricingEffectToJson(_PricingEffect instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'scope': instance.scope,
      'value': instance.value,
      'consumable': instance.consumable,
      'limitPerDay': instance.limitPerDay,
      'activeAt': instance.activeAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'config': instance.config,
      'isArchived': instance.isArchived,
    };

_AssetDefinition _$AssetDefinitionFromJson(Map<String, dynamic> json) =>
    _AssetDefinition(
      type: json['type'] as String,
      code: json['code'] as String,
      displayName: readDisplayName(json, 'displayName') as String,
      stackable: json['stackable'] as bool? ?? true,
      isArchived: readIsArchived(json, 'isArchived') as bool? ?? false,
      pricingEffectId: json['pricingEffectId'] as String?,
      pricingEffect: json['pricingEffect'] == null
          ? null
          : PricingEffect.fromJson(
              json['pricingEffect'] as Map<String, dynamic>,
            ),
      activeAt: json['activeAt'] == null
          ? null
          : DateTime.parse(json['activeAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$AssetDefinitionToJson(_AssetDefinition instance) =>
    <String, dynamic>{
      'type': instance.type,
      'code': instance.code,
      'displayName': instance.displayName,
      'stackable': instance.stackable,
      'isArchived': instance.isArchived,
      'pricingEffectId': instance.pricingEffectId,
      'pricingEffect': instance.pricingEffect,
      'activeAt': instance.activeAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

_AssetHolding _$AssetHoldingFromJson(Map<String, dynamic> json) =>
    _AssetHolding(
      assetType: json['assetType'] as String,
      assetCode: json['assetCode'] as String,
      assetName: json['assetName'] as String?,
      amount: readAmount(json, 'amount') as num,
      activeAt: json['activeAt'] == null
          ? null
          : DateTime.parse(json['activeAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$AssetHoldingToJson(_AssetHolding instance) =>
    <String, dynamic>{
      'assetType': instance.assetType,
      'assetCode': instance.assetCode,
      'assetName': instance.assetName,
      'amount': instance.amount,
      'activeAt': instance.activeAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

_AssetLedgerEntry _$AssetLedgerEntryFromJson(Map<String, dynamic> json) =>
    _AssetLedgerEntry(
      id: json['id'] as String? ?? '',
      assetType: json['assetType'] as String,
      assetCode: json['assetCode'] as String,
      assetName: json['assetName'] as String?,
      amount: readAmount(json, 'amount') as num,
      direction: readDirection(json, 'direction') as String,
      reason: json['reason'] as String,
      refId: json['refId'] as String?,
      transactionId: json['transactionId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AssetLedgerEntryToJson(_AssetLedgerEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assetType': instance.assetType,
      'assetCode': instance.assetCode,
      'assetName': instance.assetName,
      'amount': instance.amount,
      'direction': instance.direction,
      'reason': instance.reason,
      'refId': instance.refId,
      'transactionId': instance.transactionId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_PlayerAssets _$PlayerAssetsFromJson(Map<String, dynamic> json) =>
    _PlayerAssets(
      playerId: json['playerId'] as String? ?? '',
      holdings: (json['holdings'] as List<dynamic>)
          .map((e) => AssetHolding.fromJson(e as Map<String, dynamic>))
          .toList(),
      ledger: (readLedger(json, 'ledger') as List<dynamic>)
          .map((e) => AssetLedgerEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerAssetsToJson(_PlayerAssets instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'holdings': instance.holdings,
      'ledger': instance.ledger,
    };

_AssetGrant _$AssetGrantFromJson(Map<String, dynamic> json) => _AssetGrant(
  assetType: json['assetType'] as String,
  assetCode: json['assetCode'] as String,
  amount: json['amount'] as num,
  mergeStrategy: json['mergeStrategy'] as String? ?? 'stack',
  activeAt: json['activeAt'] == null
      ? null
      : DateTime.parse(json['activeAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  durationMs: (json['durationMs'] as num?)?.toInt(),
);

Map<String, dynamic> _$AssetGrantToJson(_AssetGrant instance) =>
    <String, dynamic>{
      'assetType': instance.assetType,
      'assetCode': instance.assetCode,
      'amount': instance.amount,
      'mergeStrategy': instance.mergeStrategy,
      'activeAt': instance.activeAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'durationMs': instance.durationMs,
    };

_Present _$PresentFromJson(Map<String, dynamic> json) => _Present(
  id: json['id'] as String,
  name: json['name'] as String,
  grants: (json['grants'] as List<dynamic>)
      .map((e) => AssetGrant.fromJson(e as Map<String, dynamic>))
      .toList(),
  oncePerPlayer: json['oncePerPlayer'] as bool? ?? false,
  activeAt: json['activeAt'] == null
      ? null
      : DateTime.parse(json['activeAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  isArchived: readIsArchived(json, 'isArchived') as bool? ?? false,
);

Map<String, dynamic> _$PresentToJson(_Present instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'grants': instance.grants,
  'oncePerPlayer': instance.oncePerPlayer,
  'activeAt': instance.activeAt?.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'isArchived': instance.isArchived,
};

_RedeemCode _$RedeemCodeFromJson(Map<String, dynamic> json) => _RedeemCode(
  id: json['id'] as String,
  code: json['code'] as String,
  presentId: json['presentId'] as String?,
  activeAt: json['activeAt'] == null
      ? null
      : DateTime.parse(json['activeAt'] as String),
  grants:
      (json['grants'] as List<dynamic>?)
          ?.map((e) => AssetGrant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  usageLimit: (readUsageLimit(json, 'usageLimit') as num?)?.toInt() ?? 1,
  usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
  redemptions:
      (json['redemptions'] as List<dynamic>?)
          ?.map((e) => RedeemCodeRedemption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  isRevoked: json['isRevoked'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$RedeemCodeToJson(_RedeemCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'presentId': instance.presentId,
      'activeAt': instance.activeAt?.toIso8601String(),
      'grants': instance.grants,
      'usageLimit': instance.usageLimit,
      'usageCount': instance.usageCount,
      'redemptions': instance.redemptions,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'isRevoked': instance.isRevoked,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_RedeemCodeRedemption _$RedeemCodeRedemptionFromJson(
  Map<String, dynamic> json,
) => _RedeemCodeRedemption(
  playerId: json['playerId'] as String,
  playerDisplayName: json['playerDisplayName'] as String,
  redeemedAt: DateTime.parse(json['redeemedAt'] as String),
);

Map<String, dynamic> _$RedeemCodeRedemptionToJson(
  _RedeemCodeRedemption instance,
) => <String, dynamic>{
  'playerId': instance.playerId,
  'playerDisplayName': instance.playerDisplayName,
  'redeemedAt': instance.redeemedAt.toIso8601String(),
};

_PlayerRedeemRecord _$PlayerRedeemRecordFromJson(Map<String, dynamic> json) =>
    _PlayerRedeemRecord(
      codeId: json['codeId'] as String,
      code: json['code'] as String,
      presentId: json['presentId'] as String,
      presentName: json['presentName'] as String,
      redeemedAt: DateTime.parse(json['redeemedAt'] as String),
    );

Map<String, dynamic> _$PlayerRedeemRecordToJson(_PlayerRedeemRecord instance) =>
    <String, dynamic>{
      'codeId': instance.codeId,
      'code': instance.code,
      'presentId': instance.presentId,
      'presentName': instance.presentName,
      'redeemedAt': instance.redeemedAt.toIso8601String(),
    };

_PriorityTimeRule _$PriorityTimeRuleFromJson(Map<String, dynamic> json) =>
    _PriorityTimeRule(
      id: json['id'] as String? ?? '',
      label: json['label'] as String,
      priority: (json['priority'] as num).toInt(),
      status: json['status'] as String? ?? 'active',
      hasTimeRange: readHasTimeRange(json, 'hasTimeRange') as bool? ?? false,
      startTime: readStartTime(json, 'startTime') as String,
      endTime: readEndTime(json, 'endTime') as String,
      weekdays:
          (json['weekdays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      specificDates:
          (readSpecificDates(json, 'specificDates') as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      specificDate: json['specificDate'] as String?,
      startDateTime: readStartDateTime(json, 'startDateTime') as String?,
      endDateTime: readEndDateTime(json, 'endDateTime') as String?,
      unitMinutes: (readUnitMinutes(json, 'unitMinutes') as num?)?.toInt() ?? 0,
      unitPrice: readUnitPrice(json, 'unitPrice') as num? ?? 0,
      graceMinutes:
          (readGraceMinutes(json, 'graceMinutes') as num?)?.toInt() ?? 0,
      priceCap: readPriceCap(json, 'priceCap') as num?,
    );

Map<String, dynamic> _$PriorityTimeRuleToJson(_PriorityTimeRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'priority': instance.priority,
      'status': instance.status,
      'hasTimeRange': instance.hasTimeRange,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'weekdays': instance.weekdays,
      'specificDates': instance.specificDates,
      'specificDate': instance.specificDate,
      'startDateTime': instance.startDateTime,
      'endDateTime': instance.endDateTime,
      'unitMinutes': instance.unitMinutes,
      'unitPrice': instance.unitPrice,
      'graceMinutes': instance.graceMinutes,
      'priceCap': instance.priceCap,
    };

_PricingConfig _$PricingConfigFromJson(
  Map<String, dynamic> json,
) => _PricingConfig(
  id: json['id'] as String,
  name: json['name'] as String,
  kind: json['kind'] as String,
  rules: (readPricingRules(json, 'rules') as List<dynamic>)
      .map((e) => PriorityTimeRule.fromJson(e as Map<String, dynamic>))
      .toList(),
  providerId: readProviderId(json, 'providerId') as String?,
  fixedChargeLabel: readFixedChargeLabel(json, 'fixedChargeLabel') as String?,
  fixedChargeAmount: readFixedChargeAmount(json, 'fixedChargeAmount') as num?,
  includedPricingConfigIds:
      (readIncludedPricingConfigIds(json, 'includedPricingConfigIds')
              as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isArchived: readIsArchived(json, 'isArchived') as bool? ?? false,
  isActive: readIsActive(json, 'isActive') as bool? ?? true,
);

Map<String, dynamic> _$PricingConfigToJson(_PricingConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': instance.kind,
      'rules': instance.rules,
      'providerId': instance.providerId,
      'fixedChargeLabel': instance.fixedChargeLabel,
      'fixedChargeAmount': instance.fixedChargeAmount,
      'includedPricingConfigIds': instance.includedPricingConfigIds,
      'isArchived': instance.isArchived,
      'isActive': instance.isActive,
    };

_UnitPricing _$UnitPricingFromJson(Map<String, dynamic> json) => _UnitPricing(
  ruleId: json['ruleId'] as String? ?? '',
  startMinute: (json['startMinute'] as num?)?.toInt() ?? 0,
  endMinute: (json['endMinute'] as num?)?.toInt() ?? 0,
  startTime: readStartTime(json, 'startTime') as String,
  endTime: readEndTime(json, 'endTime') as String,
  price: readTimelinePrice(json, 'price') as num,
  isClosed: json['isClosed'] as bool? ?? false,
  label: json['label'] as String?,
);

Map<String, dynamic> _$UnitPricingToJson(_UnitPricing instance) =>
    <String, dynamic>{
      'ruleId': instance.ruleId,
      'startMinute': instance.startMinute,
      'endMinute': instance.endMinute,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'price': instance.price,
      'isClosed': instance.isClosed,
      'label': instance.label,
    };

_PricingTimeline _$PricingTimelineFromJson(Map<String, dynamic> json) =>
    _PricingTimeline(
      timeline:
          (readTimelineSegments(json, 'timeline') as List<dynamic>?)
              ?.map((e) => UnitPricing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pricingConfigId:
          readPricingConfigId(json, 'pricingConfigId') as String? ?? '',
    );

Map<String, dynamic> _$PricingTimelineToJson(_PricingTimeline instance) =>
    <String, dynamic>{
      'timeline': instance.timeline,
      'pricingConfigId': instance.pricingConfigId,
    };

_BusinessItem _$BusinessItemFromJson(Map<String, dynamic> json) =>
    _BusinessItem(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as num,
      kind: json['kind'] as String,
      status: json['status'] as String? ?? 'active',
      assetType: json['assetType'] as String?,
      assetCode: json['assetCode'] as String?,
      activeAt: json['activeAt'] == null
          ? null
          : DateTime.parse(json['activeAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isArchived: readIsArchived(json, 'isArchived') as bool? ?? false,
    );

Map<String, dynamic> _$BusinessItemToJson(_BusinessItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'kind': instance.kind,
      'status': instance.status,
      'assetType': instance.assetType,
      'assetCode': instance.assetCode,
      'activeAt': instance.activeAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isArchived': instance.isArchived,
    };

_BusinessItemOrder _$BusinessItemOrderFromJson(Map<String, dynamic> json) =>
    _BusinessItemOrder(
      id: json['id'] as String,
      playerId: json['playerId'] as String,
      itemId: readItemId(json, 'itemId') as String,
      itemName: readItemName(json, 'itemName') as String,
      businessItemKind: json['businessItemKind'] as String? ?? '',
      price: json['price'] as num,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      sessionId: json['sessionId'] as String?,
      assetType: json['assetType'] as String?,
      assetCode: json['assetCode'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      fulfilledAt: json['fulfilledAt'] == null
          ? null
          : DateTime.parse(json['fulfilledAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
    );

Map<String, dynamic> _$BusinessItemOrderToJson(_BusinessItemOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'businessItemKind': instance.businessItemKind,
      'price': instance.price,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'sessionId': instance.sessionId,
      'assetType': instance.assetType,
      'assetCode': instance.assetCode,
      'metadata': instance.metadata,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'fulfilledAt': instance.fulfilledAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
    };

_DeviceState _$DeviceStateFromJson(Map<String, dynamic> json) => _DeviceState(
  deviceId: json['deviceId'] as String,
  label: json['label'] as String,
  type: json['type'] as String,
  targetKind: readTargetKind(json, 'targetKind') as String? ?? 'facility',
  executorKind: json['executorKind'] as String?,
  status: json['status'] as String,
  state: json['state'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  reportedAt: DateTime.parse(json['reportedAt'] as String),
  reportedBy: json['reportedBy'] as String,
);

Map<String, dynamic> _$DeviceStateToJson(_DeviceState instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'label': instance.label,
      'type': instance.type,
      'targetKind': instance.targetKind,
      'executorKind': instance.executorKind,
      'status': instance.status,
      'state': instance.state,
      'metadata': instance.metadata,
      'reportedAt': instance.reportedAt.toIso8601String(),
      'reportedBy': instance.reportedBy,
    };

_MachineConnection _$MachineConnectionFromJson(Map<String, dynamic> json) =>
    _MachineConnection(
      machineId: json['machineId'] as String,
      status: json['status'] as String,
      capabilities:
          (json['capabilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      connectedAt: DateTime.parse(json['connectedAt'] as String),
      lastSeenAt: DateTime.parse(json['lastSeenAt'] as String),
      disconnectedAt: json['disconnectedAt'] == null
          ? null
          : DateTime.parse(json['disconnectedAt'] as String),
    );

Map<String, dynamic> _$MachineConnectionToJson(_MachineConnection instance) =>
    <String, dynamic>{
      'machineId': instance.machineId,
      'status': instance.status,
      'capabilities': instance.capabilities,
      'connectedAt': instance.connectedAt.toIso8601String(),
      'lastSeenAt': instance.lastSeenAt.toIso8601String(),
      'disconnectedAt': instance.disconnectedAt?.toIso8601String(),
    };

_DeviceCommand _$DeviceCommandFromJson(Map<String, dynamic> json) =>
    _DeviceCommand(
      id: json['id'] as String,
      commandType: readCommandType(json, 'commandType') as String,
      deviceId: json['deviceId'] as String,
      targetKind: readTargetKind(json, 'targetKind') as String? ?? 'facility',
      executorKind: json['executorKind'] as String?,
      requester: readRequester(json, 'requester') as String,
      playerId: json['playerId'] as String?,
      staffId: json['staffId'] as String?,
      status: json['status'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(readCreatedAt(json, 'createdAt') as String),
      ackedAt: json['ackedAt'] == null
          ? null
          : DateTime.parse(json['ackedAt'] as String),
      expiredAt: json['expiredAt'] == null
          ? null
          : DateTime.parse(json['expiredAt'] as String),
    );

Map<String, dynamic> _$DeviceCommandToJson(_DeviceCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'commandType': instance.commandType,
      'deviceId': instance.deviceId,
      'targetKind': instance.targetKind,
      'executorKind': instance.executorKind,
      'requester': instance.requester,
      'playerId': instance.playerId,
      'staffId': instance.staffId,
      'status': instance.status,
      'payload': instance.payload,
      'createdAt': instance.createdAt.toIso8601String(),
      'ackedAt': instance.ackedAt?.toIso8601String(),
      'expiredAt': instance.expiredAt?.toIso8601String(),
    };

_ReportSummary _$ReportSummaryFromJson(Map<String, dynamic> json) =>
    _ReportSummary(
      revenue: readRevenue(json, 'revenue') as num,
      settledSessionsCount:
          (readSettledSessionsCount(json, 'settledSessionsCount') as num)
              .toInt(),
      assetGrantsCount: (readAssetGrantsCount(json, 'assetGrantsCount') as num)
          .toInt(),
      coinCommandsCount:
          (readCoinCommandsCount(json, 'coinCommandsCount') as num).toInt(),
    );

Map<String, dynamic> _$ReportSummaryToJson(_ReportSummary instance) =>
    <String, dynamic>{
      'revenue': instance.revenue,
      'settledSessionsCount': instance.settledSessionsCount,
      'assetGrantsCount': instance.assetGrantsCount,
      'coinCommandsCount': instance.coinCommandsCount,
    };

_SettlementReportRow _$SettlementReportRowFromJson(Map<String, dynamic> json) =>
    _SettlementReportRow(
      playerId: json['playerId'] as String,
      displayName: readDisplayName(json, 'displayName') as String,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      subtotal: json['subtotal'] as num,
      total: json['total'] as num,
      settledAt: DateTime.parse(json['settledAt'] as String),
    );

Map<String, dynamic> _$SettlementReportRowToJson(
  _SettlementReportRow instance,
) => <String, dynamic>{
  'playerId': instance.playerId,
  'displayName': instance.displayName,
  'durationMinutes': instance.durationMinutes,
  'subtotal': instance.subtotal,
  'total': instance.total,
  'settledAt': instance.settledAt.toIso8601String(),
};

_PlayerReportRow _$PlayerReportRowFromJson(Map<String, dynamic> json) =>
    _PlayerReportRow(
      playerId: json['playerId'] as String,
      displayName: readDisplayName(json, 'displayName') as String,
      settlementCount: (json['settlementCount'] as num).toInt(),
      totalDurationMinutes: (json['totalDurationMinutes'] as num).toInt(),
      revenue: readRevenue(json, 'revenue') as num,
      lastSettledAt: DateTime.parse(json['lastSettledAt'] as String),
    );

Map<String, dynamic> _$PlayerReportRowToJson(_PlayerReportRow instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'displayName': instance.displayName,
      'settlementCount': instance.settlementCount,
      'totalDurationMinutes': instance.totalDurationMinutes,
      'revenue': instance.revenue,
      'lastSettledAt': instance.lastSettledAt.toIso8601String(),
    };

_SettingsData _$SettingsDataFromJson(Map<String, dynamic> json) =>
    _SettingsData(
      storeName: readStoreName(json, 'storeName') as String,
      timeZone: readTimeZone(json, 'timeZone') as String,
      coinCooldownMs: (readCoinCooldownMs(json, 'coinCooldownMs') as num)
          .toInt(),
    );

Map<String, dynamic> _$SettingsDataToJson(_SettingsData instance) =>
    <String, dynamic>{
      'storeName': instance.storeName,
      'timeZone': instance.timeZone,
      'coinCooldownMs': instance.coinCooldownMs,
    };

_StaffUser _$StaffUserFromJson(Map<String, dynamic> json) => _StaffUser(
  id: json['id'] as String,
  username: json['username'] as String,
  displayName: json['displayName'] as String,
  role: $enumDecode(
    _$StaffRoleEnumMap,
    json['role'],
    unknownValue: StaffRole.viewer,
  ),
  isArchived: readIsArchived(json, 'isArchived') as bool? ?? false,
);

Map<String, dynamic> _$StaffUserToJson(_StaffUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'displayName': instance.displayName,
      'role': _$StaffRoleEnumMap[instance.role]!,
      'isArchived': instance.isArchived,
    };

_ApiToken _$ApiTokenFromJson(Map<String, dynamic> json) => _ApiToken(
  id: json['id'] as String,
  label: json['label'] as String,
  token: json['token'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  role: json['role'] as String? ?? 'integration',
  tokenPrefix: json['tokenPrefix'] as String? ?? '',
  isRevoked: readIsRevoked(json, 'isRevoked') as bool? ?? false,
);

Map<String, dynamic> _$ApiTokenToJson(_ApiToken instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'createdAt': instance.createdAt.toIso8601String(),
  'role': instance.role,
  'tokenPrefix': instance.tokenPrefix,
  'isRevoked': instance.isRevoked,
};
