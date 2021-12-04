import 'package:flutter/material.dart';

abstract class  RouteDefine {
  build(Map<String?, WidgetBuilder?>? routeBuilders, RouteSettings settings) {
    initRoute(settings.arguments).forEach((element) {
      routeBuilders?.addAll(element.path());
    });
  }

  List<Path> initRoute(Object? arguments);
}

class Path {
  String name;
  WidgetBuilder builder;
  Path({required this.name, required this.builder});

  Map<String, WidgetBuilder> path() => {name: builder};
}
