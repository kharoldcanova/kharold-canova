class Skill {
  final String name;
  final String category;
  final double level;

  const Skill({
    required this.name,
    required this.category,
    required this.level,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'level': level,
      };
}
