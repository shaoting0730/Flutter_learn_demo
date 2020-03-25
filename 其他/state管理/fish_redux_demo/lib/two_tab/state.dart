import 'package:fish_redux/fish_redux.dart';
import '../model/twoModel.dart';

class TwoState implements Cloneable<TwoState> {
  TwoModel model;

  @override
  TwoState clone() {
    return TwoState()..model = model;
  }
}

TwoState initState(Map<String, dynamic> args) {
  return TwoState();
}
