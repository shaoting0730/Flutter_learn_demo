import 'package:flutter/material.dart';
import '../bluetooth/locker.dart';
import '../bluetooth/bluetoothUtility.dart';
import './shadow_decoration.dart';
import '../pages/base_page.dart';
import '../service/baseapi.dart';

class ScanNewLockboxItemCell extends StatefulWidget {
  
  final BluetoothDeviceInfo foundDevice;
  final BasePageState  callerPage;
  final BluetoothLockersScanner lockerManager;
  final Function RefreshFoundDeviceList;

  ScanNewLockboxItemCell({this.foundDevice, this.callerPage, this.lockerManager,this.RefreshFoundDeviceList});

  @override
  State<StatefulWidget> createState() {
    return ScanNewLockboxItemCellState();
  }
}
class ScanNewLockboxItemCellState extends State<ScanNewLockboxItemCell> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'bind':"Bind",
      'warning_wake_up': "Please make sure the locker is waked up"
    },
    'zh': {
      'bind':"绑定",
      'warning_wake_up': "请确保锁是激活状态"
    },
  };

  @override
  Widget build(BuildContext context) {
    var icon = Image.asset('assets/ico_add_search_white.png');//// : Image.asset('assets/ico_add_search_black.png');
    List<Widget> childrenList = List<Widget>();
    childrenList.add(SizedBox(width: 96,));
    childrenList.add(Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Text(widget.foundDevice.device.name , style: TextStyle(fontSize: 16, color: Color(0xFF7A88A7)),),
            SizedBox(height: 5,),
            Text(widget.foundDevice.Status, style: TextStyle(fontSize: 14, color: Color(0xFFAAAAAA)),)
          ],
        )
    ));
    if(widget.foundDevice.StatusId<3)
    {
      childrenList.add(InkWell(
        child: Container(
            alignment: Alignment(0, 0),
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF536282) ),
                borderRadius: BorderRadius.all(Radius.circular(22.5))
            ),
            height: 35,
            width: 90,
            child: Text(_localizedValues[getLocaleCode()]["bind"], style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
        ),
        onTap: () {
          widget.callerPage.displayProgressIndicator(true);
          // 如果10seconds 后还在loading的话，那么显示请检查一下locker 是否在工作
          Future.delayed(Duration(seconds: 15), () {
            if(widget.callerPage.shouldDisplayProgressIndicator == true) {
              widget.callerPage.showErrorMessage(widget.callerPage.context, _localizedValues[getLocaleCode()]["warning_wake_up"]);
              ///widget.callerPage.displayProgressIndicator(false);
            }
          });
          widget.lockerManager.ConnectDevce(widget.foundDevice, widget.RefreshFoundDeviceList);
        },
      ));
    }
    childrenList.add(SizedBox(width: 10,));
    return Container(
      height: 150,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 60,
            left: 0,
            child: Container(
              decoration: shadowDecoration(),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 90,
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                children: childrenList,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: icon,
          )        
        ]
      )
    );
  }

}