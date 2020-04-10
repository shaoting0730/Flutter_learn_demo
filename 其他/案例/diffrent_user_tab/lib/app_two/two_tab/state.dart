import 'package:fish_redux/fish_redux.dart';
import 'dart:ui';
import '../store/state.dart';

class TwoState implements Cloneable<TwoState>, GlobalBaseState {
  @override
  Color themeColor;
  @override
  TwoState clone() {
    return TwoState()..themeColor = themeColor;
  }
}

TwoState initState(Map<String, dynamic> args) {
  return TwoState();
}
