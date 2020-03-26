import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ItemViewState> buildEffect() {
  return combineEffects(<Object, Effect<ItemViewState>>{
    ItemViewAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ItemViewState> ctx) {
}
