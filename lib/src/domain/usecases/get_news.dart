import 'package:news/src/domain/entities/news.dart';
import 'package:news/src/domain/repositories/news_repository.dart';

class GetNews {
  final NewsRepository repository;

  GetNews(this.repository);

  Future<List<News>> call() async {
    return await repository.getNews();
  }
}