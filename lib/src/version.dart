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

  String get display => revision.isEmpty || revision == 'unknown'
      ? version
      : '$version ($revision)';
}

const dashboardBuildVersion = PrismVersion(
  version: String.fromEnvironment(
    'PRISM_DASHBOARD_VERSION',
    defaultValue: 'dev',
  ),
  revision: String.fromEnvironment(
    'PRISM_DASHBOARD_REVISION',
    defaultValue: 'unknown',
  ),
);
