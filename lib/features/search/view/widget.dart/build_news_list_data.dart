// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/blocs/get_news_bloc/get_news_bloc.dart';
import 'package:news_app/core/utils/news_url_laucher.dart';
import 'package:news_app/core/widgets/news_loading_progress_indicator.dart';

import '../../../../core/enum/fetch_data_with_page.dart';
import '../../../../core/model/news.dart';
import '../../../../core/widgets/news_cached_network_image.dart';

class BuildNewsListData extends StatefulWidget {
  const BuildNewsListData({
    Key? key,
    required this.newsList,
    required this.fetchWithPageEnum,
  }) : super(key: key);
  final List<News> newsList;
  final FetchWithPageEnum fetchWithPageEnum;

  @override
  State<BuildNewsListData> createState() => _BuildNewsListDataState();
}

class _BuildNewsListDataState extends State<BuildNewsListData> {
  int previousLength = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final news = widget.newsList[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => newsUrlLaucher(news.url),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15 > 160
                      ? 170
                      : 130,
                  width: double.maxFinite,
                ),
                Positioned(
                  left: 5,
                  top: 0,
                  right: width * 0.7,
                  bottom: 5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NewsCachedNetworkImage(image: news.urlToImage)),
                ),
                Positioned(
                    left: width * 0.32,
                    top: 0,
                    right: 5,
                    bottom: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          news.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          news.source.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    )),

                ///fetching data again if there is has the data
                Builder(builder: (context) {
                  ///if there is no data left return
                  if (widget.fetchWithPageEnum ==
                      FetchWithPageEnum.hasFurtherDataToFetch) {
                    if (widget.newsList.length == index + 1) {
                      log("last ");

                      if (previousLength != widget.newsList.length) {
                        previousLength = widget.newsList.length;
                        log("hee  prv $previousLength ");
                        context
                            .read<GetNewsBloc>()
                            .add(GetNewsListWithPageEvent());
                        return const Center(
                            child:  NewsLoadingProgressIndicator());
                      }
                    }
                  }

                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        );
      }, childCount: widget.newsList.length),
    );
  }
}
