import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import '../model/twoModel.dart';

//TODO replace with your own action
enum TwoAction { action, loadData }

class TwoActionCreator {
  static Action onAction() {
    return Action(TwoAction.action);
  }

  static Action onloadData(TwoModel model) {
    return Action(TwoAction.loadData, payload: model);
  }
}
