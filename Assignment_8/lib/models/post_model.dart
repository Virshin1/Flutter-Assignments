import 'tech_insights_catalog.dart';

class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  String get capitalizedTitle {
    if (title.isEmpty) return '';
    return title[0].toUpperCase() + title.substring(1);
  }

  /// Flag indicating if the raw REST API data contains Latin placeholder strings
  bool get isLatinContent =>
      TechInsightsCatalog.isLatinText(title) ||
      TechInsightsCatalog.isLatinText(body);

  /// Returns readable engineering publication title if original is mock Latin
  String get readableTitle =>
      isLatinContent ? TechInsightsCatalog.getCuratedTitle(id) : capitalizedTitle;

  /// Returns readable engineering publication summary if original is mock Latin
  String get readableBody =>
      isLatinContent ? TechInsightsCatalog.getCuratedBody(id) : body;

  String get readingTime {
    final wordCount = readableBody.split(RegExp(r'\s+')).length;
    final minutes = (wordCount / 40).ceil();
    return '$minutes min read';
  }

  String get category {
    const categories = [
      'Cloud Architecture',
      'Cybersecurity',
      'Developer Tooling',
      'AI & Machine Learning',
      'Systems Engineering',
      'Mobile Infrastructure',
      'Database Scaling',
      'DevOps & CI/CD',
      'Web Performance',
      'Identity & Auth',
    ];
    if (isLatinContent) {
      final index = (id - 1) % categories.length;
      return categories[index >= 0 ? index : 0];
    }
    final index = (userId - 1) % categories.length;
    return categories[index >= 0 ? index : 0];
  }
}
