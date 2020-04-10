import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import './state.dart';

Widget buildView(TwoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('app1'),
      backgroundColor: state.themeColor,
    ),
    body: ListView(
      children: <Widget>[
        Icon(Icons.accessibility),
        Icon(Icons.accessibility),
        Icon(Icons.accessibility),
        Icon(Icons.accessibility),
        Icon(Icons.accessibility),
        Icon(Icons.accessibility),
        Icon(Icons.accessibility),
        Icon(Icons.accessibility),
        Icon(Icons.accessibility),
      ],
    ),
  );
}
