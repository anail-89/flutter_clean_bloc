import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  int? id;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlTiImage;
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
      this.urlTiImage});

  @override
  List<Object?> get props =>
      [id, author, title, description, url, urlTiImage, publishedAt, content];
}
