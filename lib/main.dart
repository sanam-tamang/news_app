import 'package:flutter/material.dart';
import 'package:news_app/core/config/routes.dart';
import 'package:news_app/features/navigation_bar/page/navigation_bar_page.dart';

import 'core/config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: NewsTheme.lightMode(),
      onGenerateRoute: NewsRoute.onGenerateRoute,
      home: const NewsNavigationBar(),
    );
  }
}
