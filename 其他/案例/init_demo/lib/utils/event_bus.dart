import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class NotificationTag {
  String text;
  NotificationTag(this.text);
}
