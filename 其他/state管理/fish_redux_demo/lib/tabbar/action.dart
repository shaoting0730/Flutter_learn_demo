import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TabbarAction { action, switchIndex }

class TabbarActionCreator {
  static Action onAction() {
    return Action(TabbarAction.action);
  }

  // 切换tab
  static Action switchIndex(int index) {
    return Action(TabbarAction.switchIndex, payload: index);
  }
}
