import 'package:flutter/material.dart';

import '../../domain/entities/news.dart';
import '../widgets/news_detail_widget.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;
  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text("News Detail"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      );

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: NewsDetailWidget(article: article),
      ),
    );
  }
}
