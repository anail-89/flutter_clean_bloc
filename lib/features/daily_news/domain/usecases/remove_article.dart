import 'package:flutter_clean_bloc/core/resources/data_state.dart';
import 'package:flutter_clean_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_bloc/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/repository/article_repository.dart';

class RemoveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  RemoveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.removeArticle(params!);
  }
}
