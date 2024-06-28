import 'package:news/src/domain/entities/news.dart';

abstract class NewsRepository {
  Future<List<News>> getNews();
}