class Experience {
  final String company;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;

  const Experience({
    required this.company,
    required this.role,
    required this.startDate,
    this.endDate,
  });

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

  Map<String, dynamic> toJson() => {
        'company': company,
        'role': role,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
      };
}
