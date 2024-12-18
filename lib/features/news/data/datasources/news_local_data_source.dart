import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/news_model.dart';

abstract class NewsLocalDataSource {
  Future<NewsModel> getCachedNews();
  Future<Unit> cacheNews(NewsModel newsModel);
}

const cachedNews = "cachedNews";

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final SharedPreferences sharedPreferences;

  NewsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheNews(NewsModel newsModel) {
    final newsModelToJson = newsModel.toJson();
    sharedPreferences.setString(cachedNews, json.encode(newsModelToJson));
    return Future.value(unit);
  }

  @override
  Future<NewsModel> getCachedNews() {
    final jsonString = sharedPreferences.getString(cachedNews);
    if (jsonString != null) {
      final Map<String, dynamic> decodedJson =
          json.decode(jsonString) as Map<String, dynamic>;
      final NewsModel newsModel = NewsModel.fromJson(decodedJson);
      return Future.value(newsModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
