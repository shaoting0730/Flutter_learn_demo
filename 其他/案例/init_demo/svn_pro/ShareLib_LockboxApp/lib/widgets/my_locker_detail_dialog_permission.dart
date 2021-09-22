import 'package:flutter/material.dart';
import '../widgets/phone_field.dart';
import '../service/baseapi.dart';

typedef MyLockerDetailDialogPermissionClose = void Function();
typedef MyLockerDetailDialogPermissionAuthorized = void Function();

class MyLockerDetailDialogPermission extends StatefulWidget {

  final MyLockerDetailDialogPermissionClose onMyLockerDetailDialogPermissionClose;
  final MyLockerDetailDialogPermissionAuthorized onMyLockerDetailDialogPermissionAuthorized;
  final String name;
  
  MyLockerDetailDialogPermission({this.onMyLockerDetailDialogPermissionClose, this.name = "Locker Name", this.onMyLockerDetailDialogPermissionAuthorized, Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return MyLockerDetailDialogPermissionState();
  }

}

class MyLockerDetailDialogPermissionState extends State<MyLockerDetailDialogPermission> {
  
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'phone_number':'Phone Number',
      'grant_access':'Grant Access'
    },
    'zh': {
      'phone_number':'手机',
      'grant_access':'授权'
    },
  };
  
  final _phoneNumberKey = GlobalKey<PhoneNumberFieldState>();

  String getPhoneNumber() {
    return _phoneNumberKey.currentState.phoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 290,
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 320,
            height: 100,
            color: Color(0xFF536282),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    if(widget.onMyLockerDetailDialogPermissionClose != null) {
                      widget.onMyLockerDetailDialogPermissionClose();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: AlignmentDirectional.centerEnd,
                    width: 320,
                    height: 40,
                    child: Image.asset('assets/icon_dialog_close.png'),
                  )
                ),
                Expanded(
                  child: Container(
                    child: Text(widget.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          _buildPhoneNumber(),
          SizedBox(height: 30,),
          _buildConfirmButton(context)
        ]
      ),
    );
  }
  
  Widget _buildPhoneNumber() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["phone_number"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          PhoneNumberField(key: _phoneNumberKey)
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      alignment: Alignment(0, 0),
      child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          onPressed: () {
            if(widget.onMyLockerDetailDialogPermissionAuthorized != null) {
              widget.onMyLockerDetailDialogPermissionAuthorized();
            }
          },
          color: Color(0xFFFF3C38),
          child: Container(
            height: 44,
            width: 200,
            alignment: Alignment(0, 0),
            child: Text(_localizedValues[getLocaleCode()]["grant_access"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
          )
        )
    );
  }
}