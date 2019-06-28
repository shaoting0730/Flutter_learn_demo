import 'package:flutter/material.dart';

class NotificationListenerScroll extends StatefulWidget {
  @override
  _NotificationListenerScrollState createState() =>
      _NotificationListenerScrollState();
}

class _NotificationListenerScrollState
    extends State<NotificationListenerScroll> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: NotificationListener(
      onNotification: (ScrollNotification note) {
        print(note.metrics.pixels.toInt()); // 滚动位置。
      },
      child: new ListView.builder(
        itemCount: 40,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Text('今天吃什么？'),
          );
        },
      ),
    ));
  }
}
