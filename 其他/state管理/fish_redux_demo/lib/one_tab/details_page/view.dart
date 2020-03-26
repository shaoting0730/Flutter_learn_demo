import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    OneDetailsPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('详情界面'),
    ),
    body: ListView(
      children: <Widget>[
        Text('${state.num.toString()}'),
      ],
    ),
  );
}
