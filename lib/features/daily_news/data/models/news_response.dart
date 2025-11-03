import 'package:flutter_clean_bloc/features/daily_news/data/models/article.dart';

class NewsResponse {
  final List<ArticleModel> news;
  final int count;
  final int next;
  final bool eof;

  NewsResponse({
    required this.news,
    required this.count,
    required this.next,
    required this.eof,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      news: (json['news'] as List<dynamic>)
          .map((article) => ArticleModel.fromJson(article as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int,
      next: json['next'] as int,
      eof: json['eof'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'news': news.map((article) => article.toJson()).toList(),
      'count': count,
      'next': next,
      'eof': eof,
    };
  }
}