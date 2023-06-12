import 'package:flutter/material.dart';
import 'package:news_app/features/breaking_news/view/pages/home_page.dart';
import 'package:news_app/features/profile/view/pages/profile_page.dart';
import 'package:news_app/features/search/view/pages/search_news_page.dart';

class NewsNavigationBar extends StatefulWidget {
  const NewsNavigationBar({super.key});

  @override
  State<NewsNavigationBar> createState() => _NewsNavigationBarState();
}

class _NewsNavigationBarState extends State<NewsNavigationBar> {
  late List<Widget> pages;
  @override
  void initState() {
    pages = const [
      HomePage(),
      SearchNewsPage(),
      ProfilePage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[0],
      bottomNavigationBar: BottomAppBar(
        child: NavigationBar(selectedIndex: 0, destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'home'),
          NavigationDestination(
              icon: Icon(Icons.search_outlined), label: 'search'),
          NavigationDestination(
              icon: Icon(Icons.person_outline), label: 'profile'),
        ]),
      ),
    );
  }
}
