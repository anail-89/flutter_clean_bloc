import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc/core/resources/data_state.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/usecases/save_article.dart';
import 'package:flutter_clean_bloc/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_clean_bloc/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;

  RemoteArticlesBloc(
    this._getArticleUseCase,
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
  ) : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Save all articles to local DB
      for (final article in dataState.data!) {
        try {
          await _saveArticleUseCase(params: article);
        } catch (e) {
          // Continue saving other articles even if one fails
          print('Error saving article: $e');
        }
      }

      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.error);

      // Try to load from local DB as fallback
      try {
        final savedArticles = await _getSavedArticleUseCase();
        if (savedArticles.isNotEmpty) {
          emit(RemoteArticlesDone(savedArticles));
        } else {
          emit(RemoteArticlesError(dataState.error!));
        }
      } catch (e) {
        print('Error loading saved articles: $e');
        emit(RemoteArticlesError(dataState.error!));
      }
    }
  }
}
