import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AchildViewState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Text('我也想知道其他子组件的state'),
  );
}
