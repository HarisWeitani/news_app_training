import 'package:news_app_training/core/resources/data_state.dart';
import 'package:news_app_training/feature/daily_news/data/models/article.dart';
import 'package:news_app_training/feature/daily_news/domain/entities/article.dart';
import 'package:news_app_training/feature/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() {

    throw UnimplementedError();
  }

}