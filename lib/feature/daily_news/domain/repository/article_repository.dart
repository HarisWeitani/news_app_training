import 'package:news_app_training/core/resources/data_state.dart';
import 'package:news_app_training/feature/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {

  //Remote
  Future<DataState<List<ArticleEntity>>> getNewsArticle();

  //Local
  Future<void> saveArticle(ArticleEntity articleEntity);
  Future<void> removeArticle(ArticleEntity articleEntity);

  Future<List<ArticleEntity>> getSavedArticle();

}