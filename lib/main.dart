import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/config/routes.dart';
import 'package:news_app/core/repositories/news_repository.dart';
import 'package:news_app/features/navigation_bar/page/navigation_bar_page.dart';

import 'core/blocs/get_news_bloc/get_news_bloc.dart';
import 'core/blocs/internet_connection_checker_bloc/internet_connection_checker_bloc.dart';
import 'core/config/theme.dart';
import 'package:http/http.dart' as http;

import 'features/navigation_bar/bloc/change_navbar_index_cubit/change_navbar_indexer_cubit.dart';
import 'features/search/blocs/search_news_bloc/get_search_news_bloc.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NewsRepository(client: http.Client()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetNewsBloc(
                repository: RepositoryProvider.of<NewsRepository>(context)),
          ),
          BlocProvider(
            create: (context) => GetSearchNewsBloc(
                repository: RepositoryProvider.of<NewsRepository>(context)),
          ),
          BlocProvider(
              create: (context) =>
                  InternetConnectionCheckerBloc(internet: InternetConnectionCheckerPlus())
                   ),
          BlocProvider(create: (context) => ChangeNavbarIndexerCubit())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News app',
          theme: NewsTheme.lightMode(),
          onGenerateRoute: NewsRoute.onGenerateRoute,
          home: const NewsNavigationBar(),
        ),
      ),
    );
  }
}
