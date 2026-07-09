import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

enum StaffRole { owner, manager, viewer }

StaffRole staffRoleFromJson(String value) {
  return StaffRole.values.firstWhere(
    (role) => role.name == value,
    orElse: () => StaffRole.viewer,
  );
}

@freezed
abstract class CurrentStaff with _$CurrentStaff {
  const factory CurrentStaff({
    required String id,
    required String displayName,
    @JsonKey(unknownEnumValue: StaffRole.viewer) required StaffRole role,
    @JsonKey(readValue: readCanWrite) @Default(false) bool canWrite,
  }) = _CurrentStaff;

  factory CurrentStaff.fromJson(Map<String, dynamic> json) =>
      _$CurrentStaffFromJson(json);
}

@freezed
abstract class SetupStatus with _$SetupStatus {
  const factory SetupStatus({required bool installed}) = _SetupStatus;

  factory SetupStatus.fromJson(Map<String, dynamic> json) =>
      _$SetupStatusFromJson(json);
}

@freezed
abstract class LivePlayer with _$LivePlayer {
  const LivePlayer._();
  const factory LivePlayer({
    required String playerId,
    required String displayName,
    required String status,
    required num walletTotal,
    required int stayDurationMinutes,
    num? estimatedTotal,
    required List<LiveSession> sessions,
  }) = _LivePlayer;

  int get sessionCount => sessions.length;
  int get activeSessionCount =>
      sessions.where((session) => session.status == 'active').length;
  bool get isActive => status == 'active';

  factory LivePlayer.fromJson(Map<String, dynamic> json) =>
      _$LivePlayerFromJson(json);
}

@freezed
abstract class LiveSession with _$LiveSession {
  const LiveSession._();
  const factory LiveSession({
    @JsonKey(readValue: readSessionId) required String id,
    String? label,
    required DateTime startedAt,
    DateTime? endedAt,
    @JsonKey(readValue: readElapsedMinutes) @Default(0) int elapsedMinutes,
    @JsonKey(readValue: readCurrentImpact) num? currentImpact,
    @Default([]) List<LivePricingCharge> pricingCharges,
    @Default('closed') String status,
  }) = _LiveSession;

  String get title {
    final value = label?.trim();
    return value == null || value.isEmpty ? '现场入场' : value;
  }

  String get sourceLine =>
      '${titleSource(title)} /入场 · ${formatClock(startedAt)}';
  String get startedLine => '${formatClock(startedAt)} 开始';
  String get entrySourceLine =>
      '${entrySource(title)} · ${formatClock(startedAt)}';
  String get pricingSummary => pricingCharges.isEmpty
      ? '暂无计费明细'
      : pricingCharges.map((charge) => charge.displayName).toSet().join('、');

  factory LiveSession.fromJson(Map<String, dynamic> json) =>
      _$LiveSessionFromJson(json);
}

@freezed
abstract class LivePricingCharge with _$LivePricingCharge {
  const LivePricingCharge._();
  const factory LivePricingCharge({
    required String pricingConfigId,
    required String planName,
    String? ruleLabel,
    required num amount,
  }) = _LivePricingCharge;

  String get displayName {
    final rule = ruleLabel?.trim();
    return rule == null || rule.isEmpty ? planName : '$planName · $rule';
  }

  factory LivePricingCharge.fromJson(Map<String, dynamic> json) =>
      _$LivePricingChargeFromJson(json);
}

@freezed
abstract class SettlementPreview with _$SettlementPreview {
  const factory SettlementPreview({
    required String playerId,
    required List<String> sessionIds,
    required num subtotal,
    required num total,
    required String status,
    DateTime? previewedAt,
    required List<SessionPreview> sessionPreviews,
  }) = _SettlementPreview;

  factory SettlementPreview.fromJson(Map<String, dynamic> json) =>
      _$SettlementPreviewFromJson(json);
}

@freezed
abstract class SessionPreview with _$SessionPreview {
  const factory SessionPreview({
    required String sessionId,
    required num subtotal,
    required num total,
  }) = _SessionPreview;

  factory SessionPreview.fromJson(Map<String, dynamic> json) =>
      _$SessionPreviewFromJson(json);
}

@freezed
abstract class PlayerIdentity with _$PlayerIdentity {
  const factory PlayerIdentity({
    required String provider,
    required String subject,
    DateTime? createdAt,
  }) = _PlayerIdentity;

  factory PlayerIdentity.fromJson(Map<String, dynamic> json) =>
      _$PlayerIdentityFromJson(json);
}

