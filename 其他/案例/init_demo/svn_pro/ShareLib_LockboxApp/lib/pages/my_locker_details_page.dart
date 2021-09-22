import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'base_page_lockbox_open.dart';
import 'base_page.dart';
import './authorization_management_page.dart';
import '../service/serviceapi.dart';
import '../widgets/locker_history.dart';
import '../models/iotdevice.dart';
import '../service/baseapi.dart';
import '../widgets/phone_field.dart';
import '../widgets/my_locker_detail_dialog_permission.dart';
import '../widgets/my_locker_detail_dialog_permission_success.dart';
import '../bluetooth/locker.dart';
import '../bluetooth/bluetoothUtility.dart';
import '../pages/authorization_management_add_time_page.dart';
import '../widgets/my_locker_detail_dialog_opening.dart';

class MyLockerDetailsPage extends BasePage {
  final IOTDeviceInfoModel deviceInfo;
  final bool isMyLockbox;
  MyLockerDetailsPage({this.deviceInfo, this.isMyLockbox=false});
  @override
  State<MyLockerDetailsPage> createState() {
    return MyLockerDetailsPageState();
  }

}

class MyLockerDetailsPageState extends LockboxOpenBasePageState<MyLockerDetailsPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title':"Lockbox Details",
      'warning_lock_hook_is_dropped':"The lock hook is dropped, please be careful, don't lick your feet",
      "history":"History",
      "battery":"Battery",
      "sync_lock_time": "Sync Time",
      "open_hook":"OpenHook",
      "open_box":"OpenBox",
      "authorize":"Authorize",
      "authorization":"Authorization",
      "authorizer": "Authorizer",
      'authorization_time':'Authorization time',
      'error_phone_number':'Please fill in Phone Number',
    },
    'zh': {
      'title':"锁盒详情",
      'warning_lock_hook_is_dropped':"锁柄即将打开，小心掉落",
      "history":"历史记录",
      "battery":"电池",
      "sync_lock_time": "同步锁时间",
      "open_hook":"开锁钩",
      "open_box":"开锁盒",
      "authorize":"授权",
      "authorization":"授权管理",
      "authorizer": "授权者",
      'authorization_time':'授权时间',
      'error_phone_number':'请输入电话号码',
    },
  };
  List<LockBoxDeviceOpenRecordModel> openRecordsList = List<LockBoxDeviceOpenRecordModel>();
  var _mobileKey = GlobalKey<PhoneNumberFieldState>();
  BluetoothLocker lockerManager = new BluetoothLocker();

  var _phoneNumber = GlobalKey<MyLockerDetailDialogPermissionState>();
  var _lockerNameEditingController = TextEditingController();

  LockBoxDevicePermissionModel permissionModel = null;
  
  String _mobileNumber;
  String _lockerNewName;
  int _nType;

  void openHook(String MACAddress) async{

    displayWarningDialog(context, () {
      Future.delayed(Duration(seconds: 1),() async {
        showOpeningDialog(context, false, MACAddress, widget.deviceInfo.Guid);
        
        Future.delayed(Duration(seconds: 30), () {
          if(curDialog != null && curDialog is MyLockerDetailDialogOpening) {
            ///lockerManager.stop();
            showFailedDialog(context, false, MACAddress, widget.deviceInfo.Guid);
          }
        });
        await lockerManager.Start(this, MACAddress, false, showHookOpenedDialog, () {
          showFailedDialog(context, false, MACAddress, widget.deviceInfo.Guid, displayPasswordByShortMessage: false);
        }, _requestRefresh );
      });

    });
  }

  void openLocker(String MACAddress) async{
    showOpeningDialog(context, true, MACAddress,widget.deviceInfo.Guid);
    Future.delayed(Duration(seconds: 30), () {
      if(shouldDisplayProgressIndicator) {
        ///lockerManager.stop();
        // displayProgressIndicator(false);
        showFailedDialog(context, true, MACAddress, widget.deviceInfo.Guid);
      }
    });
    await lockerManager.Start(this, MACAddress, true, showDoorOpenedDialog, () {
      showFailedDialog(context, true, MACAddress, widget.deviceInfo.Guid);
    }, _requestRefresh);

  }

  void displayWarningDialog(BuildContext context, VoidCallback sccuess) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            height: getLocaleCode() == 'en'?150:100,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 24, 10, 16),
                  child: Text(_localizedValues[getLocaleCode()]["warning_lock_hook_is_dropped"],textAlign: TextAlign.center,)
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                        sccuess();
                      },
                      child: Container(
                        width: 280,
                        height: 33,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                          )
                        ),
                        alignment: AlignmentDirectional.center,
                          child: Text("Ok"),
                        )
                    ),
                  ]
                )
              ]
            )
          )
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    title = _localizedValues[getLocaleCode()]["title"];
    hiddenFastPass = true;
    _requestRefresh();
  }

  void _requestRefresh() async {
    this.openRecordsList.clear();
    if(widget.isMyLockbox) {
      // 查询  plan
      List<LockBoxDeviceOpenRecordModel> showingRequestScheduler = await UserServerApi().GetLockboxOpenRecordList(context, widget.deviceInfo.Guid);
      if(mounted && showingRequestScheduler != null) {
        setState(() {
          this.openRecordsList.addAll(showingRequestScheduler);
        });
      }
    } else {
        List<LockBoxDevicePermissionModel> permissionModels = await UserServerApi().GetIoTDeviceAllPermissionRecords(context, widget.deviceInfo.Guid);
        if(mounted && permissionModels != null) {
          permissionModels.forEach((element) {
            if(element.SharedToPhoneNumber == loginResponse.CellPhone) {
              setState(() {
               this.permissionModel = element; 
              });
            }
          });
        }
    }
  }

  @override
  willPopup()
  {
    lockerManager.stop();
  }

  @override
  void dispose() {
    super.dispose();
    lockerManager.stop();
  }

  @override
  Widget pageContent(BuildContext context) {
    List<Widget> listControls = new List<Widget>();
    listControls.add(_buildLockerInformation(context));
    if(widget.isMyLockbox) {
      listControls.add(SizedBox(height: 10,));
      listControls.add(
        Expanded(
          child: _buildLockerHistory()
        )
      );
    } else {
      listControls.add(
        Expanded(
          child: SingleChildScrollView(
            child: _buildLockerAuthorizerInformation(context)
          ) 
        )
      );
    }
    List<Widget> stackList = List<Widget>();
    stackList.add(Container(
        child: Column(
          children: listControls,
        ),
      )
    );
    if(curDialog != null) {
      stackList.add(
        Container(
          color: Colors.black.withAlpha(80),
          alignment: AlignmentDirectional.center,
          child: curDialog,
        )
      );
    }
    return Stack(
      children: stackList
    );
  }


  Widget _buildLockerAuthorizer() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15,),
          Text(_localizedValues[getLocaleCode()]["authorizer"],style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF999999)),),
          SizedBox(height: 15,),
          Text(widget.deviceInfo.MasterUserName,style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 15,),
          Container(
            color: Colors.grey.withAlpha(150),
            height: 1,
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget _buildLockerAuthorizationTimeList() {
    if(permissionModel == null) {
      return Container();
    }

    List<Widget> widgets = List<Widget>();
    widgets.add(SizedBox(height: 15,));
    widgets.add(Text(_localizedValues[getLocaleCode()]["authorization_time"],style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF999999)),));
    permissionModel.PermissionTimeList.forEach((permissionTime) {
      widgets.add(SizedBox(height: 15,));
      widgets.add(
        Container(
          child: Row(
            children: <Widget>[
              Image.asset('assets/icon_calendar_gray.png'),
              SizedBox(width: 5,),
              _buildText(permissionTime)
            ],
          ),
        )
      );
    });
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      )
    );
  }

  Widget _buildText(LockBoxDevicePermissionTimeModel model) {
    var hourFormatter = DateFormat('HH:mm', 'en');

    var startAt = hourFormatter.format(TicksToDateTime(model.StartTime));
    var endAt = hourFormatter.format(TicksToDateTime(model.EndTime));
    if(endAt == "00:00") {
      endAt = "24:00";
    }
    
    var time = "";
    if(model.DateType == 1) {

      for(int i = 0 ; i < model.WeekDay.length ; i ++ ) {
        
        if(model.WeekDay[i] == "1") {
          if(i == 0) {
            time += getLocaleCode() == "en" ?  "Sun " : "星期日 ";
          } else if(i == 1) {
            time += getLocaleCode() == "en" ?  "Mon " : "星期一 ";
          } else if(i == 2) {
            time += getLocaleCode() == "en" ?  "Tue " : "星期二 ";
          } else if(i == 3) {
            time += getLocaleCode() == "en" ?  "Wed " : "星期三 ";
          } else if(i == 4) {
            time += getLocaleCode() == "en" ?  "Thu " : "星期四 ";
          } else if(i == 5) {
            time += getLocaleCode() == "en" ?  "Fri " : "星期五 ";
          } else if(i == 6) {
            time += getLocaleCode() == "en" ?  "Sat " : "星期六 ";
          }
        }
      }
    } else {
      var dayFormatter = DateFormat('d/MM/y', 'en');
      time = dayFormatter.format(TicksToDateTime(model.SpecialStartDate)) + " - " + dayFormatter.format(TicksToDateTime(model.SpecialEndDate));
    }


    return Text(startAt + " - " + endAt + "  " + time, style: TextStyle(fontSize: 13, color: Color(0xFF536282)));
  }

  Widget _buildLockerAuthorizerInformation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildLockerAuthorizer(),
          _buildLockerAuthorizationTimeList()
        ],
      ),
    );
  }

  Widget _buildOpenBox(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 84,
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment(0, 0),
        child:SizedBox(
          width: 200,
          height: 44,
          child: RaisedButton(
            child: Text(_localizedValues[getLocaleCode()]["open_box"], style: TextStyle(color: Color(0xFF536282)),),
            onPressed: () {
              openLocker(widget.deviceInfo.DeviceMACAddress);
            },
            color: Colors.white,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Color(0xFF536282),)
            )
          )
        )
      ),
    );
  }

  Widget _buildLockerInformation(BuildContext context) {
    List<Widget> deviceNameLine = List<Widget>();
    deviceNameLine.add(Text(widget.deviceInfo.DeviceName, style: TextStyle(fontSize: 24, color: Colors.white,),overflow: TextOverflow.ellipsis));
    if(widget.isMyLockbox)
    {
      deviceNameLine.add(InkWell(
        onTap: () {
          _showChangeDeviceNameDialog();
        },
        child: Container(
          width: 30,
          height: 30,
          alignment: AlignmentDirectional.center,
          child: Image.asset('assets/ic_edit.png', color: Colors.white,),
        ),
      ));
    }

    List<Widget> bottomActionArea = List<Widget>();
    bottomActionArea.add(SizedBox(height: 160,));
    if(widget.isMyLockbox) {
      bottomActionArea.add(_buildOpenLockerButton(context));
    } else {
      bottomActionArea.add(_buildOpenBox(context));
    }
    
              
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(40, 16, 20, 0),
          height: 180,
          width: double.infinity,
          color: Color(0xFF536282),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/ico_add_search_white.png'),
              SizedBox(width: 28,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 180,
                      child: Wrap(
                        children: deviceNameLine
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("QRCode" +": " + widget.deviceInfo.DeviceQRCode, style: TextStyle(fontSize: 13, color: Colors.white,)),
                    SizedBox(height: 5,),
                    Text(widget.deviceInfo.Description, style: TextStyle(fontSize: 13, color: Colors.white,))
                  ]
                ),
              )
            ]
          ),
        ),
        Container(
          height: widget.isMyLockbox ? 300: 260,
          alignment: AlignmentDirectional.center,
          child: Column(
            children: bottomActionArea
          )
        )
      ]
    );   
  }

  _showChangeDeviceNameDialog() {
    var node = new FocusNode();
    _lockerNameEditingController.text = widget.deviceInfo.DeviceName;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            height: 125,
            width: 250,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      border: InputBorder.none
                    ),
                    controller: _lockerNameEditingController,
                    onChanged: (str) {
                      _lockerNewName = str;
                    },
                    onSubmitted: (text) {
                      FocusScope.of(context).reparentIfNeeded(node);
                    }
                  ),
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child:  Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide( 
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                            top: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                          )
                        ),
                        alignment: AlignmentDirectional.center,
                        width: 140,
                          child: Text("Canncel"),
                        )
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        _onChangeLockerName();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                          )
                        ),
                        alignment: AlignmentDirectional.center,
                        width: 140,
                        child: Text("Change"),
                      )
                    ),
                  ]
                )
              ]
            )
          )
        );
      },
    );
  }


  void _onChangeLockerName() async {
    if(_lockerNewName != null && _lockerNewName.length > 0) {
      displayProgressIndicator(true);
      widget.deviceInfo.DeviceName = _lockerNewName;
      await UserServerApi().UpdateIoTDevice(context, widget.deviceInfo);
      displayProgressIndicator(false);
    }
  }

  Widget _buildLockerHistory() {
    if(widget.deviceInfo.MasterUserGuid != loginResponse.StoreCustomerGuid) {
      return Container();
    }
    return Container(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left:15),
                  child:Text(_localizedValues[getLocaleCode()]["history"], style: TextStyle(fontSize: 14),),
                )
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,  MaterialPageRoute(builder: (context) => AuthorizationManagementPage(deviceGuid: widget.deviceInfo.Guid)));
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: 130,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(18), bottomLeft: Radius.circular(18))
                  ),
                  child: Text(_localizedValues[getLocaleCode()]["authorization"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),)
                )
              )
            ],
          ),
          
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: LockerHistory(OpenRecordList: this.openRecordsList)
            )
          )
        ],
      ),
    );
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
  
  // 调用蓝牙代码同步锁时间
  void _onTapSyncLookTime() async{
    displayProgressIndicator(true);
    Future.delayed(Duration(seconds: 60), () {
      if(shouldDisplayProgressIndicator) {
        ///lockerManager.stop();
        displayProgressIndicator(false);
        showErrorMessage(context, "Sync time failed, please try it again!");
      }
    });
    await lockerManager.SyncTime(this, widget.deviceInfo.DeviceMACAddress);
    BluetoothUtility utility = new BluetoothUtility();
    IOTDeviceInfoModel request = new IOTDeviceInfoModel();
    request.Guid = widget.deviceInfo.Guid;
    request.TimeZoneMinutes = utility.getTimeZoneMinutes();
    request.DeviceTypeId = 0;
    request.CreatedOn = 0;
    request.UpdatedOn = 0;
    await UserServerApi().UpdateIoTDeviceTimeZone(context, request);
  }

  Widget _buildActionButton(BuildContext context, String text, int nType, bool fill) {
    Color color = fill ? Colors.red: Colors.white;
    Color textColor = fill ? Colors.white:Colors.red;
    return SizedBox(
      child: RaisedButton(
          child: Text(text, style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          onPressed: () {
            _nType = nType;
            if(nType == 1) {
              openHook(widget.deviceInfo.DeviceMACAddress);
            } else if(nType ==  2) {
              openLocker(widget.deviceInfo.DeviceMACAddress);
            }
            else if(nType == 3) {
              _showAssignPermissionDialog(context);
            }
          },
          color: color,
          textColor: textColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Color(0xFF979797),)
          )
      ),
    );
  }

  Widget _buildOpenLockerButton(BuildContext context) {
    ///var batteryText = "N/A";
    double batteryLevel = 0;
    if(this.openRecordsList.length>0)
    {
      if(this.openRecordsList[0].PowerPercentage>0)
        batteryLevel = this.openRecordsList[0].PowerPercentage;
        ///batteryText = this.openRecordsList[0].PowerPercentage.toString()+"%";
    }
    List<Widget> validActions = List<Widget>();
    if(widget.isMyLockbox)
    {
      validActions.add(_buildActionButton(context, _localizedValues[getLocaleCode()]["open_hook"], 1, false));
      validActions.add(SizedBox(width: 5,));
    }
    validActions.add(_buildActionButton(context, _localizedValues[getLocaleCode()]["open_box"], 2, false));
    if(widget.isMyLockbox)
    {
      validActions.add(SizedBox(width: 5,));
      validActions.add(_buildActionButton(context, _localizedValues[getLocaleCode()]["authorize"], 3, false));
    }
    List<Widget> batteryActions = List<Widget>();
    var batteryText = _localizedValues[getLocaleCode()]["battery"];
    if(batteryLevel>0)
    {
      int minLevel = (batteryLevel / 10).toInt();
      if(minLevel>9)
        minLevel = 9;
      int maxLevel = minLevel+1;
      batteryText += " ("+(minLevel*10).toString() + "~"+(maxLevel*10).toString()+" %)";
    }
    batteryActions.add(Container(
      width: 120,
      child: Text(batteryText, style: TextStyle(fontSize: 14, color: Color(0xFF333A4F)),),
    ));
    if(batteryLevel==0)
    {
      batteryActions.add(Center(
          child: RotatedBox(
            quarterTurns: 5,
            child: Icon(
              Icons.battery_unknown,
              color: Colors.black,
              size: 30.0,
            ),
          )));
    }
    else if(batteryLevel < 30)
    {
      batteryActions.add(Center(
          child: RotatedBox(
            quarterTurns: 5,
            child: Icon(
              Icons.battery_alert,
              color: Colors.red,
              size: 30.0,
            ),
          )));
    }
    else
    {
      batteryActions.add(Center(
          child: RotatedBox(
            quarterTurns: 5,
            child: Icon(
              Icons.battery_std,
              color: Colors.green,
              size: 30.0,
            ),
          )));
    }
    if(widget.isMyLockbox)
    {
      batteryActions.add(SizedBox(width: 100,));
      batteryActions.add(InkWell(
        onTap: () {
          _onTapSyncLookTime();
        },
        child: Text(_localizedValues[getLocaleCode()]["sync_lock_time"], style: TextStyle(fontSize: 14, color: Color(0xFF333A4F), decoration: TextDecoration.underline),),
      ));
    }
    return Container(
        width: 360,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Color(0x15000000),
              blurRadius: 2.0, // has the effect of softening the shadow
              spreadRadius: 2.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                0.0, // vertical, move down 10
              ),
            )
          ]
        ),
        child:Column(
          children: <Widget>[
            /*
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text('当前状态', style: TextStyle(fontSize: 14, color: Color(0xFF333A4F)),),
                  ),
                  Text('锁箱关闭', style: TextStyle(fontSize: 14, color: Color(0xFF333A4F)),),
                ]
              ),
            ),
            SizedBox(height: 10,),
            */
            Container(
              child: Row(
                children: batteryActions
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: validActions,
            ),
            SizedBox(height: 5,),
          ],
        )
    );
  }

  void _showAssignPermissionDialog(BuildContext context) {
    setState(() {
      curDialog = MyLockerDetailDialogPermission(
          key:_phoneNumber,
          name: widget.deviceInfo.DeviceName,
          onMyLockerDetailDialogPermissionAuthorized: () {
            var phoneNumber = _phoneNumber.currentState.getPhoneNumber();
            if(phoneNumber == null || phoneNumber == "") {
              showErrorMessage(context, _localizedValues[getLocaleCode()]["error_phone_number"]);
              return;
            }
            _mobileNumber = phoneNumber;
            LockBoxDevicePermissionModel request = LockBoxDevicePermissionModel(IoTDeviceGuid:widget.deviceInfo.Guid, SharedToPhoneNumber:phoneNumber,);
            _showAddTime(context, request);
          },
          onMyLockerDetailDialogPermissionClose: () {
            setState(() {
              curDialog = null;
            });
          }
      );
    });
  }

  void _showAddTime(BuildContext context, LockBoxDevicePermissionModel request) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorizationManagementAddTimePage(model: request, onTimeAddCallback: () async {
      
      _showAssignPermssionSuccessDialog();
    },)));
  }

  void _showAssignPermssionSuccessDialog() {
    setState(() {
      curDialog = MyLockerDetailDialogPermissionSuccess(
          deviceGuid: widget.deviceInfo.Guid,
          phoneNumber: _mobileNumber,
          onMyLockerDetailDialogPermissionSuccessClose: (){
            setState(() {
              curDialog = null;
            });
          }
      ) ;
    });
  }

}