import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news/src/domain/usecases/get_news.dart';
import 'package:news/src/domain/repositories/news_repository.dart';
import 'package:news/src/domain/entities/news.dart';

class MockNewsRepository extends Mock implements NewsRepository {
  @override
  Future<List<News>> getNews() {
    return super.noSuchMethod(
      Invocation.method(#getNews, []),
      returnValue: Future.value(<News>[]),
      returnValueForMissingStub: Future.value(<News>[]),
    ) as Future<List<News>>;
  }
}

void main() {
  late GetNews usecase;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    usecase = GetNews(mockNewsRepository);
  });

  final newsList = [
    News(title: 'Test News Title', content: 'Test News Content')
  ];

  test('should get list of news from the repository', () async {
    // Arrange
    when(mockNewsRepository.getNews()).thenAnswer((_) async => newsList);

    // Act
    final result = await usecase.call();

    // Assert
    expect(result, newsList);
    verify(mockNewsRepository.getNews()).called(1);
    verifyNoMoreInteractions(mockNewsRepository);
  });
}