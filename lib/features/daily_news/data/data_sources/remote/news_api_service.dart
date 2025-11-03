import 'package:dio/dio.dart';
import 'package:flutter_clean_bloc/features/daily_news/data/models/article.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
part 'news_api_service.g.dart';
@RestApi(baseUrl: newsAPiBaseURL)
abstract class NewsAPiService {
  factory NewsAPiService(Dio dio) = _NewsAPiService;

  @GET('/sport')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles(
      {@Query('since') String? since, @Query(
          'count') String? count});

}
