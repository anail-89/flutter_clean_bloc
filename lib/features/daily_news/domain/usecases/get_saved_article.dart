import 'package:flutter_clean_bloc/core/resources/data_state.dart';
import 'package:flutter_clean_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_bloc/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticleUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}

