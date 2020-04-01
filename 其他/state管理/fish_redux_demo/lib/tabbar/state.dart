import 'package:fish_redux/fish_redux.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../store/state.dart';

class TabbarState implements GlobalBaseState, Cloneable<TabbarState> {
  var index = 0;
  @override
  Color themeColor;

  @override
  TabbarState clone() {
    TabbarState newState = TabbarState()
      ..index = index
      ..themeColor = themeColor;
    return newState;
  }
}

TabbarState initState(Map<String, dynamic> args) {
  return TabbarState()..index = 0;
}
