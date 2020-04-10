import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
// 客户1
import './app_one/tabbar/page.dart';
import './app_one/one_tab/page.dart';
import './app_one/two_tab/page.dart';

Widget createOneApp() {
  final AbstractRoutes routes =
      PageRoutes(pages: <String, Page<Object, dynamic>>{
    'user_one.tabbar': UserOneTabbarPage(),
    'user_one.one': UserOneOnePage(), //在这里添加页面
    'user_one.two': UserOneTwoPage(),
  });

  return MaterialApp(
    title: 'FishDemo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: routes.buildPage('user_one.tabbar', null), //把他作为默认页面
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
