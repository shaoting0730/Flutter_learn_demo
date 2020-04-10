import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import './state.dart';

Widget buildView(TwoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('app2'),
      backgroundColor: state.themeColor,
    ),
    body: ListView(
      children: <Widget>[],
    ),
  );
}
