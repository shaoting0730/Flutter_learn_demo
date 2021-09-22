import 'package:flutter/material.dart';
import '../service/serviceapi.dart';
import 'package:intl/intl.dart';
import '../models/showing.dart';

class MyClientRecordCell extends StatefulWidget {
  
  final ShowingRequestModel model;
  MyClientRecordCell({this.model});

  @override
  State<StatefulWidget> createState() {
    return MyClientRecordCellState();
  }

}

class MyClientRecordCellState extends State<MyClientRecordCell> {
  @override
  Widget build(BuildContext context) {
    var format = new DateFormat('d/MM/y', 'en');
    var hourFormatter = DateFormat('HH:mm', 'en');
    var date = format.format(TicksToDateTime(widget.model.ScheduledStartTime));
    var startAt = hourFormatter.format(TicksToDateTime(widget.model.ScheduledStartTime));
    var endAt = hourFormatter.format(TicksToDateTime(widget.model.ScheduledEndTime));
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/icon_location.png'),
                SizedBox(width: 5,),
                Text(widget.model.AddressText, style: TextStyle(fontSize: 14))
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/icon_calendar.png'),
                SizedBox(width: 5,),
                Text(date + " " + startAt + " - " + endAt, style: TextStyle(fontSize: 14))
              ],
            ),
          )
        ],
      ),
    );
  }

}