import 'package:flutter/material.dart';
import '../pages/message_page.dart';
import '../pages/my_plans_page.dart';

class MessageBadgeIcon extends StatefulWidget {

  final int badge;
  MessageBadgeIcon({this.badge});

  @override
  State<StatefulWidget> createState() {
    return MessageBadgeIconState();
  }

}

class MessageBadgeIconState extends State<MessageBadgeIcon> {

  @override
  Widget build(BuildContext context) {
    var list = List<Widget>();
    list.add(
      Center(
        child: IconButton(
          icon: ImageIcon(
            AssetImage('assets/ico_message_s.png'),
            color: Colors.black
          ),
          color: Colors.black,
          onPressed: () {
            updateMyPlanMessageCount(0);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MessagePage()));
          },
        )
      )
    );

    if(widget.badge > 0) {
      
      list.add(
        Positioned(
          right: 5,
          top: 5,
          child: Container(
            alignment: Alignment(0, 0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            height: 16,
            width: 16,
            child: Text(widget.badge.toString(), style: TextStyle(fontSize: 10, color: Colors.white)),
          ),
        )
      );
    }

    return Container(

      child: Stack(
        children: list,
      ),
    );
  }

}