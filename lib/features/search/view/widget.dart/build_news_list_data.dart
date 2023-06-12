import 'package:flutter/material.dart';
import 'package:news_app/core/utils/news_url_laucher.dart';

import '../../../../core/model/news.dart';
import '../../../../core/widgets/news_cached_network_image.dart';

class BuildNewsListData extends StatelessWidget {
  const BuildNewsListData({
    Key? key,
    required this.newsList,
  }) : super(key: key);
  final List<News> newsList;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final news = newsList[index];

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
              ],
            ),
          ),
        );
      }, childCount: newsList.length),
    );
  }
}
