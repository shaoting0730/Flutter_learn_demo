import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OneAction { action, onloginOut, changeThemeColor }

class OneActionCreator {
  static Action onAction() {
    return const Action(OneAction.action);
  }

  static Action onloginOut() {
    return const Action(OneAction.onloginOut);
  }

  static Action changeThemeColor() {
    return const Action(OneAction.changeThemeColor);
  }
}
