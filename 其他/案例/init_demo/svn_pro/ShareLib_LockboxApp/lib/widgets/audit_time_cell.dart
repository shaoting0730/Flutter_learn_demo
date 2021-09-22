import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/showing.dart';
import '../service/baseapi.dart';
import '../service/serviceapi.dart';

typedef OnValueChanged = void Function();

class AuditTimeCell extends StatefulWidget {

  final ShowingAutoConfirmSettingModel model;
  final OnValueChanged onValueChanged;

  AuditTimeCell({this.model, this.onValueChanged});

  @override
  State<StatefulWidget> createState() {
    return AuditTimeCellState();
  }

}

class AuditTimeCellState extends State<AuditTimeCell> {
  @override
  Widget build(BuildContext context) {
    
    var hourFormatter = DateFormat('HH:mm', 'en');

    var startAt = hourFormatter.format(TicksToDateTime(widget.model.StartTime));
    var endAt = hourFormatter.format(TicksToDateTime(widget.model.EndTime));
    if(endAt == "00:00") {
      endAt = "24:00";
    }
    
    var time = "";
    if(widget.model.DateType == 1) {

      for(int i = 0 ; i < widget.model.WeekDay.length ; i ++ ) {
        
        if(widget.model.WeekDay[i] == "1") {
          if(i == 0) {
            time += getLocaleCode() != "zh"? "Sun ": "周日 ";
          } else if(i == 1) {
            time += getLocaleCode() != "zh"? "Mon ": "周一 ";
          } else if(i == 2) {
            time += getLocaleCode() != "zh"? "Tue ": "周二 ";
          } else if(i == 3) {
            time += getLocaleCode() != "zh"? "Wed ": "周三 ";
          } else if(i == 4) {
            time += getLocaleCode() != "zh"? "Thu ": "周四 ";
          } else if(i == 5) {
            time += getLocaleCode() != "zh"? "Fri ": "周五 ";
          } else if(i == 6) {
            time += getLocaleCode() != "zh"? "Sat ": "周六 ";
          }
        }
      }
    } else {
      var dayFormatter = DateFormat('d/MM/y', 'en');
      time = dayFormatter.format(TicksToDateTime(widget.model.SpecialStartDate)) + " - " + dayFormatter.format(TicksToDateTime(widget.model.SpecialEndDate));
    }

    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text( startAt + " - " + endAt, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                  Text(time, style: TextStyle(fontSize: 14),)
                ],
              ),
            ),
          ),
          Container(
            child: new Switch(value: widget.model.EnableRule, onChanged: (bool value){
              setState(() {
                widget.model.EnableRule = value;
                if(widget.onValueChanged != null) {
                  widget.onValueChanged();
                }
              });
            }),
          )
        ],
      )
    );
  }

}