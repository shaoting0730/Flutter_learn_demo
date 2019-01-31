import 'package:flutter/material.dart';
import 'draggable_widget.dart';

class DraggableDemo extends StatefulWidget {
   DraggableDemoState createState() =>  DraggableDemoState();
}

class  DraggableDemoState extends State <DraggableDemo> {
  Color _draggbleColor = Colors.grey;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DraggableWidget(
          offset: Offset(110.0, 80.0),
          widgetColor: Colors.pink,
        ),
        DraggableWidget(
          offset: Offset(210.0, 80.0),
          widgetColor: Colors.orange,
        ),
        Center(
          child: DragTarget(
            onAccept: (Color color){
              _draggbleColor = color;
            },
            builder: (context,candidateDate,rejectedData){
              return Container(
                width: 200.0,
                height: 200.0,
                color: _draggbleColor
              );
            },
          ),
        )
      ],
    );
  }
}