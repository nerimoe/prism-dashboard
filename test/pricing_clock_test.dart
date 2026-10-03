import 'package:flutter_test/flutter_test.dart';
import 'package:prism_dashboard/src/shared/admin_time_zone.dart';
import 'package:prism_dashboard/src/shared/pricing_clock.dart';

void main() {
  setUp(() => setAdminTimeZone('Asia/Shanghai'));
  test('Shanghai overnight editor clocks round-trip through UTC', () {
    final local = <String, dynamic>{
      'id': 'base',
      'timeRange': {'start': '10:00', 'end': '03:00'},
    };
    final utc = convertPricingClock(
      local,
      'Asia/Shanghai',
      'UTC',
      '2026-10-02',
    );
    expect(utc['timeRange'], {'start': '02:00', 'end': '19:00'});
    expect(
      convertPricingClock(utc, 'UTC', 'Asia/Shanghai', '2026-10-02'),
      local,
    );
  });
  test('all-day weekday and date anchors shift together', () {
    final local = <String, dynamic>{
      'timeRange': {'start': '00:00', 'end': '00:00'},
      'weekdays': [1],
      'specificDates': ['2026-10-05'],
    };
    final utc = convertPricingClock(
      local,
      'Asia/Shanghai',
      'UTC',
      '2026-10-05',
    );
    expect(utc['timeRange'], {'start': '16:00', 'end': '16:00'});
    expect(utc['weekdays'], [0]);
    expect(utc['specificDates'], ['2026-10-04']);
    expect(
      convertPricingClock(utc, 'UTC', 'Asia/Shanghai', '2026-10-04'),
      local,
    );
  });
  test('absolute timestamps are not shifted twice', () {
    final rule = <String, dynamic>{
      'dateTimeRange': {
        'start': '2026-10-02T02:00:00Z',
        'end': '2026-10-02T19:00:00Z',
      },
    };
    expect(
      convertPricingClock(rule, 'UTC', 'Asia/Shanghai', '2026-10-02'),
      rule,
    );
  });
  test('changing preview season preserves the UTC business clock', () {
    final winter = <String, dynamic>{
      'timeRange': {'start': '05:00', 'end': '07:00'},
    };
    final summer = rebasePricingClock(
      winter,
      'America/New_York',
      '2026-01-02',
      '2026-07-02',
    );
    expect(summer['timeRange'], {'start': '06:00', 'end': '08:00'});
    expect(
      convertPricingClock(
        summer,
        'America/New_York',
        'UTC',
        '2026-07-02',
      )['timeRange'],
      {'start': '10:00', 'end': '12:00'},
    );
  });
  test(
    'dated rules with incompatible endpoint offsets require separate rules',
    () {
      expect(
        () => convertPricingClock(
          {
            'timeRange': {'start': '01:00', 'end': '04:00'},
            'specificDates': ['2026-03-07', '2026-03-08'],
          },
          'America/New_York',
          'UTC',
          '2026-03-07',
        ),
        throwsFormatException,
      );
    },
  );
}
