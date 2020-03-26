import 'package:fish_redux/fish_redux.dart';
import '../../model/twoModel.dart';

class ItemViewState implements Cloneable<ItemViewState> {
  TwoModel model;
  @override
  ItemViewState clone() {
    return ItemViewState();
  }
}

ItemViewState initState(Map<String, dynamic> args) {
  return ItemViewState()..model;
}
