import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OneAction { action, onOpenTwo }

class OneActionCreator {
  static Action onAction() {
    return const Action(OneAction.action);
  }

  static Action onOpenTwo() {
    return const Action(OneAction.onOpenTwo);
  }
}
