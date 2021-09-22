import 'package:flutter/material.dart';

import '../service/baseapi.dart';

typedef MyLockerDetailDialogOpeningCancel = void Function();
typedef MyLockerDetailDialogOpeningViewAccessCode = void Function();
typedef MyLockerDetailDialogOpeningPasswordByShortMessage = void Function();

class MyLockerDetailDialogOpening extends StatefulWidget {

  final MyLockerDetailDialogOpeningCancel myLockerDetailDialogOpeningCancel;
  final MyLockerDetailDialogOpeningViewAccessCode myLockerDetailDialogOpeningViewAccessCode;
  final MyLockerDetailDialogOpeningPasswordByShortMessage myLockerDetailDialogOpeningPasswordByShortMessage;
  final bool isOpenDoor;
  final String macAddress;
  final bool displayPasswordByShortMessage;
  MyLockerDetailDialogOpening({this.myLockerDetailDialogOpeningCancel, this.myLockerDetailDialogOpeningViewAccessCode, this.myLockerDetailDialogOpeningPasswordByShortMessage, this.isOpenDoor, this.macAddress, this.displayPasswordByShortMessage = true});

  @override
  State<StatefulWidget> createState() {
    return MyLockerDetailDialogOpeningState();
  }

}

class MyLockerDetailDialogOpeningState extends State<MyLockerDetailDialogOpening> with TickerProviderStateMixin {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'opening':'Opening',
      'ready':'Ready to be opened',
      'wait':'Please wait patiently',
      'view_access_code':'View Access Code'
    },
    'zh': {
      'opening':'打开中',
      'ready':'准备打开中',
      'wait':'请耐心等候',
      'view_access_code':'查看访问密码'
    },
  };

  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500000),
      vsync: this,
    );

    _controller.forward();
  }

   @override
  void dispose() {
    _controller.reset();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {

    var list = <Widget>[
      InkWell(
        onTap: () {
          if(widget.myLockerDetailDialogOpeningCancel != null) {
            widget.myLockerDetailDialogOpeningCancel();
          }
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: AlignmentDirectional.bottomEnd,
          width: 320,
          height: 20,
          child: Image.asset('assets/icon_dialog_close.png'),
        )
      ),
      SizedBox(height: 10,),
      Text(_localizedValues[getLocaleCode()]["opening"], style: TextStyle(fontSize: 24, color: Colors.white),),
      SizedBox(height: 25,),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ico_lock_opening.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: 119,
        width: 119,
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 100.0).animate(_controller),
          child: Image.asset("assets/ico_lock_opening_circle.png"),
        )
      ),
      SizedBox(height: 20,),
      Text(_localizedValues[getLocaleCode()]["ready"], style: TextStyle(fontSize: 14, color: Colors.white),),
      SizedBox(height: 8,),
      Text(_localizedValues[getLocaleCode()]["wait"], style: TextStyle(fontSize: 14, color: Colors.white),),
      SizedBox(height: 8,),
      InkWell(
        onTap: () {
          if(widget.myLockerDetailDialogOpeningViewAccessCode  != null) {
            widget.myLockerDetailDialogOpeningViewAccessCode();
          }
        },
        child: Container(
          height: 40,
          alignment: AlignmentDirectional.center,
          child: Text(_localizedValues[getLocaleCode()]["view_access_code"], style: TextStyle(fontSize: 16, color: Colors.white, decoration: TextDecoration.underline))
        )
      ),
      
    ];

    if(false) {
      list.add  (
        InkWell(
          onTap: () {
            if(widget.myLockerDetailDialogOpeningPasswordByShortMessage  != null) {
              widget.myLockerDetailDialogOpeningPasswordByShortMessage();
            }
          },
          child: Container(
            height: 40,
            alignment: AlignmentDirectional.center,
            child: Text('Password by Short Message', style: TextStyle(fontSize: 16, color: Colors.white, decoration: TextDecoration.underline))
          )
        )
      );
    }

    return Container(
      color: Color(0xFF536282),
      height: 335,
      width: 320,
      child: Column(
        children: list
      ),
    );
  }
  
}