import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/src/presentation/widgets/news_tile.dart';

void main() {
  testWidgets('NewsTile displays title and content and responds to like button press', (WidgetTester tester) async {
    // Arrange
    const title = 'Test News Title';
    const content = 'Test News Content';
    bool isLiked = false;
    
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NewsTile(
          title: title,
          content: content,
          isLiked: isLiked,
          onLikePressed: () {
            isLiked = !isLiked;
          },
        ),
      ),
    ));

    // Act & Assert
    expect(find.text(title), findsOneWidget);
    expect(find.text(content), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(isLiked, isTrue);
  });
}