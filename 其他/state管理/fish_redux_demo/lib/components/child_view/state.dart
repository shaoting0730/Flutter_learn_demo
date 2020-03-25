import 'package:fish_redux/fish_redux.dart';

class ChildViewState implements Cloneable<ChildViewState> {
  @override
  ChildViewState clone() {
    return ChildViewState();
  }
}

ChildViewState initState(Map<String, dynamic> args) {
  return ChildViewState();
}
