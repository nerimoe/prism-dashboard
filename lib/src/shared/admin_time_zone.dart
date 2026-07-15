import 'package:timezone/data/latest_10y.dart' as time_zone_data;
import 'package:timezone/timezone.dart' as time_zone;

const defaultAdminTimeZone = 'Asia/Shanghai';

bool _initialized = false;
late time_zone.Location _location;
String _locationName = defaultAdminTimeZone;

String get adminTimeZone => _locationName;

void setAdminTimeZone(String value) {
  _ensureInitialized();
  final name = value.trim();
  try {
    _location = time_zone.getLocation(
      name.isEmpty ? defaultAdminTimeZone : name,
    );
    _locationName = _location.name;
  } on time_zone.LocationNotFoundException {
    _location = time_zone.getLocation(defaultAdminTimeZone);
    _locationName = defaultAdminTimeZone;
  }
}

DateTime toAdminTime(DateTime value) {
  _ensureInitialized();
  return time_zone.TZDateTime.from(value.toUtc(), _location);
}

DateTime adminNow() {
  _ensureInitialized();
  return time_zone.TZDateTime.now(_location);
}

DateTime adminLocalDateTimeToUtc(DateTime value) {
  _ensureInitialized();
  return time_zone.TZDateTime(
    _location,
    value.year,
    value.month,
    value.day,
    value.hour,
    value.minute,
    value.second,
    value.millisecond,
    value.microsecond,
  ).toUtc();
}

void _ensureInitialized() {
  if (_initialized) return;
  time_zone_data.initializeTimeZones();
  _initialized = true;
  _location = time_zone.getLocation(defaultAdminTimeZone);
}
