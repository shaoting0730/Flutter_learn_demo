import 'package:fish_redux/fish_redux.dart';

class OneDetailsPageState implements Cloneable<OneDetailsPageState> {
  int num;
  @override
  OneDetailsPageState clone() {
    return OneDetailsPageState();
  }
}

OneDetailsPageState initState(Map<String, dynamic> args) {
  print(args);
  return OneDetailsPageState()..num = args["params"];
}
