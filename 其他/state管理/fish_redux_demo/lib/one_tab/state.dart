import 'package:fish_redux/fish_redux.dart';
import 'dart:ui';
import '../components/child_view/state.dart';
import '../components/achild_view/state.dart';
import '../store/state.dart';

class OneState implements Cloneable<OneState>, GlobalBaseState {
  ChildViewState childState;
  AchildViewState aChildState;

  @override
  Color themeColor;

  @override
  OneState clone() {
    return OneState()
      ..childState = childState
      ..aChildState = aChildState
      ..themeColor = themeColor;
  }
}

OneState initState(Map<String, dynamic> args) {
  OneState state = OneState();
  state.childState = ChildViewState();
  state.aChildState = AchildViewState();
  return state;
}

class ChildViewConnector extends ConnOp<OneState, ChildViewState> {
  @override
  ChildViewState get(OneState state) {
    return state.childState;
  }

  @override
  void set(OneState state, ChildViewState subState) {
    state.childState = subState;
  }
}

class AchildViewConnector extends ConnOp<OneState, AchildViewState> {
  @override
  AchildViewState get(OneState state) {
    return state.aChildState;
  }

  @override
  void set(OneState state, AchildViewState subState) {
    state.aChildState = subState;
  }
}
