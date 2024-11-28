import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/core/strings/failures.dart';
import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/usecases/news_usecases.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';

class MockNewsUsecase extends Mock implements NewsUsecase {}

void main() {
  late NewsBloc newsBloc;

  setUp(() {
    newsBloc = NewsBloc(getNews: MockNewsUsecase());
  });

  tearDown(() {
    newsBloc.close();
  });

  group('mapFailureOrNewsToState', () {
    test('should return ErrorNewsState when failure is provided', () {
      // Arrange
      final failure = ServerFailure();

      // Act
      final result = mapFailureOrNewsToState(Left(failure));

      // Assert
      expect(result, isA<ErrorNewsState>());
      expect((result as ErrorNewsState).message, SERVER_FAILURE_MESSAGE);
    });

    test('should return LoadedNewsState when news data is provided', () {
      // Arrange
      const testNews = News(status: "Ok", totalResults: 30, articles: []);

      // Act
      final result = mapFailureOrNewsToState(Right(testNews));

      // Assert
      expect(result, isA<LoadedNewsState>());
      expect((result as LoadedNewsState).news, testNews);
    });

    test('initial state is NewsInitial', () {
      // Assert
      expect(newsBloc.state, equals(NewsInitial()));
    });
  });
}
