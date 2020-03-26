import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ItemViewAction { action }

class ItemViewActionCreator {
  static Action onAction() {
    return const Action(ItemViewAction.action);
  }
}
