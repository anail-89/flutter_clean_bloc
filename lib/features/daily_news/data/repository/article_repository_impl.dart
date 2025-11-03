import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_bloc/core/resources/data_state.dart';
import 'package:flutter_clean_bloc/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_bloc/features/daily_news/data/models/article.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/repository/article_repository.dart';

import '../../../../core/constants/constants.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsAPiService _newsAPiService;

  ArticleRepositoryImpl(this._newsAPiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsAPiService.getNewsArticles(
          since: sinceQuery, count: countQuery);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.news);
      } else {
        return DataFailed(DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
