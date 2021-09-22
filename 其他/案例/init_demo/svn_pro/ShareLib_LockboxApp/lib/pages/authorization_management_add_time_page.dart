import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'base_page.dart';
import '../models/iotdevice.dart';
import '../widgets/week_selecter.dart';
import '../widgets/time_picker.dart';
import '../widgets/start_end_time_picker.dart';
import '../service/baseapi.dart';
import '../service/serviceapi.dart';

typedef OnTimeAddCallback = void Function();
  
class AuthorizationManagementAddTimePage extends BasePage {
  final LockBoxDevicePermissionModel model;
  final OnTimeAddCallback onTimeAddCallback;
  AuthorizationManagementAddTimePage({this.model, this.onTimeAddCallback});

  @override
  State<StatefulWidget> createState() {
    return AuthorizationManagementAddTimePageState();
  }

}

class AuthorizationManagementAddTimePageState extends BasePageState<AuthorizationManagementAddTimePage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title':"Add Time",
      'or': 'OR',
      'save': 'Save',
      'weekly':'Weekly',
      'start_date':'Start Date',
      'end_date':'End Date',
      'time':'Time',
      'alltime':'Whole Day:00:00-23:59',
      'error_choose_time':"Please choose aduit time",
      'error_choose_weekly':"Please choose one day in weekly section",
      'error_choose_start_date':"Please choose start date first",
      'error_choose_end_date':"Please choose end date",
      'error_start_end_date':"End Date must be behind Start Date",
      'error_time':'Please choose time',
      'error_start_end_time':"End Time must be behind Start Time"
    },
    'zh': {
      'title':"时间管理",
      'or': '或',
      'save': "保存",
      'weekly':'每星期',
      'start_date':'开始日期',
      'end_date':'结束日期',
      'time':'时间',
      'alltime':'全天：00:00-23:59',
      'error_choose_time':"请选择合适的时间",
      'error_choose_weekly':"请至少选择星期中的某一天",
      'error_choose_start_date':"请选择开始日期",
      'error_choose_end_date':"请选择结束日期",
      'error_start_end_date':"结束日期必须在开始日期后面",
      'error_time':'请选择时间',
      'error_start_end_time':"结束时间必须在开始时间后面"
    },
  };  
  int status = 0;
  bool isWholeDay = false;
  var _weeklyKey = GlobalKey<WeeklySelectorState>();
  var _startDateKey = GlobalKey<TimePickerFieldState>();
  var _endDateKey = GlobalKey<TimePickerFieldState>();
  var _timeKey = GlobalKey<StartEndTimerPickerState>();

  @override
  void initState() {
    super.initState();
    title = _localizedValues[getLocaleCode()]["title"];
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget pageContent(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          _buildWeeklyArea(),
          Text('-- ' + _localizedValues[getLocaleCode()]["or"] + ' --', style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: 30),
          _buildDateArea(),
          SizedBox(height: 10),
          _buildTimeArea(),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned (
                  bottom: 10,
                  child: _buildSaveButton(context)
                )
              ],
            ),)
          
        ],
      ),
    );
  }

  Widget _buildWeeklyArea() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["weekly"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          SizedBox(height: 10),
          WeeklySelector(onWeeklyChanged: _onSelectedWeekly, key: _weeklyKey)
        ],
      ),
    );
  }

  Widget _buildDateArea() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["start_date"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          SizedBox(height: 10),
          TimePickerField(isSystemDateSelector: true, onTimePicked: _onSelectedStartDate, key: _startDateKey),
          SizedBox(height: 10),
          Text(_localizedValues[getLocaleCode()]["end_date"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          TimePickerField(isSystemDateSelector: true, onTimePicked: _onSelectedEndDate, key: _endDateKey)
        ],
      ),
    );
  }

  Widget _buildTimeArea() {
    if(isWholeDay)
    {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(_localizedValues[getLocaleCode()]["alltime"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                Checkbox(
                  activeColor: Color(0xFF536282),
                  value: isWholeDay,
                  onChanged: (value) {
                    setState(() {
                      isWholeDay = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }
    else
    {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(_localizedValues[getLocaleCode()]["alltime"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                Checkbox(
                  activeColor: Color(0xFF536282),
                  value: isWholeDay,
                  onChanged: (value) {
                    setState(() {
                      isWholeDay = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(_localizedValues[getLocaleCode()]["time"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            SizedBox(height: 10),
            StartEndTimerPicker(onStartEndTimerChanged: _onSelectedStartEndTime, key: _timeKey)
          ],
        ),
      );
    }
  }
  Widget _buildSaveButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      alignment: Alignment(0, 0),
      child:SizedBox(
        width: 200,
        height: 44,
        child: RaisedButton(
          child: Text(_localizedValues[getLocaleCode()]["save"]),
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

  void _onSelectedWeekly() {
    status = 1;
    _clearSpeicalDate();
  }

  void _onSelectedStartDate() {
    var format = new DateFormat('d/MM/y', 'en');
    var startAt = format.parse(_startDateKey.currentState.displayText);
    _endDateKey.currentState.initialDate = startAt;
    _endDateKey.currentState.setDisplayText(_startDateKey.currentState.displayText);
    status = 2;
    _clearWeekly();
  }

  void _onSelectedEndDate() {
    status = 2;
    _clearWeekly();
  }

  void _onSelectedStartEndTime() {
  }

  void _clearWeekly() {
    _weeklyKey.currentState.clear();
  }

  void _clearSpeicalDate() {
    _startDateKey.currentState.clear();
    _endDateKey.currentState.clear();
  }

  void _onSaveTapped(BuildContext context) async {
    if(status == 0) {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["error_choose_time"]);
      return;
    }

    var weekly = "0000000";
    int dateStartAt = 0;
    int dateEndAt = 0;
    int timeStartAt = 0;
    int timeEndAt = 0;

    if(status == 1) {
      var result = "";
      _weeklyKey.currentState.status.forEach((ele) {
        if(ele) {
          result += "1";
        } else {
          result += "0";
        }
      });

      if(result == "0000000")  {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_choose_weekly"]);
        return;
      }
      weekly = result;
    } else if(status == 2) {
      if(_startDateKey.currentState.displayText == "") {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_choose_start_date"]);
        return;
      }

      if(_endDateKey.currentState.displayText == "") {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_choose_end_date"]);
        return;
      }

      var format = new DateFormat('d/MM/y', 'en');
      var startAt = format.parse(_startDateKey.currentState.displayText);
      var endAt = format.parse(_endDateKey.currentState.displayText);

      dateStartAt = DateTimeToTicks(startAt);
      dateEndAt = DateTimeToTicks(endAt);

      if(dateEndAt < dateStartAt) {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_start_end_date"]);
        return;
      }
      
    }

    if(isWholeDay)
    {
      var now = DateTime.now();
      var hourFormatter = DateFormat('dd/MM/y HH:mm', 'en');
      timeStartAt = DateTimeToTicks(hourFormatter.parse(now.day.toString()+'/'+now.month.toString()+'/'+now.year.toString()+' 00:00'));
      timeEndAt = DateTimeToTicks(hourFormatter.parse(now.day.toString()+'/'+now.month.toString()+'/'+now.year.toString()+' 23:59'));
    }
    else
    {
      if(_timeKey.currentState.startTime() == -1 || _timeKey.currentState.endTime() == -1) {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_time"]);
        return;
      }
      timeStartAt = _timeKey.currentState.startTime();
      timeEndAt = _timeKey.currentState.endTime();
    }

    if(timeEndAt <= timeStartAt) {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["error_start_end_time"]);
        return;
    }

    displayProgressIndicator(true);

    var request = LockBoxDevicePermissionTimeModel(
      DateType: status,
      WeekDay: weekly,
      SpecialStartDate: dateStartAt,
      SpecialEndDate: dateEndAt,
      StartTime: timeStartAt,
      EndTime:  timeEndAt,
      EnableRule: true
    );
    if(widget.model.PermissionTimeList == null) {
      widget.model.PermissionTimeList = List<LockBoxDevicePermissionTimeModel>();
    }
    widget.model.PermissionTimeList.add(request);

    var result = await UserServerApi().AssignIoTDevicePermission(context, widget.model);

    displayProgressIndicator(false);
    if (result) {
      Navigator.pop(context);
      if(widget.onTimeAddCallback!=null) {
        widget.onTimeAddCallback();
      }
    } 
  }
}