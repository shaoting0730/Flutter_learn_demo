import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../service/serviceapi.dart';
import '../models/showing.dart';
import './shadow_decoration.dart';
import '../pages/appointment_calendar_page.dart';
import '../models/ui/plan_model.dart';


typedef OnRequestPageRefresh = void Function(String errorMessage);

class ApplicationCell extends StatefulWidget {

  final ShowingRequestModel message;
  final OnRequestPageRefresh onRequestPageRefresh;
  final bool disable;
  final bool isConflicted;
  final bool isShowCustomerName;
  ApplicationCell({this.message, this.disable = false, this.onRequestPageRefresh, this.isConflicted = false, this.isShowCustomerName = false});

  @override
  State<StatefulWidget> createState() {
    return ApplicationCellState();
  }

}

class ApplicationCellState extends State<ApplicationCell> {

  
  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = <Widget>[
      _buildMessageHeader(context),
      SizedBox(height: 10,),
      _buildMessageBody(context),
    ];

    if(widget.disable == false) {
      widgets.add(SizedBox(height: 15));
      widgets.add(_buildMessageActions(context));
    }

    bool isPass =  TicksToDateTime(widget.message.ScheduledEndTime).microsecondsSinceEpoch < DateTime.now().microsecondsSinceEpoch;

    var stamp = Container(
      width: 1,
      height: 1,
    );
    if(widget.message.RequestStatus == 0) {
      if(isPass) {
        stamp = Container(
          child:Image.asset('assets/icon_failed.png')
        );  
      }
    } else if (widget.message.RequestStatus == 1) {
      stamp = Container(
        child:Image.asset('assets/icon_agree.png')
      );
    } else if(widget.message.RequestStatus == 2) {
      stamp = Container(
        child:Image.asset('assets/icon_decline.png')
      );
    } else {
      stamp = Container(
        child:Image.asset('assets/icon_failed.png')
      );
    }

    
    Color backgroundColor = isPass ? Color(0x11000000): Colors.transparent;
    
    return Stack(
      children: <Widget>[
        Container(
          decoration: shadowDecoration(),
          margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(15),
            child:Column(
              children: widgets
            )
          ),    
        ),
        Positioned(
          bottom: 0, 
          right: 15, 
          child: stamp,
        ),
      ],
    );
  }

  Widget _buildMessageHeader(BuildContext context) {
    String headerTitle =  "Apply for " + (widget.isShowCustomerName ? widget.message.ClientName:widget.message.BuyerAgentName);
    String status;
    if(widget.message.RequestStatus == 0) {
      bool isPass =  TicksToDateTime(widget.message.ScheduledEndTime).microsecondsSinceEpoch < DateTime.now().microsecondsSinceEpoch;
      if(isPass) {
        status = "Failed";
      } else {
        status = "Waiting";
      }
    } else if (widget.message.RequestStatus == 1) {
      status = "Confirmed";
    } else if(widget.message.RequestStatus == 2) {
      status = "Decline";
    } else if(widget.message.RequestStatus == 3) {
      status = "Time Changed";
    } else if(widget.message.RequestStatus == 4) {
      status = "Canclled";
    }

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(headerTitle, style: TextStyle(fontSize: 14, color: widget.disable ? Color(0xFFAAAAAA) : Color(0xFF333333)))
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text(status, style: TextStyle(fontSize: 14, color: widget.disable ? Color(0xFFAAAAAA) : Color(0xFF6E7B96)),)
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildMessageBody(BuildContext context) {
    var format = new DateFormat('E d/MM/y', 'en');
    var hourFormatter = DateFormat('HH:mm', 'en');
    var date = format.format(TicksToDateTime(widget.message.ScheduledStartTime));
    var startAt = hourFormatter.format(TicksToDateTime(widget.message.ScheduledStartTime));
    var endAt = hourFormatter.format(TicksToDateTime(widget.message.ScheduledEndTime));

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 6,),
          Container(
            child: Row(
              children: <Widget>[
                Image.asset('assets/icon_calendar.png'), 
                SizedBox(width: 10,),
                Text(date + ' From ' + startAt + ' To '+ endAt, style: TextStyle(fontSize: 14, color: widget.disable ? Color(0xFFAAAAAA) : Color(0xFF333333)),)
              ],
            )
          ),
        ],
      ),
    );
  }
  void UpdateShowingRequestStatus(BuildContext context, int RequestStatus) async
  {

    if(RequestStatus == 4) {
      if (await _cancelRequestPrompt(context)  == false) {
        return;
      }
    }

    widget.message.RequestStatus = RequestStatus;
    bool bRet = await UserServerApi().UpdateShowingSchedule(context, [widget.message]);
    if(widget.onRequestPageRefresh != null) {
      if(bRet) {
        widget.onRequestPageRefresh(null);
      } 
    }
  }

  void _changeTimeAction(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentCalendarPage(
      initDateTime: TicksToDateTime(widget.message.ScheduledStartTime),
      houseModel: ShowingRequestModelToPlanModel(widget.message).house,
      onPickedTime: (startAt, endAt) async {
        widget.message.RequestStatus = 0;
        widget.message.ScheduledStartTime = DateTimeToTicks(startAt);
        widget.message.ScheduledEndTime = DateTimeToTicks(endAt);
        bool bRet = await UserServerApi().UpdateShowingSchedule(context, [widget.message]);
        if(widget.onRequestPageRefresh != null) {
          if(bRet) {
            widget.onRequestPageRefresh(null);
          } 
        }
        
    },)));
  }

  Widget _buildMessageActions(BuildContext context) {
    List<Widget> childs = new List<Widget>();
   
    switch(widget.message.RequestStatus)
    {
      case 0:///pending
        {
          childs.add(_actionButtonCancel());
          childs.add(_actionButtonChangeTime());
        }
        break;
      case 1:///Approved
        {
          childs.add(_actionButtonCancel());
        }
        break;
      case 2:///Rejected
        {
          childs.add(_actionButtonChangeTime());
        }
        break;
      case 3:///TimeChanged
        {
          childs.add(_actionButtonChangeTime());
          childs.add(_actionButtonCancel());

        }
        break;
      case 4:///Cancelled
        {
        }
        break;
      default:
        break;
    }

  

    if(TicksToDateTime(widget.message.ScheduledEndTime).microsecondsSinceEpoch < DateTime.now().microsecondsSinceEpoch) {
      childs = [];
    }
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      child: Wrap(
        runSpacing: 5,
        alignment: WrapAlignment.end,
        runAlignment: WrapAlignment.end,
        children:  childs,
      ),
    );
  }

  Widget _actionButtonCancel() {
    return InkWell(
      child: Container(
          alignment: Alignment(0, 0),
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF536282) ),
          borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          height: 24,
          width: 100,
          child: Text("Cancel", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
      ),
      onTap: () {
        UpdateShowingRequestStatus(context, 4);
      },
    );
  }

  Widget _actionButtonChangeTime() {
    return InkWell(
      child: Container(
        alignment: Alignment(0, 0),
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF536282) ),
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        height: 24,
          width: 100,
          child: Text("Change Time", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
      ),
      onTap: () {
        _changeTimeAction(context);
      },
    );
  }


  Future<bool> _cancelRequestPrompt(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure to cancel the application?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: const Text('YES'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }

}