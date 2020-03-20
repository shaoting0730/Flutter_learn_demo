import 'package:fish_redux/fish_redux.dart';
import '../api.dart';

import 'action.dart';
import 'state.dart';

Reducer<TwoState> buildReducer() {
  return asReducer(
    <Object, Reducer<TwoState>>{
      TwoAction.action: _onAction,
      TwoAction.loadData: _onLoadData,
    },
  );
}

TwoState _onAction(TwoState state, Action action) {
  final TwoState newState = state.clone();
  return newState;
}

TwoState _onLoadData(TwoState state, Action action) {
  final TwoState newState = state.clone()..models = Api().getGridData();
  return newState;
}
