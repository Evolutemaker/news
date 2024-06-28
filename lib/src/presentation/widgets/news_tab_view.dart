import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/src/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:news/src/presentation/bloc/news_bloc/news_event.dart';
import 'package:news/src/presentation/bloc/news_bloc/news_state.dart';
import 'news_tile.dart';

class NewsTabView extends StatelessWidget {
  final bool showLikedOnly;

  const NewsTabView({super.key, required this.showLikedOnly});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsBloc>().add(const NewsEvent.fetchNews());
      },
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is LoadingNewsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedNewsState) {

            final newsList = showLikedOnly
                ? state.listOfNews
                    .where((news) => state.likedNewsIds.contains(news.title))
                    .toList()
                : state.listOfNews;

            if (newsList.isEmpty) {
              return const Center(child: Text('No liked news yet.'));
            }
            return ListView.builder(
              itemCount: newsList.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final news = newsList[index];
                final isLiked = state.likedNewsIds.contains(news.title);
                return NewsTile(
                  title: news.title,
                  content: news.content,
                  isLiked: isLiked,
                  onLikePressed: () {
                    context.read<NewsBloc>().add(NewsEvent.likeNews(news.title));
                  },
                );
              },
            );
          } else if (state is ErrorNewsState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const Center(child: Text('No news available.'));
        },
      ),
    );
  }
}