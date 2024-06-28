import 'package:news/src/data/datasources/news_remote_data_source.dart';
import 'package:news/src/domain/entities/news.dart';
import 'package:news/src/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<News>> getNews() async {
    final newsModels = await remoteDataSource.fetchNews();
    return newsModels.map((newsModel) => News(
      title: newsModel.title,
      content: newsModel.abstract,
    )).toList();
  }
}