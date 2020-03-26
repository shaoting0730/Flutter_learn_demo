import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(TwoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Two'),
    ),
    body: state.model.status == null
        ? _buildEmpty(state, dispatch, viewService)
        : _itemView(state, viewService),
  );
}

Widget _buildEmpty(TwoState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Center(
      child: Text('数据拉取。。。'),
    ),
  );
}

Widget _itemView(TwoState state, ViewService viewService) {
  return viewService.buildComponent('ChildViewComponent');
}
