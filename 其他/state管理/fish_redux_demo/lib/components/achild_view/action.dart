import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AchildViewAction { action, changeThemeColor }

class AchildViewActionCreator {
  static Action onAction() {
    return const Action(AchildViewAction.action);
  }

  static Action changeThemeColor() {
    return const Action(AchildViewAction.changeThemeColor);
  }
}
