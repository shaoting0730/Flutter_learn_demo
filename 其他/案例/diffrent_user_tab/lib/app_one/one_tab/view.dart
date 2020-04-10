import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(OneState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('app 1'),
    ),
    body: ListView(
      children: <Widget>[
        Text('-----'),
        Text('++++'),
        Text('-----'),
        Text('++++'),
        InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            dispatch(OneActionCreator.onloginOut());
          },
          child: Text('退出当前user登录'),
        )
      ],
    ),
  );
}
