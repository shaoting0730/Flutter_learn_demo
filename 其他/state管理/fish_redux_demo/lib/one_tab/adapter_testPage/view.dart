import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AdapterTestState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  return Scaffold(
    appBar: AppBar(
      backgroundColor: state.themeColor,
      title: Text('Adapter-${state.num}'),
    ),
    body: ListView.separated(
      itemBuilder: adapter.itemBuilder,
      itemCount: adapter.itemCount,
      separatorBuilder: (context, position) => Divider(
        height: 1,
      ),
    ),
  );
}
