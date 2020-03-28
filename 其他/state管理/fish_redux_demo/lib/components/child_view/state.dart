import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import '../../store/state.dart';

class ChildViewState implements GlobalBaseState, Cloneable<ChildViewState> {
  @override
  Color themeColor;
  @override
  ChildViewState clone() {
    return ChildViewState()..themeColor = themeColor;
  }
}

ChildViewState initState(Map<String, dynamic> args) {
  return ChildViewState();
}
