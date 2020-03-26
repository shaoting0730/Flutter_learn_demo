import 'package:fish_redux/fish_redux.dart';
import 'package:fishreduxdemo/two_tab/state.dart';
import '../components/child_view/state.dart';

class OneState implements Cloneable<OneState> {
  ChildViewState childState;
  @override
  OneState clone() {
    return OneState()..childState = childState;
  }
}

OneState initState(Map<String, dynamic> args) {
  OneState state = OneState();
  state.childState = ChildViewState();
  return state;
}

class ChildViewConnector extends ConnOp<OneState, ChildViewState> {
  @override
  ChildViewState get(OneState state) {
    return state.childState;
  }

  @override
  void set(OneState state, ChildViewState subState) {
    state.childState = subState;
  }
}
