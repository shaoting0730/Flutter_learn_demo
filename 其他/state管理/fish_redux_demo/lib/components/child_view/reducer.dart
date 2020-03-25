import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChildViewState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChildViewState>>{
      ChildViewAction.action: _onAction,
    },
  );
}

ChildViewState _onAction(ChildViewState state, Action action) {
  final ChildViewState newState = state.clone();
  return newState;
}
