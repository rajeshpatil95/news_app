part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class LoadingNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  final News news;

  const LoadedNewsState({required this.news});

  @override
  List<Object> get props => [news];
}

class ErrorNewsState extends NewsState {
  final String message;

  const ErrorNewsState({required this.message});

  @override
  List<Object> get props => [message];
}
