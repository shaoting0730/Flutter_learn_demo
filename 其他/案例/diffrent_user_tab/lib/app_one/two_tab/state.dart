import 'package:fish_redux/fish_redux.dart';

class TwoState implements Cloneable<TwoState> {

  @override
  TwoState clone() {
    return TwoState();
  }
}

TwoState initState(Map<String, dynamic> args) {
  return TwoState();
}
