import 'package:flutter/material.dart';

class TopicView extends StatefulWidget {
  final String topic;

  TopicView({this.topic});

  @override
  State<TopicView> createState() {
    return TopicViewState();
  }
}

class TopicViewState extends State<TopicView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      color: Color(0xFFF3F3F3),
      child: Text(
        this.widget.topic,
        style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
      ),
    );
  }
}
