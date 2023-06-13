import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/internet_connection_checker_bloc/internet_connection_checker_bloc.dart';
import '../enum/internet_state_enum.dart';

class NewsInternetChecker extends StatelessWidget {
  const NewsInternetChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCheckerBloc,
        InternetConnectionCheckerState>(
      builder: (context, state) {
        if (state is InternetConnectionCheckerLoadedState) {
          if (state.status == InternetStatusEnum.disConnected) {
            return Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                color: Colors.grey.shade400,
                child: const Text("No internet"));
          } else {
            return const SizedBox.shrink();
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
