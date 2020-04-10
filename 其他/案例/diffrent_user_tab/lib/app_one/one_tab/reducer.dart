import 'package:fish_redux/fish_redux.dart';

import './action.dart';
import './state.dart';

Reducer<OneState> buildReducer() {
  return asReducer(
    <Object, Reducer<OneState>>{
      OneAction.action: _onAction,
    },
  );
}

OneState _onAction(OneState state, Action action) {
  final OneState newState = state.clone();
  return newState;
}
