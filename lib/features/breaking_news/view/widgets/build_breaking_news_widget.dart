// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/config/pallet.dart';
import 'package:news_app/core/utils/news_url_laucher.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/model/news.dart';
import '../../../../core/widgets/news_cached_network_image.dart';
import '../../../../core/widgets/news_image_shader_mask.dart';
import '../../../navigation_bar/bloc/change_navbar_index_cubit/change_navbar_indexer_cubit.dart';
import 'transparent_background_with_white_color.dart';

class BuildBreakingNewsWidget extends StatelessWidget {
  const BuildBreakingNewsWidget({
    Key? key,
    required this.newsList,
  }) : super(key: key);
  final List<News> newsList;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      double imageHeight =
          constraint.maxHeight < 600 ? 400 : constraint.maxHeight * 0.45;
      return CustomScrollView(
        slivers: [
          //0.45
          SliverToBoxAdapter(
            child: SizedBox(
              height: imageHeight,
              child: _BuildNewsOfTheDayWidget(
                newsList: newsList,
                height: imageHeight,
              ),
            ),
          ),
          //0.55
          SliverToBoxAdapter(
            child: SizedBox.fromSize(
              size: Size.fromHeight(constraint.maxHeight < 600
                  ? 500
                  : constraint.maxHeight * 0.55),
              child: _BuildBreakingNewsData(newsList: newsList),
            ),
          )
        ],
      );
    });
  }
}

///child widgets

///########### image of home page section ####################
///
///

class _BuildNewsOfTheDayWidget extends StatelessWidget {
  const _BuildNewsOfTheDayWidget({
    Key? key,
    required this.newsList,
    required this.height,
  }) : super(key: key);

  final List<News> newsList;

  ///height of the parent should be provided
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Builder(builder: (context) {
      final firstNews =
          newsList.firstWhere((element) => element.urlToImage != null);
      return Stack(
        children: [
          SizedBox(
              height: height,
              width: double.maxFinite,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: NewsImageShaderMask(
                  imageUrl: firstNews.urlToImage!,
                ),
              )),
          const Positioned(
            top: 15,
            left: 15,
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: height * 0.3,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransparentWhiteBackgroundWithTextWidget(
                    child: Text(
                      'News of the day',
                      style: theme.titleSmall?.copyWith(
                          color: NewsAppPallet.whiteTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: Text(
                      firstNews.title,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style: theme.headlineSmall?.copyWith(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: NewsAppPallet.whiteTextColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () => newsUrlLaucher(firstNews.url),
                    child: Row(
                      children: [
                        Text(
                          'Learn More',
                          style: theme.titleMedium?.copyWith(
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              color: NewsAppPallet.whiteTextColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_right_alt,
                          size: 36,
                          color: NewsAppPallet.whiteTextColor,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

///################## breaking new section ##########################
class _BuildBreakingNewsData extends StatelessWidget {
  const _BuildBreakingNewsData({
    required this.newsList,
  });

  final List<News> newsList;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horinzontalPad,
                vertical: constraints.maxHeight * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Breaking News',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(
                  onPressed: () {
                    ///sendign to search page when pressing the this button
                    ///
                    context.read<ChangeNavbarIndexerCubit>().changeIndex(1);
                  },
                  child: Text(
                    'More',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: newsList.length,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: verticalPad,
                  );
                },
                itemBuilder: (context, index) {
                  final News news = newsList[index];
                  return GestureDetector(
                    onTap: () => newsUrlLaucher(news.url),
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: NewsCachedNetworkImage(
                                  image: news.urlToImage),
                            ),
                          ),
                          Container(
                            height: constraints.maxHeight * 0.05,
                          ),
                          Text(
                            news.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Container(
                            height: constraints.maxHeight * 0.02,
                          ),
                          Text(
                            news.source.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Container(
                            height: constraints.maxHeight * 0.08,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      );
    });
  }
}
