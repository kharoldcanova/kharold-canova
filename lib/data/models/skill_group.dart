/// One "Competencias clave" group from the CV (DESIGN.md 3.5).
///
/// The visible group label comes from l10n (`skill_group_<id>`).
class SkillGroup {
  final String id;
  final List<String> technologies;
  final List<String>? technologiesEn;

  const SkillGroup({
    required this.id,
    required this.technologies,
    this.technologiesEn,
  });

  List<String> localizedTechnologies(String languageCode) =>
      languageCode == 'en' ? (technologiesEn ?? technologies) : technologies;

  Map<String, dynamic> toJson() => {
        'id': id,
        'technologies': technologies,
        'technologiesEn': technologiesEn,
      };
}
