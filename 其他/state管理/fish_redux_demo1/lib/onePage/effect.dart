import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action; //注意1
import 'action.dart';
import 'state.dart';

Effect<OneState> buildEffect() {
  return combineEffects(<Object, Effect<OneState>>{
    OneAction.action: _onAction,
    OneAction.onOpenTwo: _onOpenTwo, //接收openGrid事件
  });
}

void _onAction(Action action, Context<OneState> ctx) {}

//处理openGrid事件
void _onOpenTwo(Action action, Context<OneState> ctx) {
  Navigator.of(ctx.context).pushNamed('two', arguments: null); //注意2
}
