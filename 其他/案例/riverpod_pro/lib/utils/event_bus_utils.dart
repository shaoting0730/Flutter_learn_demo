import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

//通知Tab修改角标
class NotIndex {
  final String index;
  NotIndex(this.index);
}
