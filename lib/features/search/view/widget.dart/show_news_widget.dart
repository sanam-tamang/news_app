// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/enum/fetch_data_with_page.dart';
import '../../../../core/model/news.dart';
import 'build_news_list_data.dart';

///this widgets helps to show the custom scrollview data
///and also it helps to scrollcontroller to being not to define by explicitly
///
class ShowNewsWidget extends StatefulWidget {
  final List<News> newsList;
  final FetchWithPageEnum fetchWithPageEnum;
  const ShowNewsWidget({
    Key? key,
    required this.newsList,
    required this.fetchWithPageEnum,
  }) : super(key: key);

  @override
  State<ShowNewsWidget> createState() => _ShowNewsWidgetState();
}

class _ShowNewsWidgetState extends State<ShowNewsWidget> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      ///removing the scrollbar, which causes issue of the scrolling
      ///if I don't remove I need to used scrollController which is also causing the issue
      ///the sperates the scrolling from nested scrollview and customscrollview
      ///meaning that at one time you only can scroll one widget which solved this issue by putting the behaviour
      /// of the scrolling
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: CustomScrollView(
          slivers: [BuildNewsListData(newsList: widget.newsList, fetchWithPageEnum: 
          widget.fetchWithPageEnum,)]),
    );
  }
}
