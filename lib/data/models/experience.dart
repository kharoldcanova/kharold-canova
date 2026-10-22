class Experience {
  final String company;
  final String role;
  final String? roleEn;
  final String location;
  final String? locationEn;
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> highlights;
  final List<String>? highlightsEn;

  const Experience({
    required this.company,
    required this.role,
    this.roleEn,
    this.location = '',
    this.locationEn,
    required this.startDate,
    this.endDate,
    this.highlights = const [],
    this.highlightsEn,
  });

  String localizedRole(String languageCode) =>
      languageCode == 'en' ? (roleEn ?? role) : role;

  String localizedLocation(String languageCode) =>
      languageCode == 'en' ? (locationEn ?? location) : location;

  List<String> localizedHighlights(String languageCode) =>
      languageCode == 'en' ? (highlightsEn ?? highlights) : highlights;

  bool get isCurrent => endDate == null;

  double get years =>
      (endDate ?? DateTime.now()).difference(startDate).inDays / 365.25;

  String get formattedDuration {
    final y = years;
    if (y < 1) {
      final months = (y * 12).round();
      return '$months ${months == 1 ? 'month' : 'months'}';
    }
    return '${y.toStringAsFixed(1)} years';
  }

  /// Year range shown in the About timeline. The label for an ongoing role is
  /// supplied by the widget so it stays localized.
  String periodLabel(String presentLabel) {
    final start = startDate.year.toString();
    if (isCurrent) return '$start — $presentLabel';
    final end = endDate!.year.toString();
    return start == end ? start : '$start — $end';
  }

  Map<String, dynamic> toJson() => {
        'company': company,
        'role': role,
        'roleEn': roleEn,
        'location': location,
        'locationEn': locationEn,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'highlights': highlights,
        'highlightsEn': highlightsEn,
      };
}
