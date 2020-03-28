import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { changeThemeColor }

class GlobalActionCreator{
  static Action onChangeThemeColor(){
    return const Action(GlobalAction.changeThemeColor);
  }
}