import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:news/src/data/models/news_model.dart';

class NewsRemoteDataSource {
  static const String _baseUrl = 'https://api.nytimes.com';
  static const String _apiKey = '7LhA5I4ob9uuA0LO3bJuudvkKQ7opvoG';
  static const String _topStoriesPath = '/svc/topstories/v2/sports.json';

  final Dio dio;
  final Logger logger;

  NewsRemoteDataSource(this.dio, this.logger);

  Future<List<NewsModel>> fetchNews() async {
    try {
      final response = await dio.get('$_baseUrl$_topStoriesPath', queryParameters: {'api-key': _apiKey});

      if (response.statusCode == 200) {
        return _parseNewsList(response.data);
      } else {
        logger.e('Failed to load news: ${response.statusCode}');
        throw Exception('Failed to load news');
      }
    } catch (e) {
      logger.e('Failed to load news: $e');
      throw Exception('Failed to load news');
    }
  }

  List<NewsModel> _parseNewsList(dynamic responseBody) {
    final List<dynamic> decodedJson = responseBody['results'];
    return decodedJson.map((json) => NewsModel.fromJson(json)).toList();
  }
}