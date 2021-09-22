import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../service/serviceapi.dart';
import '../models/showing.dart';
import './shadow_decoration.dart';
import '../pages/appointment_calendar_page.dart';
import '../models/ui/plan_model.dart';
import '../pages/appointment_details_page.dart';


typedef OnRequestMessagePageRefresh = void Function(String errorMessage);

class MessageCell extends StatefulWidget {

  final ShowingRequestModel message;
  final OnRequestMessagePageRefresh onRequestMessagePageRefresh;
  final bool disable;
  final int MessageType;
  final bool isConflicted;
  MessageCell({this.message, this.disable = false, this.MessageType=0, this.onRequestMessagePageRefresh, this.isConflicted = false});

  @override
  State<StatefulWidget> createState() {
    return _MessageCellState();
  }

}

class _MessageCellState extends State<MessageCell> {


  var _declineReasonEditingController = TextEditingController();

  String _declineReason = "";

  @override
  void initState() {
    super.initState();

  }

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
    } else if(widget.message.RequestStatus == 3) {
      if(isPass) {
        stamp = Container(
          child:Image.asset('assets/icon_failed.png')
        );  
      } else {
        stamp = Container(
          child:Image.asset('assets/icon_waiting.png')
        );
      }
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
    String headerTitle = widget.MessageType ==0? widget.message.BuyerAgentName + "'s application": "Apply for " + widget.message.ClientName;
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
      child:InkWell(
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
          ),
          onTap: (){
            var model = ShowingRequestModelToPlanModel(widget.message);
            model.isMyHouse = widget.MessageType==0;
            Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailsPage(planModel: model, NeedRefreshHouseInfo:true)));
          }
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
      child:InkWell(
          child: Column(
            children: <Widget>[
              Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon_location.png'),
                      SizedBox(width: 10,),
                      Text(widget.message.AddressText, style: TextStyle(fontSize: 14, color: widget.disable ? Color(0xFFAAAAAA) : Color(0xFF333333)),)
                    ],
                  )
              ),
              SizedBox(height: 6,),
              Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon_mlsnumber.png'),
                      SizedBox(width: 10,),
                      Text("MSL@ Number: " + widget.message.MLSNumber, style: TextStyle(fontSize: 14, color: widget.disable ? Color(0xFFAAAAAA) : Color(0xFF333333)),)
                    ],
                  )
              ),
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
          onTap: (){
            var model = ShowingRequestModelToPlanModel(widget.message);
            model.isMyHouse = widget.MessageType==0;
            Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailsPage(planModel: model,NeedRefreshHouseInfo:true)));
          }
      )
    );
  }
  void UpdateShowingRequestStatus(BuildContext context, int RequestStatus) async
  {

    String reason = "";
    if(RequestStatus == 2 || RequestStatus == 1) {
      reason = await _requestCancelPrompt(context);
      if(reason == null) {
        return ;
      }
    }

    if(RequestStatus == 4) {
      if (await _requestPrompt(context,'Are you sure to cancel the application?')  == false) {
        return;
      }
    }

    widget.message.RequestStatus = RequestStatus;
    widget.message.ChangeReason = reason;
    bool bRet = await UserServerApi().UpdateShowingSchedule(context, [widget.message]);
    if(widget.onRequestMessagePageRefresh != null) {
      if(bRet) {
        widget.onRequestMessagePageRefresh(null);
      } 
    }
  }

  void _changeTimeAction(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentCalendarPage(
      initDateTime: TicksToDateTime(widget.message.ScheduledStartTime),
      houseModel: ShowingRequestModelToPlanModel(widget.message).house,
      onPickedTime: (startAt, endAt) async {
        widget.message.RequestStatus = 0;
        if(widget.MessageType==0)
          widget.message.RequestStatus = 3;
        widget.message.ScheduledStartTime = DateTimeToTicks(startAt);
        widget.message.ScheduledEndTime = DateTimeToTicks(endAt);
        bool bRet = await UserServerApi().UpdateShowingSchedule(context, [widget.message]);
        if(widget.onRequestMessagePageRefresh != null) {
          if(bRet) {
            widget.onRequestMessagePageRefresh(null);
          } 
        }
        
    },)));
  }

  Widget _buildMessageActions(BuildContext context) {
    List<Widget> childs = new List<Widget>();

    if(widget.MessageType==0)
    {
      switch(widget.message.RequestStatus)
      {
        case 0:///pending
        {
          childs.add(InkWell(
            child: Container(
              alignment: Alignment(0, 0),
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF536282) ),
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              height: 24,
              width: 80,
              child: Text("Agree", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
            ),
            onTap: () {
              UpdateShowingRequestStatus(context, 1);
            },
          ));
          childs.add(InkWell(
            child: Container(
              alignment: Alignment(0, 0),
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF536282) ),
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              height: 24,
                width: 80,
                child: Text("Decline", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
            ),
            onTap: () {
              UpdateShowingRequestStatus(context, 2);
            },
          ));
          childs.add(InkWell(
            child: Container(
              alignment: Alignment(0, 0),
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF536282) ),
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              height: 24,
                width: 80,
                child: Text("Change", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
            ),
            onTap: () {
              _changeTimeAction(context);
            },
          ));
        }
        break;
        case 1:///Approved
          {
            childs.add(InkWell(
              child: Container(
                alignment: Alignment(0, 0),
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF536282) ),
                borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                height: 24,
                  width: 80,
                  child: Text("Decline", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                UpdateShowingRequestStatus(context, 2);
              },
            ));
            childs.add(InkWell(
              child: Container(
                alignment: Alignment(0, 0),
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF536282) ),
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                height: 24,
                width: 80,
                child: Text("Change", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                _changeTimeAction(context);
              },
            ));
          }
          break;
        case 2:///Rejected
          {
          }
          break;
        case 3:///TimeChanged
          {
            childs.add(InkWell(
              child: Container(
                alignment: Alignment(0, 0),
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF536282) ),
                borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                height: 24,
                  width: 80,
                  child: Text("Decline", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                UpdateShowingRequestStatus(context, 2);
              },
            ));
          }
          break;
        case 4:///Cancelled
          {
          }
          break;
        default:
          break;
      }
    }
    else
    {
      switch(widget.message.RequestStatus)
      {
        case 0:///pending
          {
            childs.add(InkWell(
              child: Container(
                  alignment: Alignment(0, 0),
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF536282) ),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  height: 24,
                  width: 80,
                  child: Text("Change", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                _changeTimeAction(context);
              },
            ));
            childs.add(InkWell(
              child: Container(
                alignment: Alignment(0, 0),
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF536282) ),
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                height: 24,
                  width: 80,
                  child: Text("Cancel", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                UpdateShowingRequestStatus(context, 4);
              },
            ));
          }
          break;
        case 1:///Approved
          {
            childs.add(InkWell(
              child: Container(
                  alignment: Alignment(0, 0),
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF536282) ),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  height: 24,
                  width: 80,
                  child: Text("Change", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                _changeTimeAction(context);
              },
            ));
            childs.add(InkWell(
              child: Container(
                alignment: Alignment(0, 0),
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF536282) ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  height: 24,
                  width: 80,
                  child: Text("Cancel", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                UpdateShowingRequestStatus(context, 4);
              },
            ));
          }
          break;
        case 2:///Rejected
          {
            childs.add(InkWell(
              child: Container(
                alignment: Alignment(0, 0),
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF536282) ),
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                height: 24,
                  width: 80,
                  child: Text("Change", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                _changeTimeAction(context);
              },
            ));
          }
          break;
        case 3:///TimeChanged
          {
            childs.add(InkWell(
              child: Container(
                alignment: Alignment(0, 0),
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF536282) ),
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                height: 24,
                  width: 80,
                  child: Text("Accept", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                UpdateShowingRequestStatus(context, 1);
              },
            ));
            childs.add(InkWell(
              child: Container(
                alignment: Alignment(0, 0),
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF536282) ),
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                height: 24,
                  width: 80,
                  child: Text("Change", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                _changeTimeAction(context);
              },
            ));
            childs.add(InkWell(
              child: Container(
                  alignment: Alignment(0, 0),
                  margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF536282) ),
                  borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  height: 24,
                  width: 80,
                  child: Text("Cancel", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
              ),
              onTap: () {
                UpdateShowingRequestStatus(context, 4);
              },
            ));

          }
          break;
        case 4:///Cancelled
          {
          }
          break;
        default:
          break;
      }
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


  Future<String> _requestCancelPrompt(BuildContext context) async {
    var node = new FocusNode();
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            height: 270,
            width: 315,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text("Any message want to leave to them ?"),
                ),
                
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: TextField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      border: InputBorder.none
                    ),
                    controller: _declineReasonEditingController,
                    onChanged: (str) {
                      _declineReason = str;
                    },
                    onSubmitted: (text) {
                      FocusScope.of(context).reparentIfNeeded(node);
                    }
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        var text = _declineReasonEditingController.text;
                        Navigator.of(context).pop(text);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                          )
                        ),
                        alignment: AlignmentDirectional.center,
                        width: 200,
                        child: Text("Continue"),
                      )
                    ),
                  ]
                )
              ]
            )
          )
        );
      },
    );
  }

  Future<bool> _requestPrompt(BuildContext context, String message) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
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