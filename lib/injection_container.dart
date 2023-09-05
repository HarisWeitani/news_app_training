import 'package:get_it/get_it.dart';
import 'package:news_app_training/feature/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app_training/feature/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:dio/dio.dart';
import 'package:news_app_training/feature/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app_training/feature/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_training/feature/daily_news/domain/usecase/delete_article.dart';
import 'package:news_app_training/feature/daily_news/domain/usecase/get_article.dart';
import 'package:news_app_training/feature/daily_news/domain/usecase/get_saved_article.dart';
import 'package:news_app_training/feature/daily_news/domain/usecase/save_article.dart';
import 'package:news_app_training/feature/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app_training/feature/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  sl.registerSingleton<AppDatabase>(database);
  
  //Dio
  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  //Repository
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(),sl()));

  //UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));
  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  //BloC
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
  sl.registerFactory<LocalArticleBloc>(() => LocalArticleBloc(sl(), sl(), sl()));
}
