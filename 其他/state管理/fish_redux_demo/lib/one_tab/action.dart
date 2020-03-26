import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OneAction { action }

class OneActionCreator {
  static Action onAction() {
    return Action(OneAction.action);
  }
}
