import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AchildViewState> buildReducer() {
  return asReducer(
    <Object, Reducer<AchildViewState>>{
      AchildViewAction.action: _onAction,
    },
  );
}

AchildViewState _onAction(AchildViewState state, Action action) {
  final AchildViewState newState = state.clone();
  return newState;
}
