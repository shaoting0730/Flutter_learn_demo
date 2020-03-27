import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AchildViewState> buildEffect() {
  return combineEffects(<Object, Effect<AchildViewState>>{
    AchildViewAction.action: _onAction,
    AchildViewAction.allStateAction: _allStateAction,
  });
}

void _onAction(Action action, Context<AchildViewState> ctx) {}

void _allStateAction(Action action, Context<AchildViewState> ctx) {
  println('233333');
}
