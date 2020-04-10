import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ThreeAction { action }

class ThreeActionCreator {
  static Action onAction() {
    return const Action(ThreeAction.action);
  }
}
