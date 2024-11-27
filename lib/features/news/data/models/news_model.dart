import '../../domain/entities/news.dart';

class NewsModel extends News {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  const NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  }) : super(
          status: status,
          totalResults: totalResults,
          articles: articles,
        );

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'] ?? '',
      totalResults: json['totalResults'] ?? 0,
      articles: (json['articles'] as List<dynamic>?)
              ?.map((article) => ArticleModel.fromJson(article))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }
}

class ArticleModel extends Article {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final SourceModel source;

  const ArticleModel({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  }) : super(
          source: source,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      source: SourceModel.fromJson(json['source'] ?? {}),
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}

class SourceModel extends Source {
  final String? id;
  final String name;

  const SourceModel({
    this.id,
    required this.name,
  }) : super(
          id: id,
          name: name,
        );

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}