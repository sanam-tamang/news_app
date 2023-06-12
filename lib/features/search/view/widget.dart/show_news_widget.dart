// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/model/news.dart';
import 'build_news_list_data.dart';

///this widgets helps to show the custom scrollview data
///and also it helps to scrollcontroller to being not to define by explicitly
///
class ShowNewsWidget extends StatefulWidget {
  final List<News> newsList;
  const ShowNewsWidget({
    Key? key,
    required this.newsList,
  }) : super(key: key);

  @override
  State<ShowNewsWidget> createState() => _ShowNewsWidgetState();
}

class _ShowNewsWidgetState extends State<ShowNewsWidget> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      ///removing the scrollbar
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: CustomScrollView(
          slivers: [BuildNewsListData(newsList: widget.newsList)]),
    );
  }
}
