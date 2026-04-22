class SystemStatus {
  final String title;
  final SystemStatusType type;
  final String subtitle;

  SystemStatus({
    required this.title,
    required this.type,
    required this.subtitle,
  });
}

enum SystemStatusType { health, warning, error }
