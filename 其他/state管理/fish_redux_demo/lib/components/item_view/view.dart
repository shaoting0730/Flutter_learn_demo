import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ItemViewState state, Dispatch dispatch, ViewService viewService) {
  print(">>>>>>>>>>>>>>>>>>componnet:${state.model.status}");
  return Container(
    child: Text('${state.model.status}'),
  );
}
