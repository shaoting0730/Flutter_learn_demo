import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(TwoState state, Dispatch dispatch, ViewService viewService) {
  println(jsonEncode(state.model));
  return Scaffold(
    appBar: AppBar(
      title: Text('Two'),
    ),
    body: Container(),
  );
}
