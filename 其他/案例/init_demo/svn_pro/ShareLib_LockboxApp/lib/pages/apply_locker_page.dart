import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/ui/plan_model.dart';
import 'base_page.dart';
import 'my_houses_page.dart';
import '../widgets/text_field.dart';
import '../widgets/dropdown_select_field.dart';
import '../widgets/scan_qr_code_field.dart';
import '../service/serviceapi.dart';
import '../models/iotdevice.dart';



class ApplyForLockerPage extends BasePage {

  final String mlsNumber;
  final HouseModel model;
  ApplyForLockerPage({this.mlsNumber='', this.model});

  @override
  State<StatefulWidget> createState() {
    return ApplyForLockerPageState();
  }

}

class ApplyForLockerPageState extends BasePageState<ApplyForLockerPage> {

  final _mlsKey = GlobalKey<TextInputFieldState>();
  final _lockerTypeKey = GlobalKey<DropDownSelectFieldState>();
  final _qrcodeLockerKey = GlobalKey<ScanQRCodeFieldState>();
  final _traditionalLockerKey = GlobalKey<TextInputFieldState>();
  final _lockerInstallLocationKey = GlobalKey<TextInputFieldState>();

  String _lockerType ;
  File _image;

  @override
  void initState() {
    super.initState();
    title = "Apply for lockers";

    if(widget.model != null && widget.model.houseInfo != null ) {
      if(widget.model.houseInfo.LockBoxType == 1) {
        _lockerType = "ImLockbox";
      } else {
        _lockerType = "Mechanical Lockbox";
      }
    }
  }

  @override
  Widget pageContent(BuildContext context) {

    var list = List<Widget>();
    list.add(_buildMLSNumber());
    list.add(_buildLockerTypeSelector());
    if(_lockerType == "ImLockbox") {
      list.add(_buildQRCodeScan());
    } else if (_lockerType == "Mechanical Lockbox") {
      list.add(_buildTraditionalLocker());
    }
    list.add(_buildSelectPhoto(context));    
    list.add(_buildAddressNumber());
    list.add(SizedBox(height: 70,));
    list.add(_buildApplyButton(context));

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: list,
        )
      )
    );
  }

  Widget _buildQRCodeScan() {

    String qrCode = "";
    if(widget.model != null && widget.model.houseInfo != null ) {
      qrCode = widget.model.houseInfo.LockBoxNumber;
    }
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('ImLockbox', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          ScanQRCodeField(key: _qrcodeLockerKey, code: qrCode)
        ],
      ),
    );
  }

  Widget _buildTraditionalLocker() {
    String password = "";
    if(widget.model != null && widget.model.deviceToken != null ) {
      password = widget.model.deviceToken.Password;
    }
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Lockbox Password', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _traditionalLockerKey, text: password),
        ],
      ),
    );
  }
  
  Widget _buildMLSNumber() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('MLS@ Number', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _mlsKey, text: widget.mlsNumber, enabled: widget.model == null,),
        ],
      ),
    );
  }

  Widget _buildLockerTypeSelector() {

    String placeholder = "Please select Locker type";
    bool usePlaceholderAsValue = false;
    if(widget.model != null && widget.model.houseInfo != null ) {
      if(widget.model.houseInfo.LockBoxType == 1) {
        placeholder = "ImLockbox";
      } else {
        placeholder = "Mechanical Lockbox";
      }
      usePlaceholderAsValue = true;
    }
    
    var result = Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Lockbox Type', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          DropDownSelectField(key: _lockerTypeKey, options: ["ImLockbox", "Mechanical Lockbox"], placeholder: placeholder, onDropDownSelected: _onTapSelectedLockType, usePlaceholderAsValue: usePlaceholderAsValue,)
        ],
      ),
    );

    return result;

  }

  Widget _buildAddressNumber() {
    String location = "";
    if(widget.model != null && widget.model.houseInfo != null ) {
      location = widget.model.houseInfo.InstallLocation;
    }
    
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('LockBox Location', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _lockerInstallLocationKey, height: 130, maxLines: 6, text: location)
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
        onPressed: () {
          _onTapApplyLocker(context);
        },
        color: Color(0xFFFF3C38),
        child: Container(
          height: 44,
          width: 200,
          alignment: Alignment(0, 0),
          child: Text("Apply", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
        )
      )
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Widget _buildSelectPhoto(BuildContext context) {

    var image = _image == null ? Image.asset('assets/add_photo.png') : Image.file(_image);
    

    if(widget.model != null && widget.model.houseInfo != null && widget.model.houseInfo.LockerPictureUrl != null && widget.model.houseInfo.LockerPictureUrl != "") {
      image = Image.network(widget.model.houseInfo.LockerPictureUrl);
    }
    return Container(  
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('LockBox Location', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          GestureDetector(  
            onTap: () {
              getImage();
            },
            child: Container(
              height: 100,
              width: 100,
              child: image,
            ),
          )
        ],
      ),
    );
  }

  void _onTapSelectedLockType(String lockerType) {
    setState(() {
      _lockerType = lockerType;
    });
  }

  void _onTapApplyLocker(BuildContext context) async {

    
    if(_mlsKey.currentState.text.isEmpty) {
      showErrorMessage(context, "Please fill in MLS@ Number");
      return;
    }

    String lockerType = _lockerTypeKey.currentState.selectedValue;
    if(lockerType.isEmpty) {
      showErrorMessage(context, "Please fill in Locker Type");
      return;
    } 

    var lockboxType = (lockerType == "ImLockbox") ? 1: 2;
    String smartLockerQrCode = _qrcodeLockerKey.currentState != null ? _qrcodeLockerKey.currentState.qrCode : "";
    String traditionalLocker = _traditionalLockerKey.currentState != null ? _traditionalLockerKey.currentState.text : "";

    if(lockboxType == 1 && (smartLockerQrCode == null || smartLockerQrCode == "")) {
      showErrorMessage(context, "Please scan the QR code");
      return;
    }

    if(lockboxType == 2 && (traditionalLocker == null || traditionalLocker == "")) {
      showErrorMessage(context, "Please fill the Mechanical Locker's Password");
      return;
    }
    
    displayProgressIndicator(true);
    var password = lockerType == "ImLockbox" ? smartLockerQrCode: traditionalLocker;
    
    File imageFilePath = _image;
    
    var remoteImagePath = "";
    if(imageFilePath != null) {
      remoteImagePath = await UserServerApi().uploadImageFiles(context, imageFilePath.path);
    }

    if(lockboxType == 2) {
      smartLockerQrCode = "";
    } else {
      password = "";
    }
    
    var request = IOTDeviceRequestModel(
      MLSNumber: _mlsKey.currentState.text,
      RequestType: 1,
      PreferInstallDate: 0,
      LockboxType: lockboxType,
      Password: password,
      JobStatus: 2,
      WorkPicture: remoteImagePath,
      DeviceQRCode:smartLockerQrCode,
      InstalledLocation: (_lockerInstallLocationKey.currentState.text != null && _lockerInstallLocationKey.currentState.text.isEmpty) ? "" : _lockerInstallLocationKey.currentState.text,
    );

    bool response = await UserServerApi().RequestIOTDevice(context, request);
    
    displayProgressIndicator(false);
    if(response) {
      showToastMessage(context, "Success to apply locker");
      await Future.delayed(Duration(seconds: 2));

      if(widget.model != null) {
        Navigator.pop(context);
      }

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => MyHousesPage(),
        )
      );
      
    } 
  }
}