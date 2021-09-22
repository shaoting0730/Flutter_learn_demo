import 'package:flutter/material.dart';
import './scan_new_lockbox_item_cell.dart';
import '../bluetooth/locker.dart';
import '../bluetooth/bluetoothUtility.dart';
import '../pages/base_page.dart';
import '../pages/scan_qr_code_page.dart';
import '../pages/scan_qr_code_bind_success_page.dart';
import '../service/baseapi.dart';

typedef OnTapBeginScan = void Function();

class ScanNewLockboxResult extends StatefulWidget {
  final OnTapBeginScan onTapBeginScan;
  final List<BluetoothDeviceInfo> foundDeviceList;
  final BasePageState  callerPage;
  final BluetoothLockersScanner lockerManager;
  final Function RefreshFoundDeviceList;
  ScanNewLockboxResult({this.onTapBeginScan, this.foundDeviceList, this.callerPage, this.lockerManager,this.RefreshFoundDeviceList});

  @override
  State<StatefulWidget> createState() {
    return ScanNewLockboxResultState();
  }
}

class ScanNewLockboxResultState extends State<ScanNewLockboxResult> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'found':'Found',
      'door_opened':'Lockbox Door opened',
      'scan_barcode':'Please scan the barcode on the lockbox',
      'scan': 'Scan'
    },
    'zh': {
      'found':'发现',
      'door_opened':'锁盒打开中',
      'scan_barcode':'请扫描背后的二维码',
      'scan': '扫描'
    },
  };
  Widget _scanningDialog;

  @override
  void initState() {
    super.initState();

  }
  void MyRefreshFoundDeviceList(BluetoothDeviceInfo curDevice, String message){
    if(curDevice.StatusId==1)///Connected
    {
      widget.lockerManager.SetDeviceTime(curDevice, MyRefreshFoundDeviceList);
      ////widget.lockerManager.OpenDeviceDoor(curDevice, MyRefreshFoundDeviceList);
    }
    else if(curDevice.StatusId==2)///Door Opened
    {
      widget.callerPage.displayProgressIndicator(false);
      _showScanningDialog(curDevice);
    }
    else if(widget.RefreshFoundDeviceList!=null)
    {
      widget.RefreshFoundDeviceList(curDevice, message);
    }
  }


  @override
  Widget build(BuildContext context) {

    var list = List<Widget>();
    list.addAll(<Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg_add_search_red.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 22,),
              Text(_localizedValues[getLocaleCode()]["found"] + " " + widget.foundDeviceList.length.toString() + " Lockbox(es)", style: TextStyle(color: Colors.white, fontSize: 16),),
              SizedBox(height: 34,),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: widget.foundDeviceList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = widget.foundDeviceList[index];
                      return ScanNewLockboxItemCell(foundDevice: item,callerPage:widget.callerPage, lockerManager: widget.lockerManager,RefreshFoundDeviceList:MyRefreshFoundDeviceList,);
                    },
                  ),
                ),
              )
            ]
          )
        )        
      ]
    );

    if(_scanningDialog != null) {
      list.add(_scanningDialog);
    }
    return Stack(
      children: list
    );
  }

  void _onTapScanQRCode(BluetoothDeviceInfo foundDevice) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ScanQRCodePage(onScanCompleted: (qrcode) {
      _navigateToBindingSuccessPage(qrcode,foundDevice);
      _hideScanningDialog();
    })));
  }


  void _navigateToBindingSuccessPage(String qrcode,BluetoothDeviceInfo foundDevice) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ScanQRCodeBindSuccessPage(Barcode: qrcode, lockerManager: widget.lockerManager, RefreshFoundDeviceList: widget.RefreshFoundDeviceList, foundDevice: foundDevice,)));
  }


  void _hideScanningDialog() {

    setState(() {
      _scanningDialog = null;
    });
  }

  void _showScanningDialog(BluetoothDeviceInfo foundDevice) {
    setState(() {
      _scanningDialog = Container(
        color: Colors.black.withAlpha(100),
        alignment: Alignment(0, 0),
        child: Container(
          color: Colors.white,
          width: 330,
          height: 374,
          child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Color(0xFF536282),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/ico_lockbox_opened.png', width: 70, height: 70,),
                      SizedBox(width: 10,),
                      Container(
                        width: 210,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_localizedValues[getLocaleCode()]["door_opened"],style: TextStyle(color: Colors.white, fontSize: 18),),
                            Text(_localizedValues[getLocaleCode()]["scan_barcode"],style: TextStyle(color: Colors.white, fontSize: 14),),
                          ],
                        )
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 26, 0, 37),
                  child: Image.asset('assets/ico_add_scan.png'),
                ),
                Container(
                    height: 44,
                    width: double.infinity,
                    alignment: Alignment(0, 0),
                    child:  RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        onPressed: () {
                          _onTapScanQRCode(foundDevice);
                        },
                        color: Color(0xFFFF3C38),
                        child: Container(
                          height: 44,
                          width: 200,
                          alignment: Alignment(0, 0),
                          child: Text(_localizedValues[getLocaleCode()]["scan"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
                        )
                    )
                )
              ]
          ),
        ),
      );
    });
  }
}