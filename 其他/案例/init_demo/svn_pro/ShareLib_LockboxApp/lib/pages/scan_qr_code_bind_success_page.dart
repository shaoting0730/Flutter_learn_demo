import 'package:flutter/material.dart';
import './base_page.dart';
import '../widgets/text_field.dart';
import '../bluetooth/locker.dart';
import '../bluetooth/bluetoothUtility.dart';
import '../service/baseapi.dart';

class ScanQRCodeBindSuccessPage extends BasePage {

  final String Barcode;
  final BluetoothLockersScanner lockerManager;
  final BluetoothDeviceInfo foundDevice;
  final Function RefreshFoundDeviceList;
  ScanQRCodeBindSuccessPage({this.Barcode = "", this.lockerManager, this.foundDevice, this.RefreshFoundDeviceList});

  @override
  State<StatefulWidget> createState() {
    return ScanQRCodeBindSuccessPageState();
  }

}

class ScanQRCodeBindSuccessPageState extends BasePageState<ScanQRCodeBindSuccessPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': "Device Information",
      'bind_new_lockbox':'Bind new lockbox',
      'qrcode':'QRCode:',
      'name':'Name',
      'description':'Description',
      'apply':"Apply"
    },
    'zh': {
      'title': "设备信息",
      'bind_new_lockbox':'绑定新锁盒',
      'qrcode':'二维码:',
      'name':'名称',
      'description':'描述',
      'apply':"应用"
    },
  };

  final _deviceNameKey = GlobalKey<TextInputFieldState>();
  final _descriptionKey = GlobalKey<TextInputFieldState>();
  @override
  void initState() {
    super.initState();

    title = _localizedValues[getLocaleCode()]["title"];
  }

  @override
  Widget pageContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: 10,),
            _buildName(),
            SizedBox(height: 10,),
            _buildAddressNumber(),
            SizedBox(height: 70,),
            _buildApplyButton(context),
          ]
        ),
      )
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Color(0xFF536282),
      height: 126,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(70, 18, 0, 18),
      alignment: AlignmentDirectional.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/ico_add_success.png'),
          SizedBox(width: 30,),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20,),
                Text(_localizedValues[getLocaleCode()]["bind_new_lockbox"], style: TextStyle(fontSize: 18, fontWeight:FontWeight.w600, color: Colors.white)),
                SizedBox(height: 5,),
                Text(_localizedValues[getLocaleCode()]["qrcode"] + widget.Barcode, style: TextStyle(fontSize: 14, color: Colors.white)),
              ]
            ),
          )
        ]
      ),
    );
  }

  Widget _buildName() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["name"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _deviceNameKey)
        ],
      ),
    );
  }

  Widget _buildAddressNumber() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["description"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _descriptionKey, height: 130, maxLines: 6,)
        ],
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      alignment: Alignment(0, 0),
      child:  RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        onPressed: () async {
          displayProgressIndicator(true);
          var result = await widget.lockerManager.RegisterDevice(context, widget.foundDevice,_deviceNameKey.currentState.text,_descriptionKey.currentState==null?'':_descriptionKey.currentState.text,widget.Barcode, widget.RefreshFoundDeviceList );
          displayProgressIndicator(false);
          
          if(result == true) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
          
          
        },
        color: Color(0xFFFF3C38),
        child: Container(
          height: 44,
          width: 200,
          alignment: Alignment(0, 0),
          child: Text(_localizedValues[getLocaleCode()]["apply"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
        )
      )
    );
  }
}