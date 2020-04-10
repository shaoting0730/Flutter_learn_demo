import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import './action.dart';
import './state.dart';
import '../../login_page.dart';
import '../store/action.dart';
import '../store/store.dart';

Effect<OneState> buildEffect() {
  return combineEffects(<Object, Effect<OneState>>{
    OneAction.action: _onAction,
    OneAction.onloginOut: _onloginOut,
    OneAction.changeThemeColor: _onChangeThemeColor,
  });
}

void _onAction(Action action, Context<OneState> ctx) {}

void _onloginOut(Action action, Context<OneState> ctx) {
  print('2');
  Navigator.of(ctx.context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => route == null);
}

void _onChangeThemeColor(Action action, Context<OneState> ctx) {
  GlobalStore.store.dispatch(GlobalActionCreator.onChangeThemeColor());
}
