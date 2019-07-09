import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class UserLoggedInEvent {
  String text;
  UserLoggedInEvent(String text){
    this.text = text;
  }
}