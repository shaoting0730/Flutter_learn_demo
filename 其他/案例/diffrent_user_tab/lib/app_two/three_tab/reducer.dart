import 'package:fish_redux/fish_redux.dart';

import './action.dart';
import './state.dart';

Reducer<ThreeState> buildReducer() {
  return asReducer(
    <Object, Reducer<ThreeState>>{
      ThreeAction.action: _onAction,
    },
  );
}

ThreeState _onAction(ThreeState state, Action action) {
  final ThreeState newState = state.clone();
  return newState;
}
