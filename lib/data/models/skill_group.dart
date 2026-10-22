class SkillGroup {
  final String id;
  final List<String> technologies;

  const SkillGroup({
    required this.id,
    required this.technologies,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'technologies': technologies,
      };
}
