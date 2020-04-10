import 'package:fish_redux/fish_redux.dart';
import 'dart:ui';
import '../store/state.dart';

class OneState implements Cloneable<OneState>, GlobalBaseState {
  @override
  Color themeColor;
  @override
  OneState clone() {
    return OneState()..themeColor = themeColor;
  }
}

OneState initState(Map<String, dynamic> args) {
  return OneState();
}
