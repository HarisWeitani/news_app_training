import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_training/core/resources/data_state.dart';
import 'package:news_app_training/feature/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_training/feature/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app_training/feature/daily_news/domain/usecase/get_article.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {

  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase) : super(const RemoteArticlesLoading()){
    on <GetArticles> (onGetArticles);
  }

  void onGetArticles(GetArticles event, Emitter <RemoteArticleState> emit ) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }

}