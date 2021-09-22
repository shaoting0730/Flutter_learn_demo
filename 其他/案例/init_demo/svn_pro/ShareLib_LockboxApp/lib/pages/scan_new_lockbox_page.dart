import 'package:flutter/material.dart';
import 'base_page.dart';
import '../bluetooth/locker.dart';
import '../bluetooth/bluetoothUtility.dart';
import '../widgets/scan_new_lockbox_init.dart';
import '../widgets/scan_new_lockbox_searching.dart';
import '../widgets/scan_new_lockbox_result.dart';
import '../service/baseapi.dart';

class ScanNewLockerPage extends BasePage {
  @override
  State<StatefulWidget> createState() {
    return ScanNewLockerPageState();
  }
}

class ScanNewLockerPageState extends BasePageState<ScanNewLockerPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title':"Scan New Lockbox",
    },
    'zh': {
      'title':"扫描新的锁盒",
    },
  };

  BluetoothLockersScanner lockerManager = new BluetoothLockersScanner();
  List<BluetoothDeviceInfo> foundDeviceList = List<BluetoothDeviceInfo>();
  
  ScanNewLockboxInit scanInit ;
  ScanNewLockboxSearching scanSearching;
  ScanNewLockboxResult scanResult;

  Widget curState;
  @override
  void initState() {
    super.initState();

    scanInit = ScanNewLockboxInit(onTapBeginScan: _onTapScanning);
    scanSearching = ScanNewLockboxSearching();

    curState = scanInit;
    title = _localizedValues[getLocaleCode()]["title"];
    scan();
  }
  @override
  void dispose() {
    super.dispose();
    lockerManager.stop();
  }
  void AlertMessage(BuildContext context, String strMessage){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Alert'),
          content: Text((strMessage)),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
  

  void RefreshFoundDeviceList(BluetoothDeviceInfo curDevice, String message){
    displayProgressIndicator(false);
    if(message!="") {
      showErrorMessage(context, message);
    }
    setState(() {
      this.foundDeviceList.clear();
      if(lockerManager.foundDeviceList.values != null) {
        this.foundDeviceList.addAll(lockerManager.foundDeviceList.values);
      }
      curState =  ScanNewLockboxResult(foundDeviceList:this.foundDeviceList,callerPage:this, lockerManager: lockerManager,RefreshFoundDeviceList:RefreshFoundDeviceList,);
    });
  }
  void RequestPermission(){

  }
  void scan() async{
    await lockerManager.Start(this, RefreshFoundDeviceList, null, null, RequestPermission);
  }
  @override
  Widget pageContent(BuildContext context) {
    return curState;
  }

  // 点击
  void _onTapScanning() async {
    setState(() {
      curState = scanSearching;
    });
  }

}