import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OneDetailsPageAction { action }

class OneDetailsPageActionCreator {
  static Action onAction() {
    return Action(OneDetailsPageAction.action);
  }
}
