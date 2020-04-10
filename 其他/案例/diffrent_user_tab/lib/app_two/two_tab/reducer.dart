import 'package:fish_redux/fish_redux.dart';

import './action.dart';
import './state.dart';

Reducer<TwoState> buildReducer() {
  return asReducer(
    <Object, Reducer<TwoState>>{
      TwoAction.action: _onAction,
    },
  );
}

TwoState _onAction(TwoState state, Action action) {
  final TwoState newState = state.clone();
  return newState;
}
