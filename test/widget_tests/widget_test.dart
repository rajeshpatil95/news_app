import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/utils/transition.dart';
import 'package:news_app/features/news/presentation/widgets/news_list_widget.dart';
import 'package:news_app/features/news/domain/entities/news.dart';

void main() {
  testWidgets('renders a list of news articles', (WidgetTester tester) async {
    // Sample test data
    const testNews = News(
      status: "ok",
      totalResults: 2,
      articles: [
        Article(
          source: Source(name: ''),
          url: "",
          title: "Article 1",
          description: "Description 1",
          urlToImage: "https://via.placeholder.com/150",
        ),
        Article(
          source: Source(name: ''),
          url: "",
          title: "Article 2",
          description: "Description 2",
          urlToImage: "https://via.placeholder.com/150",
        ),
      ],
    );

    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NewsListWidget(
              news: testNews, transitionType: TransitionType.fade),
        ),
      ),
    );

    // Check if articles are displayed
    expect(find.text("Article 1"), findsOneWidget);
    expect(find.text("Description 1"), findsOneWidget);
    expect(find.text("Article 2"), findsOneWidget);
    expect(find.text("Description 2"), findsOneWidget);
  });
}
