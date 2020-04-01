import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AdapterTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<AdapterTestState>>{
      AdapterTestAction.action: _onAction,
    },
  );
}

AdapterTestState _onAction(AdapterTestState state, Action action) {
  final AdapterTestState newState = state.clone();
  return newState;
}
