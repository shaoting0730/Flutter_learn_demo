import 'package:flutter/material.dart';

import '../service/baseapi.dart';

typedef MyLockerDetailDialogOpenedOk = void Function();

class MyLockerDetailDialogOpened extends StatefulWidget {

  final MyLockerDetailDialogOpenedOk myLockerDetailDialogOpenedOk;
  final bool isHookOpened;

  MyLockerDetailDialogOpened({this.myLockerDetailDialogOpenedOk, this.isHookOpened = false});

  @override
  State<StatefulWidget> createState() {
    return MyLockerDetailDialogOpenedState();
  }

}

class MyLockerDetailDialogOpenedState extends State<MyLockerDetailDialogOpened> with TickerProviderStateMixin {
  
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'opened':'Opened',
      'ready':'Ready to be opened',
      'wait':'Please wait patiently',
      'view_access_code':'View Access Code',
      'description_hook_1': 'The lock hook has been opened.',
      'description_hook_2': 'Lock and hook have been separated, remember to return after use.',
      'description_box_1': 'The lock box has been opened.',
      'description_box_2': "Don't forget to return the key to its original position.",
    },
    'zh': {
      'opened':'已打开',
      'ready':'准备打开中',
      'wait':'请耐心等候',
      'view_access_code':'查看访问密码',
      'description_hook_1': '锁已经打开了',
      'description_hook_2': '锁柄和盒子分离，使用完后请记得复原',
      'description_box_1': '锁盒已经打开了',
      'description_box_2': "请不要忘记归还锁",
    },
  };

  @override
  Widget build(BuildContext context) {

    var icon = widget.isHookOpened? "assets/ico_lockhandle_opened.png": "assets/ico_lockbox_opened.png";
    var title = widget.isHookOpened? _localizedValues[getLocaleCode()]["description_hook_1"]: _localizedValues[getLocaleCode()]["description_box_1"];
    var description = widget.isHookOpened? _localizedValues[getLocaleCode()]["description_hook_2"]: _localizedValues[getLocaleCode()]["description_box_2"];
    return Container(
      color: Color(0xFF536282),
      height: 400,
      width: 320,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 33,),
          Text(_localizedValues[getLocaleCode()]["opened"], style: TextStyle(fontSize: 24, color: Colors.white),),
          SizedBox(height: 25,),
          Image.asset(icon),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.white),textAlign: TextAlign.center,),
          SizedBox(height: 8,),
          Text(description, style: TextStyle(fontSize: 14, color: Colors.white),textAlign: TextAlign.center,),
          SizedBox(height: 40,),
          InkWell(
            onTap: () {
              if(widget.myLockerDetailDialogOpenedOk  != null) {
                widget.myLockerDetailDialogOpenedOk();
              }
            },
            child: Container(
              height: 40,
              alignment: AlignmentDirectional.center,
              child: Text('Ok', style: TextStyle(fontSize: 16, color: Colors.white, decoration: TextDecoration.underline))
            )
          )
        ]
      ),
    );
  }
  
}