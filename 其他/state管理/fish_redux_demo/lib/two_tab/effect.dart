import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../service_api/ServiceApi.dart';
import '../model/twoModel.dart';

Effect<TwoState> buildEffect() {
  return combineEffects(<Object, Effect<TwoState>>{
    Lifecycle.initState: _init,
    TwoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TwoState> ctx) {}

void _init(Action action, Context<TwoState> ctx) {
  ServiceApi().twoGetData().then((value) {
    ctx.dispatch(TwoActionCreator.onloadData(value));
  });
}
