import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action; //注意1
import 'action.dart';
import 'state.dart';

Effect<ChildViewState> buildEffect() {
  return combineEffects(<Object, Effect<ChildViewState>>{
    ChildViewAction.action: _onAction,
    ChildViewAction.pushToNewPageAction: _pushAction,
    ChildViewAction.allStateAction: _allStateAction,
  });
}

void _onAction(Action action, Context<ChildViewState> ctx) {}

// push 到新page
void _pushAction(Action action, Context<ChildViewState> ctx) {
  var params = action.payload;
  Navigator.of(ctx.context).pushNamed('one_details', arguments: params); //注意2
}

//  发送通知
void _allStateAction(Action action, Context<ChildViewState> ctx) {
  var params = action.payload;
  ctx.broadcast(ChildViewActionCreator.onAllStateAction(params));
}
