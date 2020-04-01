import 'package:fish_redux/fish_redux.dart';
import 'package:fishreduxdemo/one_tab/action.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';
import 'dart:math';

Widget buildView(
    ChildViewState state, Dispatch dispatch, ViewService viewService) {
  var num = Random().nextInt(100);
  return InkWell(
    onTap: () {
      dispatch(ChildViewActionCreator.onPushToNewPageAction(num));
    },
    child: Container(
      height: 100,
      width: 200,
      child: Center(
        child: Text(
          'push 传值$num',
          style: TextStyle(color: state.themeColor),
        ),
      ),
    ),
  );
}
