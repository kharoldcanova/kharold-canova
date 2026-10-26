import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final String? descriptionEn;
  final List<String> techStack;
  final List<String>? techStackEn;
  final String category;
  final String? categoryEn;
  final String? repoUrl;
  final String? impact;
  final String? impactEn;
  final IconData icon;

  const Project({
    required this.title,
    required this.description,
    this.descriptionEn,
    required this.techStack,
    this.techStackEn,
    required this.category,
    this.categoryEn,
    this.repoUrl,
    this.impact,
    this.impactEn,
    this.icon = Icons.folder_outlined,
  });

  String localizedDescription(String languageCode) =>
      languageCode == 'en' ? (descriptionEn ?? description) : description;

  List<String> localizedTechStack(String languageCode) =>
      languageCode == 'en' ? (techStackEn ?? techStack) : techStack;

  String localizedCategory(String languageCode) =>
      languageCode == 'en' ? (categoryEn ?? category) : category;

  String? localizedImpact(String languageCode) =>
      languageCode == 'en' ? (impactEn ?? impact) : impact;

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'descriptionEn': descriptionEn,
        'techStack': techStack,
        'techStackEn': techStackEn,
        'category': category,
        'categoryEn': categoryEn,
        'repoUrl': repoUrl,
        'impact': impact,
        'impactEn': impactEn,
      };
}
