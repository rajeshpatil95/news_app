import 'package:flutter/material.dart';

import '../../domain/entities/news.dart';

class NewsDetailWidget extends StatelessWidget {
  final Article article;

  const NewsDetailWidget({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      panEnabled: true, // Enable panning
      minScale: 0.5, // Minimum zoom scale
      maxScale: 4.0, // Maximum zoom scale
      child: Center(
        child: Image.network(
          "${article.urlToImage}",
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.error,
            size: 50,
            color: Colors.red,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
