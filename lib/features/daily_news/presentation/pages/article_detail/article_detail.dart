import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_bloc/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_clean_bloc/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_clean_bloc/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:intl/intl.dart';

class ArticleDetailPage extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailPage({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Load saved articles when page opens
    context.read<LocalArticleBloc>().add(const GetSavedArticles());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: BlocBuilder<LocalArticleBloc, LocalArticlesState>(
        builder: (context, state) {
          // Check if current article is saved by comparing with state
          final bool isSaved = state is LocalArticlesDone
              ? (state.articles?.any((savedArticle) =>
                    savedArticle.title == article.title &&
                    savedArticle.url == article.url) ??
                  false)
              : false;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Article Image
                if (article.urlToImage != null)
                  CachedNetworkImage(
                    imageUrl: article.urlToImage!,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        article.title ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Author and Date
                      Row(
                        children: [
                          if (article.author != null) ...[
                            const Icon(Icons.person, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                article.author!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (article.publishedAt != null) ...[
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('MMM dd, yyyy - HH:mm').format(
                                DateTime.parse(article.publishedAt!),
                              ),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 20),

                      // Description
                      if (article.description != null) ...[
                        Text(
                          article.description!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Content
                      if (article.content != null) ...[
                        const Text(
                          'Full Story',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          article.content!,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      // Source URL
                      if (article.url != null) ...[
                        const Divider(),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.link, size: 18, color: Colors.blue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                article.url!,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 32),

                      // Save/Remove Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: isSaved
                                  ? null
                                  : () => _saveArticle(context, article),
                              icon: const Icon(Icons.bookmark_add),
                              label: Text(isSaved ? 'Saved' : 'Save Article'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: isSaved ? Colors.grey : Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: isSaved
                                  ? () => _removeArticle(context, article)
                                  : null,
                              icon: const Icon(Icons.bookmark_remove),
                              label: const Text('Remove'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: isSaved ? Colors.red : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _saveArticle(BuildContext context, ArticleEntity article) {
    context.read<LocalArticleBloc>().add(SaveArticle(article));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Article saved to local storage')),
    );
  }

  void _removeArticle(BuildContext context, ArticleEntity article) {
    context.read<LocalArticleBloc>().add(RemoveArticle(article));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Article removed from local storage')),
    );
  }
}