import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChildViewAction { action }

class ChildViewActionCreator {
  static Action onAction() {
    return const Action(ChildViewAction.action);
  }
}
