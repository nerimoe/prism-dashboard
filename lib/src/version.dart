class PrismVersion {
  const PrismVersion({required this.version, required this.revision});

  factory PrismVersion.fromJson(Map<String, dynamic> json) {
    return PrismVersion(
      version: json['version'] as String? ?? 'unknown',
      revision: json['revision'] as String? ?? 'unknown',
    );
  }

  final String version;
  final String revision;

  String get display {
    if (revision.isNotEmpty && revision != 'unknown') {
      if (version == 'dev' || version.isEmpty || version == 'unknown' || version == revision) {
        return revision;
      }
      return '$version ($revision)';
    }
    return version;
  }
}

const dashboardBuildVersion = PrismVersion(
  version: String.fromEnvironment(
    'PRISM_DASHBOARD_REVISION',
    defaultValue: String.fromEnvironment(
      'PRISM_DASHBOARD_VERSION',
      defaultValue: 'dev',
    ),
  ),
  revision: String.fromEnvironment(
    'PRISM_DASHBOARD_REVISION',
    defaultValue: 'unknown',
  ),
);
