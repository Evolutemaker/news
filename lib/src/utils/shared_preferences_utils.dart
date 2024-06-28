import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news/src/domain/entities/news.dart';
import 'package:news/src/data/models/news_model.dart';

class SharedPreferencesUtils {
  static const _likedNewsKey = 'liked_news';
  static const _likedNewsDetailsKey = 'liked_news_details';

  Future<Set<String>> getLikedNewsIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_likedNewsKey)?.toSet() ?? <String>{};
  }

  Future<void> saveLikedNewsIds(Set<String> likedNewsIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_likedNewsKey, likedNewsIds.toList());
  }

  Future<void> saveLikedNewsDetails(List<News> likedNews) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likedNewsJsonList = likedNews.map((news) => jsonEncode(news.toModel().toJson())).toList();
    await prefs.setStringList(_likedNewsDetailsKey, likedNewsJsonList);
  }

  Future<List<News>> getLikedNewsDetails() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likedNewsJsonList = prefs.getStringList(_likedNewsDetailsKey) ?? [];
    return likedNewsJsonList.map((newsJson) => News.fromModel(NewsModel.fromJson(jsonDecode(newsJson)))).toList();
  }
}