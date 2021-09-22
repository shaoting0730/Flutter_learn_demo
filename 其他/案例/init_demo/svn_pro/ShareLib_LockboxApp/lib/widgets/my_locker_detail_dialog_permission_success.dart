import 'package:flutter/material.dart';
import '../pages/authorization_management_page.dart';
import '../service/baseapi.dart';

typedef MyLockerDetailDialogPermissionSuccessClose = void Function();

class MyLockerDetailDialogPermissionSuccess extends StatefulWidget {

  final MyLockerDetailDialogPermissionSuccessClose onMyLockerDetailDialogPermissionSuccessClose;
  
  final String phoneNumber;
  final String deviceGuid;
  MyLockerDetailDialogPermissionSuccess({this.phoneNumber, this.deviceGuid, this.onMyLockerDetailDialogPermissionSuccessClose});

  @override
  State<StatefulWidget> createState() {
    return MyLockerDetailDialogPermissionSuccessState();
  }

}

class MyLockerDetailDialogPermissionSuccessState extends State<MyLockerDetailDialogPermissionSuccess> {
  
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'sucess':'Success',
      'phone_number':'Phone number:',
      'description':'There is no time limit for the authorization to manage the authorization time.',
      'authorization':'Authorization'
    },
    'zh': {
      'sucess':'成功',
      'phone_number':'联系号码:',
      'description':'认证管理员没有时间上限制，来管理认证时间',
      'authorization':'认证'
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 340,
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 320,
            height: 110,
            color: Color(0xFF536282),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    if(widget.onMyLockerDetailDialogPermissionSuccessClose != null) {
                      widget.onMyLockerDetailDialogPermissionSuccessClose();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: AlignmentDirectional.bottomEnd,
                    width: 320,
                    height: 25,
                    child: Image.asset('assets/icon_dialog_close.png'),
                  )
                ),
                Expanded(
                  child: Container(
                    alignment: AlignmentDirectional.topCenter,
                    child: Image.asset('assets/ico_authorization_success.png')
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
          SizedBox(height: 20,),
          Text(_localizedValues[getLocaleCode()]["sucess"], style: TextStyle(fontSize: 18),),
          SizedBox(height: 10,),
          Text(_localizedValues[getLocaleCode()]["phone_number"] + widget.phoneNumber, style: TextStyle(fontSize: 14, color: Color(0xFF999999)), textAlign: TextAlign.center),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(_localizedValues[getLocaleCode()]["description"], style: TextStyle(fontSize: 14, color: Color(0xFF999999)), textAlign: TextAlign.center,),
          ),
          
          SizedBox(height: 20,),
          _buildConfirmButton(context),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              Navigator.push(context,  MaterialPageRoute(builder: (context) => AuthorizationManagementPage(deviceGuid: widget.deviceGuid)));
            },
            child: Container(
              height: 30,
              alignment: AlignmentDirectional.center,
              child: Text(_localizedValues[getLocaleCode()]["authorization"]),
            )
          )
        ]
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
            if(widget.onMyLockerDetailDialogPermissionSuccessClose != null) {
              widget.onMyLockerDetailDialogPermissionSuccessClose();
            }
          },
          color: Color(0xFFFF3C38),
          child: Container(
            height: 44,
            width: 200,
            alignment: Alignment(0, 0),
            child: Text("OK", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
          )
        )
    );
  }
}