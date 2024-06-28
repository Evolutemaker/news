import 'package:news/src/data/models/news_model.dart';

class News {
  final String title;
  final String content;

  News({required this.title, required this.content});

  factory News.fromModel(NewsModel model) {
    return News(
      title: model.title,
      content: model.abstract,
    );
  }

  NewsModel toModel() {
    return NewsModel(
      title: title,
      abstract: content,
    );
  }
}