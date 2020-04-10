import 'package:fish_redux/fish_redux.dart';
import 'dart:ui';
import '../store/state.dart';

class ThreeState implements Cloneable<ThreeState>, GlobalBaseState {
  @override
  Color themeColor;
  @override
  ThreeState clone() {
    return ThreeState()..themeColor = themeColor;
  }
}

ThreeState initState(Map<String, dynamic> args) {
  return ThreeState();
}
