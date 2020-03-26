import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:fishreduxdemo/model/twoModel.dart';
import 'action.dart';
import 'state.dart';

import '../components/item_view/state.dart';

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
  final TwoModel model = action.payload;
  final TwoState newState = state.clone();
  newState.model = model;
  return newState;
}
