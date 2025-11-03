import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/entities/article.dart';

class ArticleTile extends StatelessWidget {
  final ArticleEntity article;
  final VoidCallback? onArticlePressed;

  const ArticleTile({
    super.key,
    required this.article,
    this.onArticlePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onArticlePressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    // if (article.urlTiImage == null || article.urlTiImage!.isEmpty) {
    //   return Container(
    //     height: 200,
    //     decoration: const BoxDecoration(
    //       color: Colors.grey,
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    //     ),
    //     child: const Center(
    //       child: Icon(
    //         Icons.image_not_supported,
    //         size: 50,
    //         color: Colors.white54,
    //       ),
    //     ),
    //   );
    // }

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: CachedNetworkImage(
        imageUrl: article.urlTiImage!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 200,
          color: Colors.grey[200],
          child: const Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: 200,
          color: Colors.grey[200],
          child: const Center(
            child: Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.title != null && article.title!.isNotEmpty)
            Text(
              article.title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          if (article.title != null && article.title!.isNotEmpty)
            const SizedBox(height: 8),
          if (article.description != null && article.description!.isNotEmpty)
            Text(
              article.description!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (article.author != null && article.author!.isNotEmpty)
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          article.author!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              if (article.publishedAt != null && article.publishedAt!.isNotEmpty)
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(article.publishedAt!),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          return '${difference.inMinutes}m ago';
        }
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return dateStr;
    }
  }
}