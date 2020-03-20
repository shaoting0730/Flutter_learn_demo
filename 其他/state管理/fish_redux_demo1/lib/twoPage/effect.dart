import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TwoState> buildEffect() {
  return combineEffects(<Object, Effect<TwoState>>{
    Lifecycle.initState: _init,
    TwoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TwoState> ctx) {}

void _init(Action action, Context<TwoState> ctx) {
  ctx.dispatch(TwoActionCreator.onLoadData());
}
