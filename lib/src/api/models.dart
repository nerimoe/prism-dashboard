enum StaffRole { owner, manager, viewer }

StaffRole staffRoleFromJson(String value) {
  return StaffRole.values.firstWhere(
    (role) => role.name == value,
    orElse: () => StaffRole.viewer,
  );
}

class CurrentStaff {
  const CurrentStaff({
    required this.id,
    required this.displayName,
    required this.role,
    required this.canWrite,
  });

  final String id;
  final String displayName;
  final StaffRole role;
  final bool canWrite;

  factory CurrentStaff.fromJson(Map<String, dynamic> json) {
    final role = staffRoleFromJson(json['role'] as String? ?? 'viewer');
    return CurrentStaff(
      id: json['id'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      role: role,
      canWrite:
          json['canWrite'] as bool? ??
          role == StaffRole.owner || role == StaffRole.manager,
    );
  }
}

class SetupStatus {
  const SetupStatus({required this.installed});
  final bool installed;

  factory SetupStatus.fromJson(Map<String, dynamic> json) {
    return SetupStatus(installed: json['installed'] as bool? ?? false);
  }
}

class LivePlayer {
  const LivePlayer({
    required this.playerId,
    required this.displayName,
    required this.status,
    required this.walletTotal,
    required this.stayDurationMinutes,
    required this.estimatedTotal,
    required this.sessions,
  });

  final String playerId;
  final String displayName;
  final String status;
  final num walletTotal;
  final int stayDurationMinutes;
  final num? estimatedTotal;
  final List<LiveSession> sessions;

  int get sessionCount => sessions.length;
  bool get isActive => status == 'active';

  factory LivePlayer.fromJson(Map<String, dynamic> json) {
    return LivePlayer(
      playerId: json['playerId'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      walletTotal: json['walletTotal'] as num? ?? 0,
      stayDurationMinutes: (json['stayDurationMinutes'] as num? ?? 0).toInt(),
      estimatedTotal: json['estimatedTotal'] as num?,
      sessions: listOf(json['sessions'], LiveSession.fromJson),
    );
  }
}

class LiveSession {
  const LiveSession({
    required this.id,
    required this.startedAt,
    required this.elapsedMinutes,
    required this.status,
    this.label,
    this.currentImpact,
  });

  final String id;
  final String? label;
  final DateTime startedAt;
  final int elapsedMinutes;
  final num? currentImpact;
  final String status;

  String get title {
    final value = label?.trim();
    return value == null || value.isEmpty ? '现场入场' : value;
  }

  String get sourceLine =>
      '${titleSource(title)} /入场 · ${formatClock(startedAt)}';
  String get startedLine => '${formatClock(startedAt)} 开始';
  String get entrySourceLine =>
      '${entrySource(title)} · ${formatClock(startedAt)}';
  String get pricingRuleLabel {
    if (title.contains('麻将') || title.contains('自定义')) return '店内加减价';
    return '音游按时收费';
  }

  factory LiveSession.fromJson(Map<String, dynamic> json) {
    return LiveSession(
      id: json['id'] as String? ?? '',
      label: json['label'] as String?,
      startedAt:
          parseDate(json['startedAt']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      elapsedMinutes: (json['elapsedMinutes'] as num? ?? 0).toInt(),
      currentImpact: json['currentImpact'] as num?,
      status: json['status'] as String? ?? 'active',
    );
  }
}

class SettlementPreview {
  const SettlementPreview({
    required this.playerId,
    required this.sessionIds,
    required this.subtotal,
    required this.total,
    required this.status,
    required this.previewedAt,
    required this.sessionPreviews,
  });

  final String playerId;
  final List<String> sessionIds;
  final num subtotal;
  final num total;
  final String status;
  final DateTime? previewedAt;
  final List<SessionPreview> sessionPreviews;

  factory SettlementPreview.fromJson(Map<String, dynamic> json) {
    final preview = ((json['settlementPreview'] as Map?) ?? {})
        .cast<String, dynamic>();
    return SettlementPreview(
      playerId: preview['playerId'] as String? ?? '',
      sessionIds: [
        for (final id in preview['sessionIds'] as List? ?? const [])
          id.toString(),
      ],
      subtotal: preview['subtotal'] as num? ?? 0,
      total: preview['total'] as num? ?? 0,
      status: preview['status'] as String? ?? 'preview',
      previewedAt: parseDate(preview['previewedAt']),
      sessionPreviews: listOf(json['sessionPreviews'], SessionPreview.fromJson),
    );
  }
}

class SessionPreview {
  const SessionPreview({
    required this.sessionId,
    required this.subtotal,
    required this.total,
  });

  final String sessionId;
  final num subtotal;
  final num total;

  factory SessionPreview.fromJson(Map<String, dynamic> json) {
    return SessionPreview(
      sessionId: json['sessionId'] as String? ?? '',
      subtotal: json['subtotal'] as num? ?? 0,
      total: json['total'] as num? ?? 0,
    );
  }
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
