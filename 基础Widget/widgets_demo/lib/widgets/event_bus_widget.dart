import 'package:flutter/material.dart';
//引入Bus
import './event_bus.dart';
class EventBusWidget extends StatefulWidget {
  @override
  _EventBusWidgetState createState() => _EventBusWidgetState();
}

class _EventBusWidgetState extends State<EventBusWidget> {
  String text = '我是触发事件,通过Bus传递';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('event bus')),
        body: Center(
          child: InkWell(
            onTap: (){
          //Bus触发事件
          eventBus.fire(new UserLoggedInEvent(text));
            },
            child: Text('传'),
          ),
        ),
    );
  }
}