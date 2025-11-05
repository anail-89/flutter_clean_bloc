import 'package:equatable/equatable.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/entities/article.dart';

abstract class LocalArticlesState extends Equatable {
  final List<ArticleEntity>? articles;

  const LocalArticlesState({this.articles});

  @override
  List<Object?> get props => [articles!];
}
class LocalStateLoading extends LocalArticlesState{
  const LocalStateLoading();
}
class LocalArticlesDone extends LocalArticlesState{
  const LocalArticlesDone(List<ArticleEntity>? articles):super(articles: articles);
}