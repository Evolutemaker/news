import 'package:flutter_test/flutter_test.dart';
import 'package:news/src/domain/entities/news.dart';
import 'package:news/src/utils/shared_preferences_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});

  group('SharedPreferencesUtils', () {
    final utils = SharedPreferencesUtils();

    test('should save and retrieve liked news ids', () async {
      final likedNewsIds = {'news1', 'news2'};
      await utils.saveLikedNewsIds(likedNewsIds);

      final result = await utils.getLikedNewsIds();
      expect(result, likedNewsIds);
    });

    test('should save and retrieve liked news details', () async {
      final likedNews = [
        News(title: 'Test News Title', content: 'Test News Content'),
      ];
      await utils.saveLikedNewsDetails(likedNews);

      final result = await utils.getLikedNewsDetails();

      expect(result.length, likedNews.length);
      expect(result[0].title, likedNews[0].title);
      expect(result[0].content, likedNews[0].content);
    });
  });
}
