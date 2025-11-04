import 'package:floor/floor.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/entities/article.dart';

@Entity(tableName: 'articles')
class ArticleModel extends ArticleEntity {
  ArticleModel({
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) : super(
          id: id,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
        id: map['id'] as int?,
        author: map['author'] ?? '',
        title: map['headline'] ?? '',
        description: map['abstract'] ?? '',
        url: map['article_uri'] ?? '',
        urlToImage: map['pdf_uri'] ?? '',
        publishedAt: map['date'] ?? '',
        content: map['body'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'headline': title,
      'abstract': description,
      'article_uri': url,
      'pdf_uri': urlToImage,
      'date': publishedAt,
      'body': content,
    };
  }
  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
        id: entity.id,
        author: entity.author,
        title: entity.title,
        description: entity.description,
        url: entity.url,
        urlToImage: entity.urlToImage,
        publishedAt: entity.publishedAt,
        content: entity.content);
  }
}
