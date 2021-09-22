import 'package:flutter/material.dart';
import '../models/iotdevice.dart';
import '../service/baseapi.dart';
import '../pages/authorized_mobile_account_page.dart';

typedef OnDismissed = void Function(IOTDeviceInfoModel model);
class MyLockerCell extends StatefulWidget {
  final IOTDeviceInfoModel lockerModel;
  final bool roundCorner;
  final OnDismissed onDismissed;
  final bool displaySharePWD;
  final bool displayDueTime;
  final bool displayAuthor;
  MyLockerCell({ this.lockerModel, this.displaySharePWD = false, this.roundCorner = true, this.onDismissed, this.displayDueTime = false, this.displayAuthor = false});

  @override
  State<MyLockerCell> createState() {
    return MyLockerCellState();
  }

}

class MyLockerCellState extends State<MyLockerCell> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'authorizer':'Authorizer',
      'sharebysms':"Share\r\nPassword",
      'message_unlockhook':'The unlock hook password has been sent to your mobile phone through the SMS verification code, pay attention to check.',
      'message_unlockdoor':'The unlock door password has been sent to your mobile phone through the SMS verification code, pay attention to check.'
    },
    'zh': {
      'authorizer':'授权人',
      'sharebysms':"分享\r\n密码",
      'message_unlockhook':'您指定时间的开锁钩密码已经通过短信的方式发给了对方手机，请注意查收.',
      'message_unlockdoor':'您指定时间的开锁盒密码已经通过短信的方式发给了对方手机，请注意查收'
    },
  };
  void _showPasswordSendOutdialog(BuildContext context, bool isOpenDoor) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // return object of type Dialog
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Container(
                height: 160,
                width: 200,
                child: Column(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Text((isOpenDoor? _localizedValues[getLocaleCode()]["message_unlockdoor"]: _localizedValues[getLocaleCode()]["message_unlockhook"]), style: TextStyle(fontSize: 14), textAlign: TextAlign.center,)
                      ),

                      InkWell(
                          onTap: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child:  Container(
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
                            child: Text("Ok"),
                          )
                      ),
                    ]
                )
            )
        );
      },
    );
  }

  Widget _buildSharePassword() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8) )
        ),
        width: 80,
        height: 80,
        child: InkWell(
            onTap: () {
              Navigator.push(context,  MaterialPageRoute(builder: (context) => AuthorizedMobileAccountPage(isOpenDoor: false, macAddress: widget.lockerModel.DeviceMACAddress, deviceGuid: widget.lockerModel.Guid, authorizedMobileAccountPageSendOut: (){
                _showPasswordSendOutdialog(context, true);
              },)));
            },
            child: Container(
                height: 40,
                alignment: AlignmentDirectional.center,
                child: Text(_localizedValues[getLocaleCode()]["sharebysms"], style: TextStyle(color: Color(0xFF536282)),),
            )
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> controls = new List<Widget>();
    controls.add(_buildLockerIcon());
    controls.add(SizedBox(width: 20,));
    controls.add(_buildLockInformation());
    if(widget.displaySharePWD)
    {
      controls.add(_buildSharePassword());
      /*
     controls.add(MaterialButton(
          child: Text(_localizedValues[getLocaleCode()]["sharebysms"], style: TextStyle(color: Color(0xFF536282)),),
          onPressed: () {
            Navigator.push(context,  MaterialPageRoute(builder: (context) => AuthorizedMobileAccountPage(isOpenDoor: false, macAddress: widget.lockerModel.DeviceMACAddress, deviceGuid: widget.lockerModel.Guid, authorizedMobileAccountPageSendOut: (){
              _showPasswordSendOutdialog(context, true);
            },)));
          },
          color: Colors.white,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Color(0xFF536282),)
          )));
      controls.add(InkWell(
          onTap: () {
            Navigator.push(context,  MaterialPageRoute(builder: (context) => AuthorizedMobileAccountPage(isOpenDoor: false, macAddress: widget.lockerModel.DeviceMACAddress, deviceGuid: widget.lockerModel.Guid, authorizedMobileAccountPageSendOut: (){
              _showPasswordSendOutdialog(context, true);
            },)));
          },
          child: Container(
              height: 40,
              alignment: AlignmentDirectional.center,
              child: Text(_localizedValues[getLocaleCode()]["sharebysms"], style: TextStyle(fontSize: 16, color: Colors.white, decoration: TextDecoration.underline))
          )
      ));
       */
    }
    return
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Color(0xFF536282)
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Container(
        child: Row(
          children: controls,
        ),
      ),
    );
  }

  Widget _buildLockInformation() {
    String title = widget.lockerModel.DeviceName;

    var list = <Widget>[
      Text(title, style: TextStyle(fontSize: 14, color: Color(0xFF333333), fontWeight: FontWeight.w600),),
    ];

    if(widget.lockerModel.Description != null && widget.lockerModel.Description != "") {
      list.add(SizedBox(height: 5,));
      list.add(Text(widget.lockerModel.Description, style: TextStyle(fontSize: 13, color: Color(0xFF999999)), overflow: TextOverflow.ellipsis));
    }
    

    if(widget.displayAuthor ) {
      list.add(SizedBox(height: 5,));
      list.add(Text(_localizedValues[getLocaleCode()]["authorizer"] + ": " + (widget.lockerModel.MasterUserName != null && widget.lockerModel.MasterUserName != "" ? widget.lockerModel.MasterUserName: "N/A"), style: TextStyle(fontSize: 13, color: Color(0xFF999999)), overflow: TextOverflow.ellipsis));
    }


    if(widget.displayDueTime) {
      list.add(
        Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/icon_calendar_gray.png'),
              SizedBox(width: 5,),
              Container(
                width: MediaQuery.of(context).size.width - 200,
                child: Text(widget.lockerModel.AccessInstruction == null ? "Unknown schedule": widget.lockerModel.AccessInstruction, style: TextStyle(fontSize: 13, color: Color(0xFF536282)), overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, maxLines: 2,),
              )
            ],
          ),)
      );
    }
    return Expanded(
      child:Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: list
        ),
      )
    );
  }

  Widget _buildLockerIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFDADDE2),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8) )
      ),
      width: 100,
      height: 100,
      child: Image.asset('assets/ico_home_lock_white.png',)
    );
  }

}