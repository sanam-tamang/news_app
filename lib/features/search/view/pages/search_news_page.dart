import 'package:flutter/material.dart';
import 'package:news_app/core/config/constants.dart';
import 'package:news_app/core/config/pallet.dart';

class SearchNewsPage extends StatefulWidget {
  const SearchNewsPage({super.key});

  @override
  State<SearchNewsPage> createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrollable) {
                  return [
                    SliverAppBar(
                      leading: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.menu)),
                      expandedHeight: 150,
                      backgroundColor: Colors.amber,
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: horinzontalPad),
                        child: Column(
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
                              Text('News from all over the world',
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            ]),
                      ),
                    ),
                    SliverAppBar(
                      snap: true,
                      floating: true,
                      pinned: true,
                      expandedHeight: 60,
                      flexibleSpace: Container(
                        color: Colors.yellow,
                      ),
                    ),
                  ];
                },
                body: Container(
                  color: Colors.red,
                ))));
  }
}
