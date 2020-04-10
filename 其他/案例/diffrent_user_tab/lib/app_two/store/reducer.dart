import 'package:fish_redux/fish_redux.dart';
import 'dart:ui';
import 'package:flutter/material.dart' hide Action;
import './action.dart';
import './state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onChangeThemeColor,
    },
  );
}

GlobalState _onChangeThemeColor(GlobalState state, Action action) {
  final Color color =
      state.themeColor == Colors.green ? Colors.blue : Colors.green;
  return state.clone()..themeColor = color;
}
