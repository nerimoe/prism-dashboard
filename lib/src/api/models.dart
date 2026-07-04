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
    required StaffRole role,
    @Default(false) bool canWrite,
  }) = _CurrentStaff;

  factory CurrentStaff.fromJson(Map<String, dynamic> json) => _$CurrentStaffFromJson(json);
}

@freezed
abstract class SetupStatus with _$SetupStatus {
  const factory SetupStatus({
    required bool installed,
  }) = _SetupStatus;

  factory SetupStatus.fromJson(Map<String, dynamic> json) => _$SetupStatusFromJson(json);
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
  bool get isActive => status == 'active';

  factory LivePlayer.fromJson(Map<String, dynamic> json) => _$LivePlayerFromJson(json);
}

@freezed
abstract class LiveSession with _$LiveSession {
  const LiveSession._();
  const factory LiveSession({
    required String id,
    String? label,
    required DateTime startedAt,
    required int elapsedMinutes,
    num? currentImpact,
    required String status,
  }) = _LiveSession;

  String get title {
    final value = label?.trim();
    return value == null || value.isEmpty ? '现场入场' : value;
  }

  String get sourceLine => '${titleSource(title)} /入场 · ${formatClock(startedAt)}';
  String get startedLine => '${formatClock(startedAt)} 开始';
  String get entrySourceLine => '${entrySource(title)} · ${formatClock(startedAt)}';
  String get pricingRuleLabel {
    if (title.contains('麻将') || title.contains('自定义')) return '店内加减价';
    return '音游按时收费';
  }

  factory LiveSession.fromJson(Map<String, dynamic> json) => _$LiveSessionFromJson(json);
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

  factory SettlementPreview.fromJson(Map<String, dynamic> json) => _$SettlementPreviewFromJson(json);
}

@freezed
abstract class SessionPreview with _$SessionPreview {
  const factory SessionPreview({
    required String sessionId,
    required num subtotal,
    required num total,
  }) = _SessionPreview;

  factory SessionPreview.fromJson(Map<String, dynamic> json) => _$SessionPreviewFromJson(json);
}

