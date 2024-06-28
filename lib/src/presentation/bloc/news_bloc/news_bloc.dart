import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/src/domain/entities/news.dart';
import 'package:news/src/domain/usecases/get_news.dart';
import 'package:news/src/utils/shared_preferences_utils.dart';

import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNews;
  final SharedPreferencesUtils sharedPreferencesUtils;

  NewsBloc({required this.getNews, required this.sharedPreferencesUtils})
      : super(const NewsState.loading()) {
    on<FetchNews>((event, emit) async {
      emit(const NewsState.loading());

      try {
        final news = await getNews();
        final likedNewsIds = await sharedPreferencesUtils.getLikedNewsIds();

        await sharedPreferencesUtils.saveLikedNewsDetails(news);
        emit(NewsState.loaded(listOfNews: news, likedNewsIds: likedNewsIds));
      } catch (e) {
        log(e.toString());

        final likedNewsIds = await sharedPreferencesUtils.getLikedNewsIds();
        if (likedNewsIds.isNotEmpty) {
          final likedNews = await _getLikedNewsDetails(likedNewsIds);
          emit(NewsState.loaded(
              listOfNews: likedNews, likedNewsIds: likedNewsIds));
        } else {
          emit(NewsState.error(errorMessage: e.toString()));
        }
      }
    });

    on<LikeNews>((event, emit) async {
      final currentState = state;
      if (currentState is LoadedNewsState) {
        final updatedLikedNewsIds = Set<String>.from(currentState.likedNewsIds);
        if (updatedLikedNewsIds.contains(event.newsId)) {
          updatedLikedNewsIds.remove(event.newsId);
        } else {
          updatedLikedNewsIds.add(event.newsId);
        }
        await sharedPreferencesUtils.saveLikedNewsIds(updatedLikedNewsIds);

        final likedNews = currentState.listOfNews.where((news) => updatedLikedNewsIds.contains(news.title)).toList();
        await sharedPreferencesUtils.saveLikedNewsDetails(likedNews);

        emit(currentState.copyWith(likedNewsIds: updatedLikedNewsIds));
      }
    });
  }

  Future<List<News>> _getLikedNewsDetails(Set<String> likedNewsIds) async {
    final allLikedNews = await sharedPreferencesUtils.getLikedNewsDetails();
    return allLikedNews
        .where((news) => likedNewsIds.contains(news.title))
        .toList();
  }
}