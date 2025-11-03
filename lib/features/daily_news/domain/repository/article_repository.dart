import 'package:flutter_clean_bloc/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_bloc/core/resources/data_state.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
