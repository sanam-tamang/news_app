import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/widgets/build_failure_widget.dart';
import 'package:news_app/features/breaking_news/view/widgets/build_breaking_news_widget.dart';

import '../../../../core/blocs/get_news_bloc/get_news_bloc.dart';
import '../../../../core/widgets/news_loading_progress_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context
        .read<GetNewsBloc>()
        .add(const GetNewsListEvent(newsType: 'Breaking'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: BlocBuilder<GetNewsBloc, GetNewsState>(
          builder: (context, state) {
            if (state is GetNewsLoadingState) {
              return const NewsLoadingProgressIndicator();
            } else if (state is GetNewsLoadedState) {
              return BuildBreakingNewsWidget(newsList: state.newsList);
            } else if (state is GetNewsFailureState) {
              return BuildFailureWidget(message: state.message);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
