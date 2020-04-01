import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    OneDetailsPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('详情界面:${state.num.toString()}'),
      backgroundColor: state.themeColor,
    ),
    body: ListView(
      children: <Widget>[
        Text(''),
      ],
    ),
  );
}
