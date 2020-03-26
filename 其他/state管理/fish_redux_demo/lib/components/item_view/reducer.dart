import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ItemViewState> buildReducer() {
  return asReducer(
    <Object, Reducer<ItemViewState>>{
      ItemViewAction.action: _onAction,
    },
  );
}

ItemViewState _onAction(ItemViewState state, Action action) {
  final ItemViewState newState = state.clone();
  return newState;
}
