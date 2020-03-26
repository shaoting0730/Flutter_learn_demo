import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(TwoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Two'),
    ),
    body: ListView(
      children: <Widget>[
        _itemView(state, viewService),
      ],
    ),
  );
}

Align _itemView(TwoState state, ViewService viewService) {
  println(jsonEncode(state.model));
  return Align(child: viewService.buildComponent('ChildViewComponent'));
}
