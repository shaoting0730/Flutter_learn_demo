import 'package:flutter/material.dart';
import '../service/serviceapi.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert' as convert;
import 'base_page.dart';
import './authorization_management_add_time_page.dart';
import '../models/iotdevice.dart';
import '../widgets/avatar.dart';
import '../widgets/shadow_decoration.dart';
import '../widgets/locker_authorization_management_add_time_cell.dart';
import '../service/baseapi.dart';

class AuthorizationManagementDetailPage extends BasePage {

  final LockBoxDevicePermissionModel model;
  AuthorizationManagementDetailPage({this.model});

  @override
  State<StatefulWidget> createState() {
    return AuthorizationManagementDetailPageState();
  }
}

class AuthorizationManagementDetailPageState extends BasePageState<AuthorizationManagementDetailPage>  {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title':"Authorization Management",
      'delete': 'Delete',
      'add': 'Add',
    },
    'zh': {
      'title':"授权管理",
      'delete': '删除',
      'add': '添加',
    },
  };  
  @override
  void initState() {
    super.initState();

    title = _localizedValues[getLocaleCode()]["title"];

  }

  @override
  Widget pageContent(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildHeadView(),
          Expanded(
            child: _buildContentView()
          ),
          _buildAddButton(context)
        ],
      ),
    );
  }

  void _onTapAddTime(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorizationManagementAddTimePage(model: widget.model,)));
  }

  Widget _buildAddButton(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        width: MediaQuery.of(context).size.width - 30,
        alignment: Alignment(0, 0),
        child:SizedBox(
          width: 200,
          height: 44,
          child: RaisedButton(
            child: Text(_localizedValues[getLocaleCode()]["add"]),
            onPressed: () {
              _onTapAddTime(context);
            },
            color: Colors.red,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.red,)
            )
          )
        )
      )
    );
  }

  Widget _buildContentView() {

    var list = List<Widget>();
    if(widget.model.PermissionTimeList != null) {
      for(int i = 0 ; i < widget.model.PermissionTimeList.length; i ++) {
        list.add(_buildTimeCell(i));
      }
    }
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: list
        ),
      ),
    );
  }

  Widget _buildTimeCell(int i) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: LockerAuthorizationManagementAddTimeCell(model: widget.model.PermissionTimeList[i], onValueChanged: () {
            _onValueChanged();
          },
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: _localizedValues[getLocaleCode()]["delete"],
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              var removeItem = widget.model.PermissionTimeList.removeAt(i);
              _onRemoveChanged(removeItem);
            },
          ),
        ],
      )
    );
  }

  void _onValueChanged() async {
    displayProgressIndicator(true);
    await UserServerApi().AssignIoTDevicePermission(context, widget.model);
    displayProgressIndicator(false);
  }

  void _onRemoveChanged(LockBoxDevicePermissionTimeModel item) async {
    displayProgressIndicator(true);
    var request = LockBoxDevicePermissionModel.fromJson(convert.jsonDecode(convert.jsonEncode(widget.model)));
    request.PermissionTimeList.clear();
    request.PermissionTimeList.add(item);
    await UserServerApi().RemoveIoTDevicePermission(context, request);
    displayProgressIndicator(false);
  }

  Widget _buildHeadView() {
    return Container(
      decoration: shadowDecoration(),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Avatar(avatar: "",),
          SizedBox(width: 10,),
          Expanded(child: 
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.model.FirstName + " " + widget.model.LastName),
                        SizedBox(height: 5,),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Image.asset('assets/icon_phone.png'),
                              SizedBox(width: 5,),
                              Text(widget.model.SharedToPhoneNumber)
                            ]
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),  
          ),
        ],
      ),
    );
  }

}