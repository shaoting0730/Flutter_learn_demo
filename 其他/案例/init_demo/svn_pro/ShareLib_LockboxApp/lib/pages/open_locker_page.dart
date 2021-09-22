import 'package:flutter/material.dart';
import 'base_page_lockbox_open.dart';
import 'base_page.dart';
import '../pages/photo_view_page.dart';
import '../widgets/locker_history.dart';
import '../bluetooth/locker.dart';
import '../models/ui/plan_model.dart';

class OpenLockerPage extends BasePage {
  final PlanModel planModel;

  OpenLockerPage({this.planModel});
  @override
  State<OpenLockerPage> createState() {
    return OpenLockerPageState();
  }

}

class OpenLockerPageState extends LockboxOpenBasePageState<OpenLockerPage> {
  BluetoothLocker lockerManager = new BluetoothLocker();

  void openLocker(String MACAddress) async{

    var deviceGuid = "";
    if(widget.planModel.house.deviceInfo!=null)
    {
      deviceGuid = widget.planModel.house.deviceInfo.Guid;
    }
    else if(widget.planModel.ShowingRequest.DeviceMACAddress!="")
    {
      deviceGuid = widget.planModel.ShowingRequest.Guid;
    }

    showOpeningDialog(context, true, MACAddress,deviceGuid, displayPasswordByShortMessage: false);
    Future.delayed(Duration(seconds: 30), () {
      if(shouldDisplayProgressIndicator) {
        ///lockerManager.stop();
        // displayProgressIndicator(false);
        showFailedDialog(context, false, MACAddress, deviceGuid, displayPasswordByShortMessage: false);
      }
    });
    await lockerManager.Start(this, MACAddress, true, showDoorOpenedDialog, showFailedDialog, null);
  }

  @override
  willPopup()
  {
    lockerManager.stop();
  }
  @override
  void initState() {
    super.initState();
    title = "Open Locker";
    hiddenFastPass = true;
  }
  @override
  void dispose() {
    super.dispose();
    lockerManager.stop();
  }

  @override
  Widget pageContent(BuildContext context) {
    List<Widget> listControls = new List<Widget>();
    listControls.add(_buildAccessType());
    listControls.add(SizedBox(height: 10,));
    listControls.add(_buildLocation());
    listControls.add(SizedBox(height: 10,));
    listControls.add(_buildLocker());
    listControls.add(SizedBox(height: 20,));
    if(widget.planModel.house.houseInfo.LockBoxType!=2) {
      listControls.add(_buildOpenLockerButton());
    }
    listControls.add(SizedBox(height: 10,));
    listControls.add(Expanded(
        child: _buildLockerHistory()
    ));
    /*
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: listControls,
      ),
    );
    */
    List<Widget> stackList = List<Widget>();
    stackList.add(Container(
      padding: const EdgeInsets.all(15),
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

  Widget _buildLockerHistory() {
    if(widget.planModel.isMyHouse == false) {
      return Container();
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('History', style: TextStyle(fontSize: 14),),
          Expanded(
            child: LockerHistory(OpenRecordList:widget.planModel.house.openRecordList)
          )
        ],
      ),
    );
  }

  Widget _buildAccessType() {
    String strLockboxType = 'Imlockebox Bluetooth';
    if(widget.planModel.house.houseInfo.LockBoxType==2)
      strLockboxType = 'Mechanical Lockbox';
    return Container(
      child: Row(
        children: <Widget>[
          Text('Access Type', style: TextStyle(fontSize: 14),),
          Expanded(
            child: Container(),
          ),
          Text(strLockboxType, style: TextStyle(fontSize: 14),),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    List<Widget> childrenList = List<Widget>();
    childrenList.add(Text('Location', style: TextStyle(fontSize: 14),));
    childrenList.add(Expanded(
      child: Container(),
    ));
    childrenList.add(Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(widget.planModel.house.houseInfo.InstallLocation==null?'':widget.planModel.house.houseInfo.InstallLocation, style: TextStyle(fontSize: 14, color: Color(0xFF4A90E2)),)
      ],
     ));
    if(widget.planModel.house.houseInfo.LockerPictureUrl!='')
    {
      childrenList.add(SizedBox(width: 5,));
      childrenList.add(GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  GalleryPhotoViewWrapper(galleryItems: [widget.planModel.house.houseInfo.LockerPictureUrl],
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                initialIndex: 0,
                ),
              ));
          },
          child:
          Container(
            height: 64,
            width: 64,
            child: Image.network(widget.planModel.house.houseInfo.LockerPictureUrl, fit: BoxFit.cover),
          )
      ));
    }
    return Container(
      child: Row(
        children: childrenList,
      ),
    );
  }

  Widget _buildLocker() {
    if(widget.planModel.house.houseInfo.LockBoxType==2) {
      return _buildLockerPassword();
    } else {
      return _buildLockerTapUnlock();
    }
  }

  Widget _buildLockerTapUnlock() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Color(0xFF536282),
      child: Container(
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icon_open_locker.png'),
            SizedBox(height: 10,),
            Text('Please press any button on the lockbox', style: TextStyle(fontSize: 14, color: Colors.white,)),
            Text('to wake it up, and click the button below', style: TextStyle(fontSize: 14, color: Colors.white,)),
          ],
        )
      ),
    );
  }

  Widget _buildLockerPassword() {
    String strPassword = '';
    if(widget.planModel.house.deviceToken!=null)
    {
      strPassword = widget.planModel.house.deviceToken.Password;
    }
    return Container(
      height: 180,
      width: double.infinity,
      color: Color(0xFF536282),
      child: Container(
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Unlock Password', style: TextStyle(fontSize: 14, color: Colors.white,)),
            Text(strPassword, style: TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        )
      ),
    );
  }

  Widget _buildOpenLockerButton() {
    String text = "Tap here to unlock";
    return InkWell(
      onTap: () {
        _tapOpenLocker();
      },
      child: Container(
        height: 38,
        width: 160,
        alignment: Alignment(0, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF979797))
        ),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF536282))),
      )
    );
  }

  void _tapOpenLocker() {
    if(widget.planModel.house.deviceInfo!=null)
    {
      if(widget.planModel.house.deviceInfo.DeviceMACAddress!="")
      {
        if(widget.planModel.house.houseInfo.LockBoxType==1) 
          openLocker(widget.planModel.house.deviceInfo.DeviceMACAddress);
      }
    }
    else if(widget.planModel.ShowingRequest.DeviceMACAddress!="")
    {
      if(widget.planModel.house.houseInfo.LockBoxType==1)
        openLocker(widget.planModel.ShowingRequest.DeviceMACAddress);
    }
  }
}