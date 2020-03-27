import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AchildViewAction { action, allStateAction }

class AchildViewActionCreator {
  static Action onAction() {
    return const Action(AchildViewAction.action);
  }

  static Action onAllStateAction() {
    return const Action(AchildViewAction.allStateAction);
  }
}
