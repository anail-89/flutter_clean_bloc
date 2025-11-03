import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_clean_bloc/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_clean_bloc/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
        title: const Text(
      'Daily News',
      style: TextStyle(color: Colors.black),
    ));
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
        builder: (_, state) {
      if (state is RemoteArticlesLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is RemoteArticlesError) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load articles',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pull down to refresh',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        );
      }
      if (state is RemoteArticlesDone) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final article = state.articles![index];
            return ArticleTile(
              article: article,
              onArticlePressed: () {
                // TODO: Navigate to article detail page
              },
            );
          },
          itemCount: state.articles!.length,
        );
      }
      return const SizedBox();
    });
  }
}
