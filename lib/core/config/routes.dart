import 'package:flutter/material.dart';
import '../../features/search/view/pages/individual_search_page.dart';

class NewsRoute {
  static Route onGenerateRoute(RouteSettings setting) {
    return PageRouteBuilder(pageBuilder: (context, animation, animation2) {
      switch (setting.name) {
        case IndividualSearchPage.id:
          return ScaleTransition(
              scale: animation, child: const IndividualSearchPage());
        default:
          return const Scaffold(
            body: Text(
              'Routing Error',
            ),
          );
      }
    });
  }
}
