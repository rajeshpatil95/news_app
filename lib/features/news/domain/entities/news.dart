import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String status;
  final int totalResults;
  final List<Article> articles;

  const News({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  @override
  List<Object?> get props => [status, totalResults, articles];
}

class Article extends Equatable {
  final Source source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const Article({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content
      ];
}

class Source extends Equatable {
  final String? id;
  final String name;

  const Source({
    this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