@freezed
abstract class Player with _$Player {
  const factory Player({
    required String id,
    required String displayName,
    required String status, // 'active' | 'inactive' | 'banned'
    required num walletTotal,
    required int stayDurationMinutes,
    DateTime? createdAt,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

@freezed
abstract class AssetDefinition with _$AssetDefinition {
  const factory AssetDefinition({
    required String type,
    required String code,
    required String displayName,
    @Default(false) bool isArchived,
  }) = _AssetDefinition;

  factory AssetDefinition.fromJson(Map<String, dynamic> json) => _$AssetDefinitionFromJson(json);
}

@freezed
abstract class AssetHolding with _$AssetHolding {
  const factory AssetHolding({
    required String assetType,
    required String assetCode,
    required num amount,
  }) = _AssetHolding;

  factory AssetHolding.fromJson(Map<String, dynamic> json) => _$AssetHoldingFromJson(json);
}

@freezed
abstract class AssetLedgerEntry with _$AssetLedgerEntry {
  const factory AssetLedgerEntry({
    required String id,
    required String assetType,
    required String assetCode,
    required num amount,
    required String direction, // 'in' | 'out'
    required String reason,
    required DateTime createdAt,
  }) = _AssetLedgerEntry;

  factory AssetLedgerEntry.fromJson(Map<String, dynamic> json) => _$AssetLedgerEntryFromJson(json);
}

@freezed
abstract class PlayerAssets with _$PlayerAssets {
  const factory PlayerAssets({
    required String playerId,
    required List<AssetHolding> holdings,
    required List<AssetLedgerEntry> ledger,
  }) = _PlayerAssets;

  factory PlayerAssets.fromJson(Map<String, dynamic> json) => _$PlayerAssetsFromJson(json);
}

@freezed
abstract class AssetGrant with _$AssetGrant {
  const factory AssetGrant({
    required String assetType,
    required String assetCode,
    required num amount,
  }) = _AssetGrant;

  factory AssetGrant.fromJson(Map<String, dynamic> json) => _$AssetGrantFromJson(json);
}

@freezed
abstract class Present with _$Present {
  const factory Present({
    required String id,
    required String name,
    required List<AssetGrant> grants,
    @Default(false) bool isArchived,
  }) = _Present;

  factory Present.fromJson(Map<String, dynamic> json) => _$PresentFromJson(json);
}

@freezed
abstract class RedeemCode with _$RedeemCode {
  const factory RedeemCode({
    required String id,
    required String code,
    required List<AssetGrant> grants,
    required int usageLimit,
    required int usageCount,
    DateTime? expiresAt,
    @Default(false) bool isRevoked,
    DateTime? createdAt,
  }) = _RedeemCode;

  factory RedeemCode.fromJson(Map<String, dynamic> json) => _$RedeemCodeFromJson(json);
}

@freezed
abstract class PriorityTimeRule with _$PriorityTimeRule {
  const factory PriorityTimeRule({
    required String label,
    required int priority,
    required String startTime,
    required String endTime,
    required List<int> weekdays,
    String? specificDate,
    String? startDateTime,
    String? endDateTime,
    required int unitMinutes,
    required num unitPrice,
    required int graceMinutes,
    num? priceCap,
  }) = _PriorityTimeRule;

  factory PriorityTimeRule.fromJson(Map<String, dynamic> json) => _$PriorityTimeRuleFromJson(json);
}

@freezed
abstract class PricingConfig with _$PricingConfig {
  const factory PricingConfig({
    required String id,
    required String name,
    required String kind,
    required List<PriorityTimeRule> rules,
    @Default(false) bool isArchived,
    @Default(true) bool isActive,
  }) = _PricingConfig;

  factory PricingConfig.fromJson(Map<String, dynamic> json) => _$PricingConfigFromJson(json);
}

@freezed
abstract class UnitPricing with _$UnitPricing {
  const factory UnitPricing({
    required String startTime,
    required String endTime,
    required num price,
  }) = _UnitPricing;

  factory UnitPricing.fromJson(Map<String, dynamic> json) => _$UnitPricingFromJson(json);
}

@freezed
abstract class PricingTimeline with _$PricingTimeline {
  const factory PricingTimeline({
    required List<UnitPricing> timeline,
    required String pricingConfigId,
  }) = _PricingTimeline;

  factory PricingTimeline.fromJson(Map<String, dynamic> json) => _$PricingTimelineFromJson(json);
}

@freezed
abstract class BusinessItem with _$BusinessItem {
  const factory BusinessItem({
    required String id,
    required String name,
    required num price,
    required String kind,
    @Default(false) bool isArchived,
  }) = _BusinessItem;

  factory BusinessItem.fromJson(Map<String, dynamic> json) => _$BusinessItemFromJson(json);
}

@freezed
abstract class BusinessItemOrder with _$BusinessItemOrder {
  const factory BusinessItemOrder({
    required String id,
    required String playerId,
    required String itemId,
    required String itemName,
    required num price,
    required String status,
    required DateTime createdAt,
    DateTime? fulfilledAt,
    DateTime? cancelledAt,
  }) = _BusinessItemOrder;

  factory BusinessItemOrder.fromJson(Map<String, dynamic> json) => _$BusinessItemOrderFromJson(json);
}

@freezed
abstract class DeviceState with _$DeviceState {
  const factory DeviceState({
    required String deviceId,
    required String label,
    required String type,
    required String status,
    required DateTime reportedAt,
    required String reportedBy,
  }) = _DeviceState;

  factory DeviceState.fromJson(Map<String, dynamic> json) => _$DeviceStateFromJson(json);
}

@freezed
abstract class DeviceCommand with _$DeviceCommand {
  const factory DeviceCommand({
    required String id,
    required String commandType,
    required String deviceId,
    required String requester,
    required String status,
    required DateTime createdAt,
    DateTime? ackedAt,
  }) = _DeviceCommand;

  factory DeviceCommand.fromJson(Map<String, dynamic> json) => _$DeviceCommandFromJson(json);
}

@freezed
abstract class ReportSummary with _$ReportSummary {
  const factory ReportSummary({
    required num revenue,
    required int settledSessionsCount,
    required int assetGrantsCount,
    required int coinCommandsCount,
  }) = _ReportSummary;

  factory ReportSummary.fromJson(Map<String, dynamic> json) => _$ReportSummaryFromJson(json);
}

@freezed
abstract class SettlementReportRow with _$SettlementReportRow {
  const factory SettlementReportRow({
    required String playerId,
    required String displayName,
    required int durationMinutes,
    required num subtotal,
    required num total,
    required DateTime settledAt,
  }) = _SettlementReportRow;

  factory SettlementReportRow.fromJson(Map<String, dynamic> json) => _$SettlementReportRowFromJson(json);
}

@freezed
abstract class PlayerReportRow with _$PlayerReportRow {
  const factory PlayerReportRow({
    required String playerId,
    required String displayName,
    required int settlementCount,
    required int totalDurationMinutes,
    required num revenue,
    required DateTime lastSettledAt,
  }) = _PlayerReportRow;

  factory PlayerReportRow.fromJson(Map<String, dynamic> json) => _$PlayerReportRowFromJson(json);
}

@freezed
abstract class SettingsData with _$SettingsData {
  const factory SettingsData({
    required String storeName,
    required String timeZone,
    required int coinCooldownMs,
  }) = _SettingsData;

  factory SettingsData.fromJson(Map<String, dynamic> json) => _$SettingsDataFromJson(json);
}

@freezed
abstract class StaffUser with _$StaffUser {
  const factory StaffUser({
    required String id,
    required String username,
    required String displayName,
    required StaffRole role,
    @Default(false) bool isArchived,
  }) = _StaffUser;

  factory StaffUser.fromJson(Map<String, dynamic> json) => _$StaffUserFromJson(json);
}

@freezed
abstract class ApiToken with _$ApiToken {
  const factory ApiToken({
    required String id,
    required String label,
    String? token,
    required DateTime createdAt,
    @Default(false) bool isRevoked,
  }) = _ApiToken;

  factory ApiToken.fromJson(Map<String, dynamic> json) => _$ApiTokenFromJson(json);
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
