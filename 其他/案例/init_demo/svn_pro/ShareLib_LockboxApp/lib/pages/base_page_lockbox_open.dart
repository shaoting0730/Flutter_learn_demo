import 'package:flutter/material.dart';
import 'base_page.dart';
import '../pages/authorized_mobile_account_page.dart';
import '../widgets/my_locker_detail_dialog_failed.dart';
import '../widgets/my_locker_detail_dialog_opened.dart';
import '../widgets/my_locker_detail_dialog_opening.dart';
import '../widgets/my_locker_detail_dialog_unlock_password.dart';

abstract class LockboxOpenBasePageState<T extends BasePage>  extends BasePageState<T>  {
  Widget curDialog;

  @override
  Widget pageContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
  
  void showFailedDialog(BuildContext context, bool isOpenDoor, String macAddress, String deviceGuid, {bool displayPasswordByShortMessage = true}) {
    setState(() {
      curDialog = MyLockerDetailDialogFailed( 
        myLockerDetailDialogFailedClose: () {
          hideFailedDialog();
        }, 
        myLockerDetailDialogFailedViewAccessCode: () {
            showViewAccessCodeDialog(context, isOpenDoor, macAddress, deviceGuid, displayPasswordByShortMessage: displayPasswordByShortMessage);
        });
    });
  }

  void hideFailedDialog() {
    setState(() {
      curDialog = null;
    });
  }

  void showDoorOpenedDialog() {
    setState(() {
      curDialog = MyLockerDetailDialogOpened( isHookOpened: false, myLockerDetailDialogOpenedOk: () {
        onTapOpenedDialogOk();
      });
    });
  }

  void showHookOpenedDialog() {
    setState(() {
      curDialog = MyLockerDetailDialogOpened( isHookOpened: true, myLockerDetailDialogOpenedOk: () {
        onTapOpenedDialogOk();
      });
    });
  }

  void showViewAccessCodeDialog(BuildContext context, bool isOpenDoor, String macAddress, String deviceGuid,  {bool displayPasswordByShortMessage = true}) {
    setState(() {
      curDialog = MyLockerDetailDialogUnlockPassword( 
        isOpenDoor: isOpenDoor,
        macAddress: macAddress,
        displayPasswordByShortMessage: displayPasswordByShortMessage,
        myLockerDetailDialogUnlockPasswordCancel: () {
          setState(() {
            curDialog = null;
          });
        },
        myLockerDetailDialogUnlockPasswordBluetoothUnlock: () {
          showOpeningDialog(context, isOpenDoor, macAddress, deviceGuid, displayPasswordByShortMessage: displayPasswordByShortMessage);
        },
        myLockerDetailDialogUnlockPasswordPasswordbyShortMessage: () {
          _showPasswordByShortMessagePage(context, isOpenDoor, macAddress, deviceGuid);
        },
      );
    });
  }

  void hideOpenedDialog() {
    setState(() {
      curDialog = null;
    });
  }

  void showOpeningDialog(BuildContext context, bool isOpenDoor, String macAddress, String deviceGuid, {bool displayPasswordByShortMessage = true}) {
    setState(() {
      curDialog = MyLockerDetailDialogOpening( 
        isOpenDoor: isOpenDoor,
        macAddress: macAddress,
        displayPasswordByShortMessage: displayPasswordByShortMessage,
        myLockerDetailDialogOpeningCancel: () {
          onTapCancelOpeningDialog();
        },
        myLockerDetailDialogOpeningViewAccessCode: () {
          showViewAccessCodeDialog(context, isOpenDoor, macAddress, deviceGuid, displayPasswordByShortMessage: displayPasswordByShortMessage);
        },
        myLockerDetailDialogOpeningPasswordByShortMessage: () {
          _showPasswordByShortMessagePage(context, isOpenDoor, macAddress, deviceGuid);
        });
    });
  }

  void _showPasswordByShortMessagePage(BuildContext context, bool isOpenDoor, String macAddress, String deviceGuid) {
    setState(() {
      curDialog = null; 
    });
    Navigator.push(context,  MaterialPageRoute(builder: (context) => AuthorizedMobileAccountPage(isOpenDoor: isOpenDoor, macAddress: macAddress, deviceGuid: deviceGuid, authorizedMobileAccountPageSendOut: (){
      _showPasswordSendOutdialog(context, isOpenDoor);
    },)));
  }

  void _showPasswordSendOutdialog(BuildContext context, bool isOpenDoor) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            height: 160,
            width: 200,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Text("The " + (isOpenDoor? "unlock box": "unlock hook") + " password has been sent to your mobile phone through the SMS verification code, pay attention to check.", style: TextStyle(fontSize: 14), textAlign: TextAlign.center,)
                ),
                
                InkWell(
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child:  Container(
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
                    width: 200,
                      child: Text("Ok"),
                    )
                ),
                ]            
            )
          )
        );
      },
    );
  }

  void hideOpeningDialog() {
    setState(() {
      curDialog = null;
    });
  }

  // TOOD: VW 用户点击了Cancel
  void onTapCancelOpeningDialog() {
    hideOpeningDialog();
  }

  // TOOD: VW 用户点击了 Opened dialog's Ok
  void onTapOpenedDialogOk() {
    hideOpenedDialog();
  }

  // TOOD: VW 用户点击了 Opened dialog's Ok
  void onTapFailedDialogViewAccessCode(String accessCode) {
    /*
    if(accessCode.length>0)
    {
      String strMessage = 'Oops...Something wrong with the bluetooth at this moment!\r\nTo open the lockbox, please use the keyboard to key in the access code: \r\n'+accessCode;
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Access Code'),
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
    */
    hideFailedDialog();
  }
}