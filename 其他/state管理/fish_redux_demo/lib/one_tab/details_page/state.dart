import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import '../../store/state.dart';

class OneDetailsPageState
    implements Cloneable<OneDetailsPageState>, GlobalBaseState {
  int num;
  @override
  Color themeColor;
  @override
  OneDetailsPageState clone() {
    return OneDetailsPageState()..num = num;
  }
}

OneDetailsPageState initState(Map<String, dynamic> args) {
  OneDetailsPageState state = OneDetailsPageState();
  state..num = args["params"];
  return state;
}
