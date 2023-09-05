import 'dart:io';

import 'package:news_app_training/core/constants/constants.dart';
import 'package:news_app_training/core/resources/data_state.dart';
import 'package:news_app_training/feature/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_training/feature/daily_news/data/models/article.dart';
import 'package:news_app_training/feature/daily_news/domain/entities/article.dart';
import 'package:news_app_training/feature/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

import '../data_sources/local/app_database.dart';

class ArticleRepositoryImpl implements ArticleRepository {

  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: apiKey,
        country: country,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioError(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioErrorType.response,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioError catch(e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticle() async {
    return _appDatabase.articleDao.getArticle();
  }

  @override
  Future<void> removeArticle(ArticleEntity articleEntity) {
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(articleEntity));
  }

  @override
  Future<void> saveArticle(ArticleEntity articleEntity) {
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(articleEntity));
  }
}