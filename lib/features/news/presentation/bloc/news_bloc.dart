import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

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
  return either
      .fold((failure) => ErrorNewsState(message: mapFailureToMessage(failure)),
          (news) {
    return LoadedNewsState(news: news);
  });
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case EmptyCacheFailure:
      return EMPTY_CACHE_FAILURE_MESSAGE;
    case OfflineFailure:
      return OFFLINE_FAILURE_MESSAGE;
    default:
      return "Unexpected Error, Please try again later.";
  }
}
