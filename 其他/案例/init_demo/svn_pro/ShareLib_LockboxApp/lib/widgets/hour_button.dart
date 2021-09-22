import 'package:flutter/material.dart';


enum HouseButtonStatus {
  selected,
  unselected,
  disabled
}

class HourButton extends StatefulWidget {

  final HouseButtonStatus status;
  final String time;
  HourButton({this.status, this.time});

  @override
  State<HourButton> createState() {
    return HourButtonState();
  }

}

class HourButtonState extends State<HourButton> {

  @override
  Widget build(BuildContext context) {

    Color backgroundColor;
    Color textColor;
    switch (widget.status) {
      case HouseButtonStatus.disabled:
        backgroundColor = Color(0xFFF3F3F3);
        textColor = Color(0xFFAAAAAA);
        break;
      case HouseButtonStatus.selected:
        backgroundColor = Color(0xFF536282);
        textColor = Colors.white;
        break;
      case HouseButtonStatus.unselected:
        backgroundColor = Colors.white;
        textColor = Color(0xFF536282);
        break;
    }
    
    return Container(
      alignment: Alignment(0, 0),
      child: Container(
        height: 30,
        width: 115,
        alignment: Alignment(0, 0),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Color(0xFF536282))
        ),
        child: Text(widget.time, style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w600),),
      )
    );
  }

}