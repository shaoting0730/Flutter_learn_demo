import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'base_page.dart';
import '../models/iotdevice.dart';
import '../widgets/price_picker.dart';
import '../widgets/phone_field.dart';
import '../service/serviceapi.dart';
import '../service/baseapi.dart';


typedef AuthorizedMobileAccountPageSendOut = void Function();

class AuthorizedMobileAccountPage extends BasePage {
  final bool isOpenDoor;
  final String macAddress;
  final String deviceGuid;
  final AuthorizedMobileAccountPageSendOut authorizedMobileAccountPageSendOut;
  AuthorizedMobileAccountPage({this.isOpenDoor, this.macAddress, this.deviceGuid, this.authorizedMobileAccountPageSendOut}) ;

  @override
  State<StatefulWidget> createState() {
    return AuthorizedMobileAccountPageState();
  }

}

class AuthorizedMobileAccountPageState extends BasePageState<AuthorizedMobileAccountPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title':'Share Password via SMS',
      'phonenumber':"Phone Number",
      'choosestartdatetime':"Choose Start DateTime",
      'chooseenddatetime':"Choose End DateTime",
      'sendout':"Send Out",
      'warning_nophonenumber':"Please Input PhoneNumber",
      'warning_nostartdate':"Please choose start date first",
      'warning_noenddate':"Please choose end date",
      'warning_startdatelate':"End Date must be behind Start Date",
    },
    'zh': {
      'title':'短信分享临时密码',
      'phonenumber':"手机号码",
      'choosestartdatetime':"请选择开始的日期和时间",
      'chooseenddatetime':"请选择结束的日期和时间",
      'sendout':"短信发送",
      'warning_nophonenumber':"请输入手机号码",
      'warning_nostartdate':"请选择开始日期时间",
      'warning_noenddate':"请选择开始结束时间",
      'warning_startdatelate':"结束时间不能比开始时间早",
    },
  };

  DateTime _startDatetime = null;
  DateTime _endDatetime = null;
  var _phoneNumberKey = GlobalKey<PhoneNumberFieldState>();

  @override
  void initState() {
    super.initState();
    title = _localizedValues[getLocaleCode()]["title"];
  }

  @override
  Widget pageContent(BuildContext context) {
    return SingleChildScrollView(
      child:Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            _buildDateArea(),
            SizedBox(height: 80),
            _buildSendOutButton(context),
          ]
        ),
      )
    );
  }

  Widget _buildDateArea() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["phonenumber"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          SizedBox(height: 10),
          PhoneNumberField(displayContryCode: true, key: _phoneNumberKey,),
          SizedBox(height: 10),
          FlatButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime.now().add(new Duration(days:3650)), onChanged: (date) {
                    }, onConfirm: (date) {
                      setState((){_startDatetime = date;});
                    }, currentTime: DateTime.now(), locale: getLocaleCode()=='zh'?LocaleType.zh:LocaleType.en);
              },
              child: Text(
                _startDatetime==null?_localizedValues[getLocaleCode()]["choosestartdatetime"]:DateFormat('yyyy-MM-dd HH:mm').format(_startDatetime),
                style: TextStyle(color: Colors.blue),
              )),
            SizedBox(height: 10),
            FlatButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: _startDatetime==null?DateTime.now():_startDatetime,
                      maxTime: DateTime.now().add(new Duration(days:3650)), onChanged: (date) {
                      }, onConfirm: (date) {
                        setState((){_endDatetime = date;});
                      }, currentTime:  _startDatetime==null?DateTime.now():_startDatetime, locale: getLocaleCode()=='zh'?LocaleType.zh:LocaleType.en);
                },
                child: Text(
                  _endDatetime==null?_localizedValues[getLocaleCode()]["chooseenddatetime"]:DateFormat('yyyy-MM-dd HH:mm').format(_endDatetime),
                  style: TextStyle(color: Colors.blue),
                )),
        ],
      ),
    );
  }

  Widget _buildSendOutButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      alignment: Alignment(0, 0),
      child:SizedBox(
        width: 200,
        height: 44,
        child: RaisedButton(
          child: Text(_localizedValues[getLocaleCode()]["sendout"]),
          onPressed: () {
            _onSaveTapped(context);
          },
          color: Colors.red,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.red,)
          )
        )
      )
    );
  }
  void _onSaveTapped(BuildContext context) async {
    
    if(_phoneNumberKey.currentState.phoneNumber() == null || _phoneNumberKey.currentState.phoneNumber().length == 0) {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["warning_nophonenumber"]);
      return;
    }

    int dateStartAt = 0;
    int dateEndAt = 0;

    if(_startDatetime == null) {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["warning_nostartdate"]);
      return;
    }

    if(_endDatetime == null) {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["warning_noenddate"]);
      return;
    }

    dateStartAt = DateTimeToTicks(_startDatetime);
    dateEndAt = DateTimeToTicks(_endDatetime);

    if(dateEndAt < dateStartAt) {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["warning_startdatelate"]);
      return;
    }
    
    displayProgressIndicator(true);

    LockBoxDeviceSharePasswordRequest request = LockBoxDeviceSharePasswordRequest(
      IoTDeviceGuid:widget.deviceGuid,
        StartDateTime:dateStartAt,
        EndDateTime:  dateEndAt,
        SharedToPhoneNumber:_phoneNumberKey.currentState.phoneNumber(),
        LocalCode:getLocaleCode(),
    );

    var passwordResponse = await UserServerApi().RetrieveIOTDevicePasswordSMS(context, request);

    displayProgressIndicator(false);

    Navigator.pop(context);

    sendSms(_phoneNumberKey.currentState.phoneNumber(), passwordResponse);
    if(widget.authorizedMobileAccountPageSendOut != null) {
      widget.authorizedMobileAccountPageSendOut();
    }
  }


  void sendSms(String phoneNumber, String password) async {
    String _result = await FlutterSms .sendSMS(message: password, recipients: [phoneNumber]).catchError((onError) {
        print(onError);
    });
  }
  
}