import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TabbarState> buildEffect() {
  return combineEffects(<Object, Effect<TabbarState>>{
    Lifecycle.initState: _init,
    TabbarAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TabbarState> ctx) {}

void _init(Action action, Context<TabbarState> ctx) {
  ctx.dispatch(
      Action(TabbarActionCreator.switchIndex, payload: action.payload));
}
