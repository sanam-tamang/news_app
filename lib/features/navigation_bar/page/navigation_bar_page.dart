// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/blocs/internet_connection_checker_bloc/internet_connection_checker_bloc.dart';
import 'package:news_app/core/widgets/internet_connection_checker.dart';
import 'package:news_app/features/breaking_news/view/pages/home_page.dart';
import 'package:news_app/features/navigation_bar/bloc/change_navbar_index_cubit/change_navbar_indexer_cubit.dart';
import 'package:news_app/features/profile/view/pages/profile_page.dart';
import 'package:news_app/features/search/view/pages/search_news_page.dart';

class NewsNavigationBar extends StatefulWidget {
  const NewsNavigationBar({super.key});

  @override
  State<NewsNavigationBar> createState() => _NewsNavigationBarState();
}

class _NewsNavigationBarState extends State<NewsNavigationBar>
    with AutomaticKeepAliveClientMixin {
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
    super.build(context);
    return BlocBuilder<ChangeNavbarIndexerCubit, ChangeNavbarIndexerState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return pages[state.index];
                    }),
              ),
              const NewsInternetChecker(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                onDestinationSelected: (index) {
                  context.read<ChangeNavbarIndexerCubit>().changeIndex(index);
                },
                selectedIndex: state.index,
                destinations: const [
                  NavigationDestination(
                      selectedIcon: SelectedNavIcon(icon: Icons.home_filled),
                      icon: Icon(Icons.home_outlined),
                      label: 'home'),
                  NavigationDestination(
                      selectedIcon: SelectedNavIcon(icon: Icons.search),
                      icon: Icon(Icons.search_outlined),
                      label: 'search'),
                  NavigationDestination(
                      selectedIcon: SelectedNavIcon(icon: Icons.person),
                      icon: Icon(Icons.person_outline),
                      label: 'profile'),
                ]),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SelectedNavIcon extends StatelessWidget {
  const SelectedNavIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 1500),
      child: Container(
          height: 30,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 125, 145, 255), Colors.grey])),
          child: Icon(icon)),
    );
  }
}
