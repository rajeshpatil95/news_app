import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/strings/failures.dart';
import '../../domain/entities/news.dart';
import '../../domain/usecases/news_usecases.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsUsecase getNews;

  NewsBloc({required this.getNews}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is GetNewsEvent) {
        emit(LoadingNewsState());
        final failureOrNews = await getNews();
        emit(mapFailureOrNewsToState(failureOrNews));
      } else if (event is RefreshNewsEvent) {
        emit(LoadingNewsState());
        final failureOrNews = await getNews();
        emit(mapFailureOrNewsToState(failureOrNews));
      }
    });
  }
}

NewsState mapFailureOrNewsToState(Either<Failure, News> either) {
  return either.fold(
    (failure) => mapFailureToState(failure),
    (news) => LoadedNewsState(news: news),
  );
}

NewsState mapFailureToState(Failure failure) {
  if (failure is ServerFailure) {
    return const ErrorNewsState(message: serverFailureMessage);
  } else if (failure is EmptyCacheFailure) {
    return const ErrorNewsState(message: emptyCacheFailureMessage);
  } else if (failure is OfflineFailure) {
    return const ErrorNewsState(message: offlineFailureMessage);
  } else {
    return const ErrorNewsState(
        message: 'Unexpected Error, Please try again later.');
  }
}
