// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/blocs/get_news_bloc/get_news_bloc.dart';

import 'package:news_app/core/config/constants.dart';
import 'package:news_app/core/config/pallet.dart';
import 'package:news_app/core/widgets/news_loading_progress_indicator.dart';

import '../../../../core/widgets/build_failure_widget.dart';

import '../widget.dart/search_box_widget.dart';
import '../widget.dart/show_news_widget.dart';
import 'individual_search_page.dart';

class SearchNewsPage extends StatefulWidget {
  const SearchNewsPage({super.key});

  @override
  State<SearchNewsPage> createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final List<String> tabs = [
    "Latest",
    "Nepal",
    "Business",
    "Technology",
    "Entertainment",
  ];

  late TabController controller;
  @override
  void initState() {
    controller = TabController(length: tabs.length, vsync: this);
    context.read<GetNewsBloc>().add(GetNewsListEvent(newsType: tabs[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          controller: ScrollController(),
          headerSliverBuilder: (context, innerBoxIsScrollable) {
            return [
              SliverAppBar(
                expandedHeight: 220,
                collapsedHeight: 160,
                toolbarHeight: 100,
                flexibleSpace: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: horinzontalPad),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Icon(Icons.menu),
                      const Spacer(),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Discover',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: NewsAppPallet.blackTextColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('News from all over the world',
                                style: Theme.of(context).textTheme.labelLarge),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(IndividualSearchPage.id);
                              },
                              child: const SearchBoxWidget(
                                controller: null,
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              SliverAppBar(
                snap: true,
                floating: true,
                pinned: true,
                expandedHeight: 50,
                flexibleSpace: SizedBox.expand(
                  child: TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      onTap: (index) {
                        context
                            .read<GetNewsBloc>()
                            .add(GetNewsListEvent(newsType: tabs[index]));
                      },
                      isScrollable: true,
                      controller: controller,
                      tabs: tabs.map((e) => Tab(child: Text(e))).toList()),
                ),
              ),
            ];
          },
          body: Center(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: tabs
                  .map(
                    (sclController) => BlocBuilder<GetNewsBloc, GetNewsState>(
                        builder: (context, state) {
                      if (state is GetNewsLoadingState) {
                        return const NewsLoadingProgressIndicator();
                      } else if (state is GetNewsLoadedState &&
                          state.newsFilteration.currentNewsType ==
                              tabs[controller.index]) {
                        return ShowNewsWidget(
                          newsList: state.newsList,
                        );
                      } else if (state is GetNewsFailureState) {
                        return BuildFailureWidget(
                          message: state.message,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
