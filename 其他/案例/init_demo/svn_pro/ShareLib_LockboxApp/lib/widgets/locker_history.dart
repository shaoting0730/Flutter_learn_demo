import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/iotdevice.dart';
import '../service/baseapi.dart';
import '../service/serviceapi.dart';

class LockerHistory extends StatefulWidget {
  final List<LockBoxDeviceOpenRecordModel> OpenRecordList;
  LockerHistory({this.OpenRecordList});
  @override
  State<LockerHistory> createState() {
    return LockerHistoryState();
  }

}

class LockerHistoryState extends State<LockerHistory> {
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'opened':" opened ",
      'hook':'the lock hook',
      'box':"the lock box",
      'battery':" and Battery is ",
      'left': "% Left"
    },
    'zh': {
      'opened':"打开了",
      'hook':'锁柄',
      'box':"锁盒",
      'battery':", 剩下电量为：",
      'left': "%"
    },
  };

  @override
  Widget build(BuildContext context) {
    if(widget.OpenRecordList==null)
      return Container();
    if(widget.OpenRecordList.length==0)
      return Container();
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
      child: ListView.builder(
        itemCount: widget.OpenRecordList.length,
        itemBuilder: (BuildContext context, int index) {
          var format = getLocaleCode() == "en" ? DateFormat('E d/MM/y', 'en') : DateFormat('E y/MM/d', 'zh');
          var hourFormatter = DateFormat('HH:mm', 'en');
          var date = format.format(TicksToDateTime(widget.OpenRecordList[index].UpdatedOn));
          var startAt = hourFormatter.format(TicksToDateTime(widget.OpenRecordList[index].UpdatedOn));

          return Container(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(date, style: TextStyle(fontSize: 12, color: Color(0xFFAAAAAA), fontWeight: FontWeight.w600),),
                      Text(startAt, style: TextStyle(fontSize: 12, color: Color(0xFFAAAAAA), fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Color(0xFF536282),
                          borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(0xFFE1E1E1),
                          width: 1,
                        )
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    child: Text(widget.OpenRecordList[index].OpenedBy+  _localizedValues[getLocaleCode()]["opened"] + (widget.OpenRecordList[index].IsOpenHook ? _localizedValues[getLocaleCode()]["hook"]:_localizedValues[getLocaleCode()]["box"])),//// + _localizedValues[getLocaleCode()]["battery"] + widget.OpenRecordList[index].PowerPercentage.toString()+ _localizedValues[getLocaleCode()]["left"]),
                  )
                )
              ],
            ),

          );
        }
      )
    );
  }

}