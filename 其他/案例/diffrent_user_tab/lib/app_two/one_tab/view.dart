import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './action.dart';
import './state.dart';

Widget buildView(OneState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('app2'),
      backgroundColor: state.themeColor,
    ),
    body: ListView(
      children: <Widget>[
        Icon(Icons.print),
        Icon(Icons.print),
        Icon(Icons.print),
        Icon(Icons.print),
        Icon(Icons.print),
        InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            dispatch(OneActionCreator.onloginOut());
          },
          child: Text('退出当前user登录'),
        ),
        InkWell(
          onTap: () {
            dispatch(OneActionCreator.changeThemeColor());
          },
          child: Text('修改全局state'),
        )
      ],
    ),
  );
}
