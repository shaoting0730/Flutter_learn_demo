import 'package:fish_redux/fish_redux.dart';
import 'dart:ui';
import 'package:fishreduxdemo/components/item_view/state.dart';
import '../model/twoModel.dart';
import '../store/state.dart';

class TwoState implements Cloneable<TwoState>, GlobalBaseState {
  TwoModel model;
  ItemViewState itemState;

  @override
  Color themeColor;
  @override
  TwoState clone() {
    return TwoState()
      ..model = model
      ..itemState = itemState
      ..themeColor = themeColor;
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
