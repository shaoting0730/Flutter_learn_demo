import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../../store/action.dart';
import '../../store/store.dart';

Effect<AchildViewState> buildEffect() {
  return combineEffects(<Object, Effect<AchildViewState>>{
    AchildViewAction.action: _onAction,
    AchildViewAction.changeThemeColor: _onChangeThemeColor,
  });
}

void _onAction(Action action, Context<AchildViewState> ctx) {}

void _onChangeThemeColor(Action action, Context<AchildViewState> ctx) {
  GlobalStore.store.dispatch(GlobalActionCreator.onChangeThemeColor());
}
