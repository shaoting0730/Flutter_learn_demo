import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<OneDetailsPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<OneDetailsPageState>>{
      OneDetailsPageAction.action: _onAction,
    },
  );
}

OneDetailsPageState _onAction(OneDetailsPageState state, Action action) {
  final OneDetailsPageState newState = state.clone();
  return newState;
}
