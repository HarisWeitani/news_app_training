import 'package:news_app_training/core/resources/data_state.dart';
import 'package:news_app_training/feature/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {

  Future<DataState<List<ArticleEntity>>> getNewsArticle();

}