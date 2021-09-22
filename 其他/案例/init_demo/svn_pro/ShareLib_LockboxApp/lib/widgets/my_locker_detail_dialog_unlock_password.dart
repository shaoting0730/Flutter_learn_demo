import 'package:flutter/material.dart';
import '../service/baseapi.dart';
import '../service/serviceapi.dart';
import '../models/iotdevice.dart';

typedef MyLockerDetailDialogUnlockPasswordCancel = void Function();
typedef MyLockerDetailDialogUnlockPasswordBluetoothUnlock = void Function();
typedef MyLockerDetailDialogUnlockPasswordPasswordbyShortMessage = void Function();

class MyLockerDetailDialogUnlockPassword extends StatefulWidget {

  final MyLockerDetailDialogUnlockPasswordCancel myLockerDetailDialogUnlockPasswordCancel;
  final MyLockerDetailDialogUnlockPasswordBluetoothUnlock myLockerDetailDialogUnlockPasswordBluetoothUnlock;
  final MyLockerDetailDialogUnlockPasswordPasswordbyShortMessage myLockerDetailDialogUnlockPasswordPasswordbyShortMessage;
  final bool isOpenDoor;
  final String macAddress;
  final bool displayPasswordByShortMessage;
  MyLockerDetailDialogUnlockPassword({this.isOpenDoor, this.macAddress, this.myLockerDetailDialogUnlockPasswordCancel, this.myLockerDetailDialogUnlockPasswordBluetoothUnlock, this.myLockerDetailDialogUnlockPasswordPasswordbyShortMessage, this.displayPasswordByShortMessage = true});

  @override
  State<StatefulWidget> createState() {
    return MyLockerDetailDialogUnlockPasswordState();
  }

}

class MyLockerDetailDialogUnlockPasswordState extends State<MyLockerDetailDialogUnlockPassword> with TickerProviderStateMixin {
  
  String password = _localizedValues[getLocaleCode()]["password_placeholder"];
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'password_placeholder':'Showing...',
      'unlock_password':'Unlock Password',
      'description':"Please enter your password manually",
      'description_2':'Please wait patiently',
      'bluetooth_unlock':'Bluetooth unlock'
    },
    'zh': {
      'password_placeholder':'显示中...',
      'unlock_password':'开锁密码',
      'description':"请手动输入密码",
      'description_2':'请耐心等待',
      'bluetooth_unlock':'蓝牙开锁'
    },
  };

  @override
  void initState() {
    super.initState();

    requestPassword();
  }

  void requestPassword() async {
    IOTDeviceRealTimeInfoModel request = new IOTDeviceRealTimeInfoModel();
    request.IsOpenHook = !widget.isOpenDoor ;
    request.DeviceMACAddress = widget.macAddress;
    request.DeviceLongitude = 0;
    request.DeviceLatitude = 0;
    request.DoorStatus = 0;
    request.PowerPercentage = 0;
    
    var res = await UserServerApi().RetrieveIOTDevicePassword(context, request);
    if(res != null && mounted) {
      setState(() {
        password = res.Password;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    var list = <Widget>[
      InkWell(
        onTap: () {
          if(widget.myLockerDetailDialogUnlockPasswordCancel != null) {
            widget.myLockerDetailDialogUnlockPasswordCancel();
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
      Text(_localizedValues[getLocaleCode()]["unlock_password"], style: TextStyle(fontSize: 24, color: Colors.white),),
      SizedBox(height: 25,),
      Text(password, style: TextStyle(fontSize: 36, color: Colors.white),),
      SizedBox(height: 45,),          
      Text(_localizedValues[getLocaleCode()]["description"], style: TextStyle(fontSize: 14, color: Colors.white),),
      SizedBox(height: 8,),
      Text(_localizedValues[getLocaleCode()]["description_2"], style: TextStyle(fontSize: 14, color: Colors.white),),
      SizedBox(height: 8,),
      InkWell(
        onTap: () {
          if(widget.myLockerDetailDialogUnlockPasswordBluetoothUnlock != null) {
            widget.myLockerDetailDialogUnlockPasswordBluetoothUnlock();
          }
        },
        child: Container(
          height: 40,
          alignment: AlignmentDirectional.center,
          child: Text(_localizedValues[getLocaleCode()]["bluetooth_unlock"], style: TextStyle(fontSize: 16, color: Colors.white, decoration: TextDecoration.underline))
        )
      ),
    ];

    if(false) {
      list.add(
        InkWell(
          onTap: () {
            if(widget.myLockerDetailDialogUnlockPasswordPasswordbyShortMessage != null) {
              widget.myLockerDetailDialogUnlockPasswordPasswordbyShortMessage();
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
      height: 300,
      width: 320,
      child: Column(
        children: list
      ),
    );
  }
  
}