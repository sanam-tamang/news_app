import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/features/breaking_news/view/pages/home_page.dart';
import 'package:news_app/features/navigation_bar/bloc/change_navbar_index_cubit/change_navbar_indexer_cubit.dart';
import 'package:news_app/features/profile/view/pages/profile_page.dart';
import 'package:news_app/features/search/view/pages/search_news_page.dart';

class NewsNavigationBar extends StatefulWidget {
  const NewsNavigationBar({super.key});

  @override
  State<NewsNavigationBar> createState() => _NewsNavigationBarState();
}

class _NewsNavigationBarState extends State<NewsNavigationBar> {
  late List<Widget> pages;
  late PageController controller;
  @override
  void initState() {
    pages = const [
      HomePage(),
      SearchNewsPage(),
      ProfilePage(),
    ];

    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeNavbarIndexerCubit, ChangeNavbarIndexerState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[state.index];
              }),
          bottomNavigationBar: BottomAppBar(
            child: NavigationBar(
                onDestinationSelected: (index) {
                  context.read<ChangeNavbarIndexerCubit>().changeIndex(index);
                },
                selectedIndex: state.index,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.home_outlined), label: 'home'),
                  NavigationDestination(
                      icon: Icon(Icons.search_outlined), label: 'search'),
                  NavigationDestination(
                      icon: Icon(Icons.person_outline), label: 'profile'),
                ]),
          ),
        );
      },
    );
  }
}