@freezed
abstract class Player with _$Player {
  const factory Player({
    required String id,
    required String displayName,
    required String status, // 'active' | 'disabled' | 'banned'
    @Default(0) num walletTotal,
    String? activeSessionId,
    @Default(0) int stayDurationMinutes,
    DateTime? createdAt,
    @Default([]) List<PlayerIdentity> identities,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

@freezed
abstract class PricingEffect with _$PricingEffect {
  const factory PricingEffect({
    required String id,
    required String name,
    required String type,
    required String scope,
    num? value,
    @Default(false) bool consumable,
    int? limitPerDay,
    DateTime? activeAt,
    DateTime? expiresAt,
    @JsonKey(readValue: readMap) Map<String, dynamic>? config,
    @JsonKey(readValue: readIsArchived) @Default(false) bool isArchived,
  }) = _PricingEffect;

  factory PricingEffect.fromJson(Map<String, dynamic> json) =>
      _$PricingEffectFromJson(json);
}

@freezed
abstract class AssetDefinition with _$AssetDefinition {
  const factory AssetDefinition({
    required String type,
    required String code,
    @JsonKey(readValue: readDisplayName) required String displayName,
    @Default(true) bool stackable,
    @JsonKey(readValue: readIsArchived) @Default(false) bool isArchived,
    String? pricingEffectId,
    PricingEffect? pricingEffect,
    DateTime? activeAt,
    DateTime? expiresAt,
  }) = _AssetDefinition;

  factory AssetDefinition.fromJson(Map<String, dynamic> json) =>
      _$AssetDefinitionFromJson(json);
}

@freezed
abstract class AssetHolding with _$AssetHolding {
  const factory AssetHolding({
    required String assetType,
    required String assetCode,
    String? assetName,
    @JsonKey(readValue: readAmount) required num amount,
    DateTime? activeAt,
    DateTime? expiresAt,
  }) = _AssetHolding;

  factory AssetHolding.fromJson(Map<String, dynamic> json) =>
      _$AssetHoldingFromJson(json);
}

@freezed
abstract class AssetLedgerEntry with _$AssetLedgerEntry {
  const factory AssetLedgerEntry({
    @Default('') String id,
    required String assetType,
    required String assetCode,
    String? assetName,
    @JsonKey(readValue: readAmount) required num amount,
    @JsonKey(readValue: readDirection)
    required String direction, // 'in' | 'out'
    required String reason,
    String? refId,
    String? transactionId,
    required DateTime createdAt,
  }) = _AssetLedgerEntry;

  factory AssetLedgerEntry.fromJson(Map<String, dynamic> json) =>
      _$AssetLedgerEntryFromJson(json);
}

@freezed
abstract class PlayerAssets with _$PlayerAssets {
  const factory PlayerAssets({
    @Default('') String playerId,
    required List<AssetHolding> holdings,
    @JsonKey(readValue: readLedger) required List<AssetLedgerEntry> ledger,
  }) = _PlayerAssets;

  factory PlayerAssets.fromJson(Map<String, dynamic> json) =>
      _$PlayerAssetsFromJson(json);
}

@freezed
abstract class AssetGrant with _$AssetGrant {
  const factory AssetGrant({
    required String assetType,
    required String assetCode,
    required num amount,
    @Default('stack') String mergeStrategy,
    DateTime? activeAt,
    DateTime? expiresAt,
    int? durationMs,
  }) = _AssetGrant;

  factory AssetGrant.fromJson(Map<String, dynamic> json) =>
      _$AssetGrantFromJson(json);
}

@freezed
abstract class Present with _$Present {
  const factory Present({
    required String id,
    required String name,
    required List<AssetGrant> grants,
    @Default(false) bool oncePerPlayer,
    DateTime? activeAt,
    DateTime? expiresAt,
    @JsonKey(readValue: readIsArchived) @Default(false) bool isArchived,
  }) = _Present;

  factory Present.fromJson(Map<String, dynamic> json) =>
      _$PresentFromJson(json);
}

@freezed
abstract class RedeemCode with _$RedeemCode {
  const factory RedeemCode({
    required String id,
    required String code,
    String? presentId,
    DateTime? activeAt,
    @Default([]) List<AssetGrant> grants,
    @JsonKey(readValue: readUsageLimit) @Default(1) int usageLimit,
    @Default(0) int usageCount,
    @Default([]) List<RedeemCodeRedemption> redemptions,
    DateTime? expiresAt,
    @Default(false) bool isRevoked,
    DateTime? createdAt,
  }) = _RedeemCode;

  factory RedeemCode.fromJson(Map<String, dynamic> json) =>
      _$RedeemCodeFromJson(json);
}

@freezed
abstract class RedeemCodeRedemption with _$RedeemCodeRedemption {
  const factory RedeemCodeRedemption({
    required String playerId,
    required String playerDisplayName,
    required DateTime redeemedAt,
  }) = _RedeemCodeRedemption;

  factory RedeemCodeRedemption.fromJson(Map<String, dynamic> json) =>
      _$RedeemCodeRedemptionFromJson(json);
}

@freezed
abstract class PlayerRedeemRecord with _$PlayerRedeemRecord {
  const factory PlayerRedeemRecord({
    required String codeId,
    required String code,
    required String presentId,
    required String presentName,
    required DateTime redeemedAt,
  }) = _PlayerRedeemRecord;

  factory PlayerRedeemRecord.fromJson(Map<String, dynamic> json) =>
      _$PlayerRedeemRecordFromJson(json);
}

@freezed
abstract class PriorityTimeRule with _$PriorityTimeRule {
  const factory PriorityTimeRule({
    @Default('') String id,
    required String label,
    required int priority,
    @Default('active') String status,
    @JsonKey(readValue: readHasTimeRange) @Default(false) bool hasTimeRange,
    @JsonKey(readValue: readStartTime) required String startTime,
    @JsonKey(readValue: readEndTime) required String endTime,
    @Default([]) List<int> weekdays,
    @JsonKey(readValue: readSpecificDates)
    @Default([])
    List<String> specificDates,
    String? specificDate,
    @JsonKey(readValue: readStartDateTime) String? startDateTime,
    @JsonKey(readValue: readEndDateTime) String? endDateTime,
    @JsonKey(readValue: readUnitMinutes) required int unitMinutes,
    @JsonKey(readValue: readUnitPrice) required num unitPrice,
    @JsonKey(readValue: readGraceMinutes) required int graceMinutes,
    @JsonKey(readValue: readPriceCap) num? priceCap,
  }) = _PriorityTimeRule;

  factory PriorityTimeRule.fromJson(Map<String, dynamic> json) =>
      _$PriorityTimeRuleFromJson(json);
}

@freezed
abstract class PricingConfig with _$PricingConfig {
  const factory PricingConfig({
    required String id,
    required String name,
    required String kind,
    @JsonKey(readValue: readPricingRules) required List<PriorityTimeRule> rules,
    @JsonKey(readValue: readProviderId) String? providerId,
    @JsonKey(readValue: readFixedChargeLabel) String? fixedChargeLabel,
    @JsonKey(readValue: readFixedChargeAmount) num? fixedChargeAmount,
    @JsonKey(readValue: readIsArchived) @Default(false) bool isArchived,
    @JsonKey(readValue: readIsActive) @Default(true) bool isActive,
  }) = _PricingConfig;

  factory PricingConfig.fromJson(Map<String, dynamic> json) =>
      _$PricingConfigFromJson(json);
}

@freezed
abstract class UnitPricing with _$UnitPricing {
  const factory UnitPricing({
    @Default('') String ruleId,
    @Default(0) int startMinute,
    @Default(0) int endMinute,
    @JsonKey(readValue: readStartTime) required String startTime,
    @JsonKey(readValue: readEndTime) required String endTime,
    @JsonKey(readValue: readTimelinePrice) required num price,
    @Default(false) bool isClosed,
    String? label,
  }) = _UnitPricing;

  factory UnitPricing.fromJson(Map<String, dynamic> json) =>
      _$UnitPricingFromJson(json);
}

@freezed
abstract class PricingTimeline with _$PricingTimeline {
  const factory PricingTimeline({
    @JsonKey(readValue: readTimelineSegments)
    @Default([])
    List<UnitPricing> timeline,
    @JsonKey(readValue: readPricingConfigId)
    @Default('')
    String pricingConfigId,
  }) = _PricingTimeline;

  factory PricingTimeline.fromJson(Map<String, dynamic> json) =>
      _$PricingTimelineFromJson(json);
}

@freezed
abstract class BusinessItem with _$BusinessItem {
  const factory BusinessItem({
    required String id,
    required String name,
    required num price,
    required String kind,
    @Default('active') String status,
    String? assetType,
    String? assetCode,
    DateTime? activeAt,
    DateTime? expiresAt,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(readValue: readIsArchived) @Default(false) bool isArchived,
  }) = _BusinessItem;

  factory BusinessItem.fromJson(Map<String, dynamic> json) =>
      _$BusinessItemFromJson(json);
}

@freezed
abstract class BusinessItemOrder with _$BusinessItemOrder {
  const factory BusinessItemOrder({
    required String id,
    required String playerId,
    @JsonKey(readValue: readItemId) required String itemId,
    @JsonKey(readValue: readItemName) required String itemName,
    @Default('') String businessItemKind,
    required num price,
    required String status,
    required DateTime createdAt,
    String? sessionId,
    String? assetType,
    String? assetCode,
    Map<String, dynamic>? metadata,
    DateTime? updatedAt,
    DateTime? fulfilledAt,
    DateTime? cancelledAt,
  }) = _BusinessItemOrder;

  factory BusinessItemOrder.fromJson(Map<String, dynamic> json) =>
      _$BusinessItemOrderFromJson(json);
}

@freezed
abstract class DeviceState with _$DeviceState {
  const factory DeviceState({
    required String deviceId,
    required String label,
    required String type,
    @JsonKey(readValue: readTargetKind) @Default('facility') String targetKind,
    String? executorKind,
    required String status,
    String? state,
    Map<String, dynamic>? metadata,
    required DateTime reportedAt,
    required String reportedBy,
  }) = _DeviceState;

  factory DeviceState.fromJson(Map<String, dynamic> json) =>
      _$DeviceStateFromJson(json);
}

@freezed
abstract class MachineConnection with _$MachineConnection {
  const factory MachineConnection({
    required String machineId,
    required String status,
    @Default([]) List<String> capabilities,
    required DateTime connectedAt,
    required DateTime lastSeenAt,
    DateTime? disconnectedAt,
  }) = _MachineConnection;

  factory MachineConnection.fromJson(Map<String, dynamic> json) =>
      _$MachineConnectionFromJson(json);
}

@freezed
abstract class DeviceCommand with _$DeviceCommand {
  const factory DeviceCommand({
    required String id,
    @JsonKey(readValue: readCommandType) required String commandType,
    required String deviceId,
    @JsonKey(readValue: readTargetKind) @Default('facility') String targetKind,
    String? executorKind,
    @JsonKey(readValue: readRequester) required String requester,
    String? playerId,
    String? staffId,
    required String status,
    Map<String, dynamic>? payload,
    @JsonKey(readValue: readCreatedAt) required DateTime createdAt,
    DateTime? ackedAt,
    DateTime? expiredAt,
  }) = _DeviceCommand;

  factory DeviceCommand.fromJson(Map<String, dynamic> json) =>
      _$DeviceCommandFromJson(json);
}

@freezed
abstract class ReportSummary with _$ReportSummary {
  const factory ReportSummary({
    @JsonKey(readValue: readRevenue) required num revenue,
    @JsonKey(readValue: readSettledSessionsCount)
    required int settledSessionsCount,
    @JsonKey(readValue: readAssetGrantsCount) required int assetGrantsCount,
    @JsonKey(readValue: readCoinCommandsCount) required int coinCommandsCount,
  }) = _ReportSummary;

  factory ReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryFromJson(json);
}

@freezed
abstract class SettlementReportRow with _$SettlementReportRow {
  const factory SettlementReportRow({
    required String playerId,
    @JsonKey(readValue: readDisplayName) required String displayName,
    int? durationMinutes,
    required num subtotal,
    required num total,
    required DateTime settledAt,
  }) = _SettlementReportRow;

  factory SettlementReportRow.fromJson(Map<String, dynamic> json) =>
      _$SettlementReportRowFromJson(json);
}

@freezed
abstract class PlayerReportRow with _$PlayerReportRow {
  const factory PlayerReportRow({
    required String playerId,
    @JsonKey(readValue: readDisplayName) required String displayName,
    required int settlementCount,
    required int totalDurationMinutes,
    @JsonKey(readValue: readRevenue) required num revenue,
    required DateTime lastSettledAt,
  }) = _PlayerReportRow;

  factory PlayerReportRow.fromJson(Map<String, dynamic> json) =>
      _$PlayerReportRowFromJson(json);
}

@freezed
abstract class SettingsData with _$SettingsData {
  const factory SettingsData({
    @JsonKey(readValue: readStoreName) required String storeName,
    @JsonKey(readValue: readTimeZone) required String timeZone,
    @JsonKey(readValue: readCoinCooldownMs) required int coinCooldownMs,
  }) = _SettingsData;

  factory SettingsData.fromJson(Map<String, dynamic> json) =>
      _$SettingsDataFromJson(json);
}

@freezed
abstract class StaffUser with _$StaffUser {
  const factory StaffUser({
    required String id,
    required String username,
    required String displayName,
    @JsonKey(unknownEnumValue: StaffRole.viewer) required StaffRole role,
    @JsonKey(readValue: readIsArchived) @Default(false) bool isArchived,
  }) = _StaffUser;

  factory StaffUser.fromJson(Map<String, dynamic> json) =>
      _$StaffUserFromJson(json);
}

@Freezed(toStringOverride: false)
abstract class ApiToken with _$ApiToken {
  const factory ApiToken({
    required String id,
    required String label,
    @JsonKey(includeToJson: false) String? token,
    required DateTime createdAt,
    @Default('integration') String role,
    @Default('') String tokenPrefix,
    @JsonKey(readValue: readIsRevoked) @Default(false) bool isRevoked,
  }) = _ApiToken;

  factory ApiToken.fromJson(Map<String, dynamic> json) =>
      _$ApiTokenFromJson(json);
}

DateTime? parseDate(dynamic value) {
  if (value is String && value.isNotEmpty) return DateTime.tryParse(value);
  return null;
}

List<T> listOf<T>(dynamic value, T Function(Map<String, dynamic>) mapper) {
  final list = value is List ? value : const [];
  return [
    for (final item in list)
      if (item is Map) mapper(item.cast<String, dynamic>()),
  ];
}

Object? nestedValue(Map json, List<String> keys) {
  Object? current = json;
  for (final key in keys) {
    if (current is! Map) return null;
    current = current[key];
  }
  return current;
}

Object? readDisplayName(Map json, String key) =>
    json[key] ?? json['name'] ?? json['playerDisplayName'];
Object? readSessionId(Map json, String key) => json[key] ?? json['sessionId'];
Object? readElapsedMinutes(Map json, String key) =>
    json[key] ?? json['durationMinutes'];
Object? readCurrentImpact(Map json, String key) => json[key] ?? json['total'];
Object? readIsArchived(Map json, String key) =>
    json[key] ?? (json['status'] == 'archived' || json['status'] == 'disabled');
Object? readIsActive(Map json, String key) =>
    json[key] ?? json['enabled'] ?? (json['status'] == 'active');
Object? readAmount(Map json, String key) =>
    json[key] ?? json['quantity'] ?? json['delta'];
Object? readDirection(Map json, String key) {
  final explicit = json[key];
  if (explicit != null) return explicit;
  final delta = json['delta'];
  if (delta is num) return delta < 0 ? 'out' : 'in';
  return 'in';
}

Object? readLedger(Map json, String key) => json[key] ?? json['ledgerEntries'];
Object? readUsageLimit(Map json, String key) =>
    json[key] ?? json['maxUseCount'];
Object? readMap(Map json, String key) {
  final value = json[key];
  return value is Map ? value.cast<String, dynamic>() : null;
}

Object? readPricingRules(Map json, String key) =>
    json[key] ?? nestedValue(json, ['provider', 'rules']) ?? const [];
Object? readProviderId(Map json, String key) =>
    json[key] ?? nestedValue(json, ['provider', 'id']);
Object? readFixedChargeLabel(Map json, String key) =>
    json[key] ?? nestedValue(json, ['provider', 'label']);
Object? readFixedChargeAmount(Map json, String key) =>
    json[key] ?? nestedValue(json, ['provider', 'amount']);
Object? readHasTimeRange(Map json, String key) {
  final value = json[key];
  if (value != null) return value;
  return nestedValue(json, ['timeRange', 'start']) != null ||
      nestedValue(json, ['timeRange', 'end']) != null;
}

Object? readStartTime(Map json, String key) =>
    json[key] ??
    json['startLabel'] ??
    nestedValue(json, ['timeRange', 'start']) ??
    clockFromIso(nestedValue(json, ['dateTimeRange', 'start']));
Object? readEndTime(Map json, String key) =>
    json[key] ??
    json['endLabel'] ??
    nestedValue(json, ['timeRange', 'end']) ??
    clockFromIso(nestedValue(json, ['dateTimeRange', 'end']));
Object? readStartDateTime(Map json, String key) =>
    json[key] ?? nestedValue(json, ['dateTimeRange', 'start']);
Object? readEndDateTime(Map json, String key) =>
    json[key] ?? nestedValue(json, ['dateTimeRange', 'end']);
Object? readSpecificDates(Map json, String key) {
  final value = json[key];
  if (value is List) return value;
  final singular = json['specificDate'];
  if (singular is String && singular.isNotEmpty) return [singular];
  return const [];
}

Object? readUnitMinutes(Map json, String key) =>
    json[key] ?? nestedValue(json, ['pricing', 'unitMinutes']);
Object? readUnitPrice(Map json, String key) =>
    json[key] ?? nestedValue(json, ['pricing', 'unitPrice']);
Object? readGraceMinutes(Map json, String key) =>
    json[key] ?? nestedValue(json, ['pricing', 'roundGraceMinutes']);
Object? readPriceCap(Map json, String key) =>
    json[key] ?? nestedValue(json, ['pricing', 'priceCap']);
Object? readTimelinePrice(Map json, String key) =>
    json[key] ??
    json['amount'] ??
    json['unitPrice'] ??
    nestedValue(json, ['pricing', 'unitPrice']);
Object? readTimelineSegments(Map json, String key) {
  final explicit = json[key];
  if (explicit is List) return explicit;
  return nestedValue(json, ['timeline', 'segments']);
}

Object? readPricingConfigId(Map json, String key) =>
    json[key] ?? nestedValue(json, ['timeline', 'providerId']);
Object? readItemId(Map json, String key) => json[key] ?? json['businessItemId'];
Object? readItemName(Map json, String key) =>
    json[key] ?? json['businessItemName'];
Object? readCommandType(Map json, String key) => json[key] ?? json['type'];
Object? readTargetKind(Map json, String key) =>
    json[key] ?? nestedValue(json, ['target', 'kind']);
Object? readRequester(Map json, String key) =>
    json[key] ?? json['requester'] ?? json['staffId'] ?? json['playerId'];
Object? readCreatedAt(Map json, String key) => json[key] ?? json['requestedAt'];
Object? readRevenue(Map json, String key) =>
    json[key] ??
    json['revenueTotal'] ??
    nestedValue(json, ['summary', 'revenueTotal']);
Object? readSettledSessionsCount(Map json, String key) =>
    json[key] ??
    json['sessionCount'] ??
    nestedValue(json, ['summary', 'sessionCount']);
Object? readAssetGrantsCount(Map json, String key) =>
    json[key] ??
    json['assetGrantTotal'] ??
    nestedValue(json, ['summary', 'assetGrantTotal']);
Object? readCoinCommandsCount(Map json, String key) =>
    json[key] ??
    json['coinCommandCount'] ??
    nestedValue(json, ['summary', 'coinCommandCount']);
Object? readStoreName(Map json, String key) =>
    json[key] ?? nestedValue(json, ['store', 'name']);
Object? readTimeZone(Map json, String key) =>
    json[key] ?? nestedValue(json, ['store', 'timeZone']);
Object? readCoinCooldownMs(Map json, String key) =>
    json[key] ?? nestedValue(json, ['operations', 'coinCooldownMs']);
Object? readIsRevoked(Map json, String key) =>
    json[key] ?? (json['status'] == 'revoked');
Object? readCanWrite(Map json, String key) {
  final explicit = json[key];
  if (explicit != null) return explicit;
  return json['role'] == 'owner' || json['role'] == 'manager';
}

String formatDurationMinutes(int minutes) {
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (hours <= 0) return '$rest 分钟';
  if (rest == 0) return '$hours 小时';
  return '$hours 小时 ${rest.toString().padLeft(2, '0')} 分';
}

String formatMoney(num? value) {
  if (value == null) return '--';
  final sign = value < 0 ? '-' : '';
  final abs = value.abs();
  final text = abs % 1 == 0 ? abs.toInt().toString() : abs.toStringAsFixed(2);
  return '$sign¥$text';
}

String formatClock(DateTime value) {
  final local = value.toLocal();
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

String? clockFromIso(Object? value) {
  if (value is! String || value.isEmpty) return null;
  final date = DateTime.tryParse(value);
  if (date == null) return null;
  return formatClock(date);
}

String titleSource(String label) {
  if (label.contains('QQ')) return 'QQ群';
  if (label.contains('扫码')) return '扫码';
  if (label.contains('员工') || label.contains('管理员')) return '店员';
  return '现场';
}

String entrySource(String label) {
  if (label.contains('QQ')) return 'QQ群 /入场';
  if (label.contains('扫码')) return '扫码入场';
  if (label.contains('员工')) return '员工代开';
  if (label.contains('Aime')) return 'Aime';
  return '现场 /入场';
}
