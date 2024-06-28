import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news/src/domain/entities/news.dart';

part 'news_state.freezed.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState.loading() = LoadingNewsState;
  const factory NewsState.loaded({
    required List<News> listOfNews,
    required Set<String> likedNewsIds,
  }) = LoadedNewsState;
  const factory NewsState.error({required String errorMessage}) = ErrorNewsState;
}