import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TabbarState> buildReducer() {
  return asReducer(
    <Object, Reducer<TabbarState>>{
      TabbarAction.action: _onAction,
      TabbarAction.switchIndex: _switchIndex,
    },
  );
}

TabbarState _onAction(TabbarState state, Action action) {
  final TabbarState newState = state.clone();
  return newState;
}

/*
* 切换tab点击
* */
TabbarState _switchIndex(TabbarState state, Action action) {
  var index = action.payload;
  final TabbarState newState = state.clone()..index = index;

  return newState;
}
