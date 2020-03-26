import 'package:fish_redux/fish_redux.dart';
import 'package:fishreduxdemo/components/item_view/state.dart';
import '../model/twoModel.dart';

class TwoState implements Cloneable<TwoState> {
  TwoModel model;
  ItemViewState itemState;

  @override
  TwoState clone() {
    return TwoState()
      ..model = model
      ..itemState = itemState;
  }
}

TwoState initState(Map<String, dynamic> args) {
  TwoState state = TwoState();
  state.itemState = ItemViewState();
  state.model = TwoModel();
  return state;
}

class ItemViewConnector extends ConnOp<TwoState, ItemViewState> {
  @override
  ItemViewState get(TwoState state) {
    return state.itemState..model = state.model;
  }

  @override
  void set(TwoState state, ItemViewState subState) {
    state.itemState = subState;
  }
}
