import 'package:flutter/material.dart';
import '../service/baseapi.dart';

typedef MyLockerDetailDialogFailedViewAccessCode = void Function();
typedef MyLockerDetailDialogFailedClose = void Function();

class MyLockerDetailDialogFailed extends StatefulWidget {

  final MyLockerDetailDialogFailedViewAccessCode myLockerDetailDialogFailedViewAccessCode;
  final MyLockerDetailDialogFailedClose myLockerDetailDialogFailedClose;
  MyLockerDetailDialogFailed({this.myLockerDetailDialogFailedViewAccessCode, this.myLockerDetailDialogFailedClose});

  @override
  State<StatefulWidget> createState() {
    return MyLockerDetailDialogFailedState();
  }

}

class MyLockerDetailDialogFailedState extends State<MyLockerDetailDialogFailed>  {
  
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'failed':'Failed',
      'failed_to_open':'Failed to open the lock',
      'description':"Please make sure that the lock is in good condition!",
      'view_access_code':'View Access Code'
    },
    'zh': {
      'failed':'失败',
      'failed_to_open':'打开锁失败',
      'description':"请确保锁是在一个比较好的状态",
      'view_access_code':'查看访问密码'
    },
  };

  @override
  Widget build(BuildContext context) {
    
    List<Widget> children = List<Widget>();
    children.add(
      InkWell(
        onTap: () {
          if(widget.myLockerDetailDialogFailedClose  != null) {
            widget.myLockerDetailDialogFailedClose();
          }
        },
        child: Container(
          alignment: AlignmentDirectional.centerEnd,
          height: 40,
          child: Image.asset('assets/icon_dialog_close.png'),
        )
      ),
    );
    children.add(Text(_localizedValues[getLocaleCode()]["failed"], style: TextStyle(fontSize: 24, color: Colors.white),));
    children.add(SizedBox(height: 20,));
    children.add(Image.asset('assets/ico_lock_open_failed.png'));
    children.add(SizedBox(height: 20,));
    children.add(Text(_localizedValues[getLocaleCode()]["failed_to_open"], style: TextStyle(fontSize: 14, color: Colors.white),));
    children.add(SizedBox(height: 8,));
    children.add(Text(_localizedValues[getLocaleCode()]["description"], style: TextStyle(fontSize: 14, color: Colors.white),textAlign: TextAlign.center,));
    children.add(InkWell(
      onTap: () {
        if(widget.myLockerDetailDialogFailedViewAccessCode != null) {
          widget.myLockerDetailDialogFailedViewAccessCode();
        }
      },
      child: Container(
        height: 40,
        alignment: AlignmentDirectional.center,
        child: Text(_localizedValues[getLocaleCode()]["view_access_code"], style: TextStyle(fontSize: 16, color: Colors.white, decoration: TextDecoration.underline))
      )
    ));

    children.add(SizedBox(height: 20,));
    children.add(InkWell(
        onTap: () {
          if(widget.myLockerDetailDialogFailedViewAccessCode  != null) {
            widget.myLockerDetailDialogFailedViewAccessCode();
          }
        },
        child: Container(
            height: 40,
            alignment: AlignmentDirectional.center,
            child: Text('Ok', style: TextStyle(fontSize: 16, color: Colors.white, decoration: TextDecoration.underline))
        )
    ));
    return Container(
      color: Color(0xFF536282),
      height: 420,
      width: 320,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children
      ),
    );
  }
  
}