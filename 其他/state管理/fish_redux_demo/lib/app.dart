import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import './tabbar/page.dart';

import './one_tab/page.dart';
import './one_tab/details_page/page.dart';

import './two_tab/page.dart';

Widget createApp() {
  final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'tabbar': TabbarPage(),
      'one': OnePage(), //在这里添加页面
      'two': TwoPage(),
      'one_details': OneDetailsPagePage(),
    },
  );

  return MaterialApp(
    title: 'FishDemo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: routes.buildPage('tabbar', null), //把他作为默认页面
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
