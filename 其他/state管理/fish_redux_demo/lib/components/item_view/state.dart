import 'package:fish_redux/fish_redux.dart';
import '../../model/twoModel.dart';

class ItemViewState implements Cloneable<ItemViewState> {
  TwoModel model;

  @override
  ItemViewState clone() {
    return ItemViewState()..model = model;
  }
}

ItemViewState initState(Map<String, dynamic> args) {
  ItemViewState state = ItemViewState();
  return state;
}
