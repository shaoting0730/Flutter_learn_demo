import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../service/baseapi.dart';
import './avatar.dart';
import '../models/iotdevice.dart';
import 'shadow_decoration.dart';
import '../service/serviceapi.dart';

class LockerAuthorizationManagementListCell extends StatefulWidget {
  final LockBoxDevicePermissionModel model;

  LockerAuthorizationManagementListCell({this.model});

  @override
  State<StatefulWidget> createState() {
    return LockerAuthorizationMangementListCellState();
  }

}

class LockerAuthorizationMangementListCellState extends State<LockerAuthorizationManagementListCell> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: shadowDecoration(),
      child: Column(
        children: <Widget>[
          _buildHeadView(),
          _buildTimeHead()
        ],
      ),
    );
  }

  Widget _buildHeadView() {
    return Container(
      child: Row(
        children: <Widget>[
          Avatar(avatar: widget.model.AvatorLogoUrl,),
          SizedBox(width: 10,),
          Expanded(child: 
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: Color(0xFFE0E0E0)))
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.model.FirstName + " " + widget.model.LastName, style: TextStyle(fontSize: 14, color: Color(0xFF536282))),
                          SizedBox(height: 5,),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Image.asset('assets/icon_phone.png'),
                                SizedBox(width: 5,),
                                Text(widget.model.SharedToPhoneNumber, style: TextStyle(fontSize: 14, color: Color(0xFFAAAAAA)))
                              ]
                            ),
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),
                    )
                  ),
                ],
              ),  
            )
          ),

        ],
      ),
    );
  }

  Widget _buildTimeHead() {

    var list = List<Widget>();
    widget.model.PermissionTimeList.forEach((element) {
      if(element.EnableRule) {
        list.add(_buildText(element));
      }
    });

    return Container(
      padding: const EdgeInsets.fromLTRB(48, 10, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/icon_calendar_gray.png'),
          SizedBox(width: 5,),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list,
            ),
          )
        ]
      )
    );
  }

  Widget _buildText(LockBoxDevicePermissionTimeModel model) {
    var hourFormatter = DateFormat('HH:mm', 'en');

    var startAt = hourFormatter.format(TicksToDateTime(model.StartTime));
    var endAt = hourFormatter.format(TicksToDateTime(model.EndTime));
    if(endAt == "00:00") {
      endAt = "24:00";
    }
    
    var time = "";
    if(model.DateType == 1) {

      for(int i = 0 ; i < model.WeekDay.length ; i ++ ) {
        
        if(model.WeekDay[i] == "1") {
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

        if(model.WeekDay == "1111111") {
          time = getLocaleCode() != "en"? "每天": "Everyday";
        }
      }
    } else {
      var dayFormatter = DateFormat('d/MM/y', 'en');
      time = dayFormatter.format(TicksToDateTime(model.SpecialStartDate)) + " - " + dayFormatter.format(TicksToDateTime(model.SpecialEndDate));
    }


    return Container(
      width: MediaQuery.of(context).size.width - 130,
      child:Text(startAt + " - " + endAt + "  " + time, style: TextStyle(fontSize: 13, color: Color(0xFF536282)),maxLines: 2, )
    );
  }

}