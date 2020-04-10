import 'package:fish_redux/fish_redux.dart';
import './action.dart';
import './state.dart';

Effect<ThreeState> buildEffect() {
  return combineEffects(<Object, Effect<ThreeState>>{
    ThreeAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ThreeState> ctx) {}
