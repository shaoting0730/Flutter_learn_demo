import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TwoAction { action, loadData }

class TwoActionCreator {
  static Action onAction() {
    return const Action(TwoAction.action);
  }

  static Action onLoadData() {
    return const Action(TwoAction.loadData);
  }
}
