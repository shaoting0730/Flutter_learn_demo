import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import './state.dart';

Widget buildView(ThreeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: ListView(
      children: <Widget>[
        Text(
          '我的',
          style: TextStyle(color: state.themeColor),
        ),
        Text(
          '我的',
          style: TextStyle(color: state.themeColor),
        ),
        Text(
          '我的',
          style: TextStyle(color: state.themeColor),
        ),
      ],
    ),
  );
}
