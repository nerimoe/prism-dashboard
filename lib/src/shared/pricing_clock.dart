import 'package:timezone/timezone.dart' as tz;
import 'admin_time_zone.dart';

/// Convert editor clocks at the boundary; the API and billing clocks are UTC.
Map<String, dynamic> convertPricingClock(
  Map<String, dynamic> rule,
  String from,
  String to,
  String referenceDate,
) {
  final range = rule['timeRange'];
  if (range is! Map || from == to) return {...rule};
  toAdminTime(DateTime.now()); // Initialize the shared timezone database.
  final source = tz.getLocation(from), target = tz.getLocation(to);
  final dates = (rule['specificDates'] as List?)?.cast<String>();
  final anchor = dates?.isNotEmpty == true ? dates!.first : referenceDate;
  final day = DateTime.parse(anchor);
  tz.TZDateTime convert(String date, String clock, [int dayOffset = 0]) {
    final d = DateTime.parse(date);
    final c = clock.split(':').map(int.parse).toList();
    return tz.TZDateTime.from(
      tz.TZDateTime(source, d.year, d.month, d.day + dayOffset, c[0], c[1]),
      target,
    );
  }

  String date(tz.TZDateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  String clock(tz.TZDateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  final startText = range['start'] as String, endText = range['end'] as String;
  final start = convert(anchor, startText);
  final end = startText == endText
      ? start
      : convert(anchor, endText, startText.compareTo(endText) >= 0 ? 1 : 0);
  final shift = DateTime.utc(
    start.year,
    start.month,
    start.day,
  ).difference(DateTime.utc(day.year, day.month, day.day)).inDays;
  for (final d in dates ?? <String>[]) {
    final datedStart = convert(d, startText);
    final datedEnd = startText == endText
        ? datedStart
        : convert(d, endText, startText.compareTo(endText) >= 0 ? 1 : 0);
    if (clock(datedStart) != clock(start) || clock(datedEnd) != clock(end)) {
      throw const FormatException('跨夏令时的指定日期请拆成独立规则或使用绝对时间区间。');
    }
  }
  return {
    ...rule,
    'timeRange': {'start': clock(start), 'end': clock(end)},
    if (rule['weekdays'] is List)
      'weekdays': [
        for (final d in rule['weekdays'] as List) ((d as int) + shift + 7) % 7,
      ],
    if (dates != null)
      'specificDates': [for (final d in dates) date(convert(d, startText))],
  };
}

/// Reproject a fixed UTC schedule when the preview date changes its UI offset.
Map<String, dynamic> rebasePricingClock(
  Map<String, dynamic> rule,
  String zone,
  String previousDate,
  String nextDate,
) {
  return convertPricingClock(
    convertPricingClock(rule, zone, 'UTC', previousDate),
    'UTC',
    zone,
    nextDate,
  );
}
