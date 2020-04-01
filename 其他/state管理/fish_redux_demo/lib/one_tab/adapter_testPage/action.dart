import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AdapterTestAction { action }

class AdapterTestActionCreator {
  static Action onAction() {
    return const Action(AdapterTestAction.action);
  }
}
