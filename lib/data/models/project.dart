import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final List<String> techStack;
  final String category;
  final String? repoUrl;
  final IconData icon;

  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.category,
    this.repoUrl,
    this.icon = Icons.folder_outlined,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'techStack': techStack,
        'category': category,
        'repoUrl': repoUrl,
      };
}
