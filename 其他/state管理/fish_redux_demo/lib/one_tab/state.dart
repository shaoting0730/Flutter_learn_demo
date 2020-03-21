import 'package:fish_redux/fish_redux.dart';

class OneState implements Cloneable<OneState> {

  @override
  OneState clone() {
    return OneState();
  }
}

OneState initState(Map<String, dynamic> args) {
  return OneState();
}
