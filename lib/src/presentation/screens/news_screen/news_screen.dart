import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/src/di.dart';
import 'package:news/src/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:news/src/presentation/bloc/news_bloc/news_event.dart';
import 'package:news/src/presentation/widgets/news_tab_view.dart';

@RoutePage()
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late NewsBloc _newsBloc;

  @override
  void initState() {
    super.initState();
    _newsBloc = getIt<NewsBloc>()..add(const NewsEvent.fetchNews());
  }

  @override
  void dispose() {
    _newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News Feed'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All news'),
              Tab(text: 'Liked'),
            ],
          ),
        ),
        body: BlocProvider(
          create: (_) => _newsBloc,
          child: const TabBarView(
            children: [
              NewsTabView(showLikedOnly: false),
              NewsTabView(showLikedOnly: true),
            ],
          ),
        ),
      ),
    );
  }
}