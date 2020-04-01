import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AdapterTestState> buildEffect() {
  return combineEffects(<Object, Effect<AdapterTestState>>{
    AdapterTestAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AdapterTestState> ctx) {
}
