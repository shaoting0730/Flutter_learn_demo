import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:fishreduxdemo/service_api/ServiceApi.dart';

import 'action.dart';
import 'state.dart';

import '../model/twoModel.dart';

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
  final TwoState newState = state.clone();
  newState.model = action.payload;
  return newState;
}
