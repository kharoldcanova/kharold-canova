class PublishedSkill {
  const PublishedSkill({
    required this.name,
    required this.description,
    required this.url,
    this.installCommand,
  });

  final String name;
  final String description;
  final String url;
  final String? installCommand;
}
