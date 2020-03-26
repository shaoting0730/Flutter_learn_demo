import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<OneDetailsPageState> buildEffect() {
  return combineEffects(<Object, Effect<OneDetailsPageState>>{
    OneDetailsPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<OneDetailsPageState> ctx) {
}
