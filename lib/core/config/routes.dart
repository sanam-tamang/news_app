import 'package:flutter/material.dart';

class NewsRoute {
  static Route onGenerateRoute(RouteSettings setting) {
    return MaterialPageRoute(builder: (context) {
      switch (setting.name) {
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
