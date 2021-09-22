import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'base_page.dart';
import './authorization_management_detail_page.dart';
import '../widgets/locker_authorization_management_list_cell.dart';
import '../service/serviceapi.dart';
import '../service/baseapi.dart';
import '../models/iotdevice.dart';

class AuthorizationManagementPage extends BasePage {

  final String deviceGuid;
  AuthorizationManagementPage({this.deviceGuid});

  @override
  State<StatefulWidget> createState() {
    
    return AuthorizationManagementPageState();
  }

}

class AuthorizationManagementPageState extends BasePageState<AuthorizationManagementPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title':"Authorization Management",
      'delete':'Delete'
    },
    'zh': {
      'title':"授权管理",
      'delete':'删除'
    },
  };  
  List<LockBoxDevicePermissionModel> models = List<LockBoxDevicePermissionModel>();

  @override
  void initState() {
    super.initState();

    title = _localizedValues[getLocaleCode()]["title"];

    _requestRefresh();
  }
  
  void _requestRefresh() async {
    displayProgressIndicator(true);
    var list = await UserServerApi().GetIoTDeviceAllPermissionRecords(scaffoldKey.currentContext, widget.deviceGuid);
    displayProgressIndicator(false);

    if(list != null) {
      setState(() {
        models = list;
      });
    }
    
  }

  @override
  Widget pageContent(BuildContext context) {
    if(models.length == 0) {
      return _buildEmptyPage();
    }
    return Stack(
      children: <Widget>[
        Container(
          child: ListView.builder(
            itemCount: models.length,
            itemBuilder: (BuildContext context, int index ) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorizationManagementDetailPage(model: models[index],)));
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: LockerAuthorizationManagementListCell(model: models[index],),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: _localizedValues[getLocaleCode()]["delete"],
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          _requestRemoveModel(index);
                        },
                      ),
                    ],
                  )
                )
              );
            }
          )
        )
      ]
    );
  }

  void _requestRemoveModel(int index) async {
    displayProgressIndicator(true);
    await UserServerApi().RemoveIoTDevicePermission(context, models[index]);
    setState(() {
      models.removeAt(index);
    });
    var list = await UserServerApi().GetIoTDeviceAllPermissionRecords(scaffoldKey.currentContext, widget.deviceGuid);
    displayProgressIndicator(false);

    if(list != null) {
      setState(() {
        models = list;
      });
    }

  }

  Widget _buildEmptyPage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 86, 0, 0),
      child: Column(
        children: <Widget>[
          Image.asset('assets/icon_home_empty.png'),
          SizedBox(height: 10,),
          Text('Empty', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),)
        ],
      ),
    );
  }

}