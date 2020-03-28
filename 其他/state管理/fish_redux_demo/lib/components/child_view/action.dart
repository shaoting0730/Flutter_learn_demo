import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChildViewAction { action, pushToNewPageAction, initList }

class ChildViewActionCreator {
  static Action onAction() {
    return Action(ChildViewAction.action);
  }

  static Action onPushToNewPageAction(int num) {
    return Action(ChildViewAction.pushToNewPageAction,
        payload: {'params': num});
  }

  static Action initList(int num) {
    return Action(ChildViewAction.initList, payload: num);
  }
}
