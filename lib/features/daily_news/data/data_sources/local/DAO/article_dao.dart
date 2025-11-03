import '../../../models/article.dart';
import 'package:floor/floor.dart';

@dao
abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel articleModel);

  @Query('SELECT * FROM articles')
  Future<List<ArticleModel>> getArticles();
}
