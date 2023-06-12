import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/widgets/internet_connection_checker.dart';
import 'package:news_app/core/widgets/news_loading_progress_indicator.dart';
import 'package:news_app/features/search/view/widget.dart/search_box_widget.dart';

import '../../../../core/widgets/build_failure_widget.dart';
import '../../blocs/search_news_bloc/get_search_news_bloc.dart';
import '../widget.dart/build_news_list_data.dart';

class IndividualSearchPage extends StatefulWidget {
  const IndividualSearchPage({super.key});
  static const String id = "individualSearchpage";
  @override
  State<IndividualSearchPage> createState() => _IndividualSearchPageState();
}

class _IndividualSearchPageState extends State<IndividualSearchPage> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          context.read<GetSearchNewsBloc>().add(ClearSearchNewsListEvent());
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    context
                        .read<GetSearchNewsBloc>()
                        .add(ClearSearchNewsListEvent());
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
              leadingWidth: 25,
              title: Row(
                children: [
                  Expanded(
                    child: SearchBoxWidget(
                      controller: controller,
                      onSubmit: (query) {
                        if (query.isEmpty) return;
                        context
                            .read<GetSearchNewsBloc>()
                            .add(GetSearchNewsListEvent(newsType: query));
                      },
                      absorbPointer: false,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.clear();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: BlocBuilder<GetSearchNewsBloc, GetSearchNewsState>(
                      builder: (context, state) {
                        if (state is GetSearchNewsLoadingState) {
                          return const NewsLoadingProgressIndicator();
                        } else if (state is GetSearchNewsLoadedState) {
                          if (state.newsList.isEmpty) {
                            return const Text("News not found");
                          }
                          return CustomScrollView(
                            slivers: [
                              BuildNewsListData(newsList: state.newsList),
                            ],
                          );
                        } else if (state is GetSearchNewsFailureState) {
                          return BuildFailureWidget(
                            message: state.message,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
const 
NewsInternetChecker(),
              ],
            )),
      ),
    );
  }
}
