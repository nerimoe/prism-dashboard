String formatAdminDate(DateTime? value) {
  if (value == null) return '--';
  final local = value.toLocal();
  return '${local.year}-${_two(local.month)}-${_two(local.day)}';
}

String formatAdminDateTime(DateTime? value) {
  if (value == null) return '--';
  final local = value.toLocal();
  return '${formatAdminDate(local)} ${_two(local.hour)}:${_two(local.minute)}';
}

String formatAdminClock(DateTime? value) {
  if (value == null) return '--';
  final local = value.toLocal();
  return '${_two(local.hour)}:${_two(local.minute)}';
}

String _two(int value) => value.toString().padLeft(2, '0');
