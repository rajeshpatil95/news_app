import '../entities/news.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class NewsRepository {
  Future<Either<Failure, News>> getNews();
}
