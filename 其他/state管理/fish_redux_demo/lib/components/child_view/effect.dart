import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ChildViewState> buildEffect() {
  return combineEffects(<Object, Effect<ChildViewState>>{
    ChildViewAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ChildViewState> ctx) {
}
