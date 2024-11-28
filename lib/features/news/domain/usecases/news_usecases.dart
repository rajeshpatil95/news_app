import '../repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/news.dart';

class NewsUsecase {
  final NewsRepository repository;

  NewsUsecase(this.repository);

  Future<Either<Failure, News>> call() async {
    return await repository.getNews();
  }
}
