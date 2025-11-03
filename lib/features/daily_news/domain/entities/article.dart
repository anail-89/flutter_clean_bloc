import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class ArticleEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  ArticleEntity(
      {this.title,
      this.content,
      this.author,
      this.id,
      this.description,
      this.publishedAt,
      this.url,
      this.urlToImage});

  @override
  List<Object?> get props =>
      [id, author, title, description, url, urlToImage, publishedAt, content];
}
