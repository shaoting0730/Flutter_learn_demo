import 'package:fish_redux/fish_redux.dart';

class AchildViewState implements Cloneable<AchildViewState> {
  @override
  AchildViewState clone() {
    return AchildViewState();
  }
}

AchildViewState initState(Map<String, dynamic> args) {
  return AchildViewState();
}
