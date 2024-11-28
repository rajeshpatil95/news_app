import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/news_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource {
  Future<NewsModel> getNews();
}

const baseUrl = "https://newsapi.org";

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<NewsModel> getNews() async {
    final response = await client.get(
      Uri.parse(
          "$baseUrl/v2/everything?q=bitcoin&apiKey=17d51eb402204967b27dabb543a51a76"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson =
          json.decode(response.body) as Map<String, dynamic>;
      final NewsModel newsModel = NewsModel.fromJson(decodedJson);

      return newsModel;
    } else {
      throw ServerException();
    }
  }
}
