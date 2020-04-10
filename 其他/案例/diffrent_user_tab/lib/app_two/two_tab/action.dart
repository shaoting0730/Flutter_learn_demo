import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TwoAction { action }

class TwoActionCreator {
  static Action onAction() {
    return const Action(TwoAction.action);
  }
}
