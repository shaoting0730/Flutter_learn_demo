import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'base_page.dart';
import '../models/ui/plan_model.dart';
import '../models/showing.dart';
import '../widgets/week_selecter.dart';
import '../widgets/time_picker.dart';
import '../widgets/start_end_time_picker.dart';
import '../service/serviceapi.dart';


class AddAuditTimePage extends BasePage {
  final HouseModel model;

  AddAuditTimePage({this.model});

  @override
  State<StatefulWidget> createState() {
    return AddAuditTimePageState();
  }

}

class AddAuditTimePageState extends BasePageState<AddAuditTimePage> {

  int status = 0;
  var _weeklyKey = GlobalKey<WeeklySelectorState>();
  var _startDateKey = GlobalKey<TimePickerFieldState>();
  var _endDateKey = GlobalKey<TimePickerFieldState>();
  var _timeKey = GlobalKey<StartEndTimerPickerState>();

  @override
  void initState() {
    super.initState();
    title = "Add Time";
  }

  @override
  Widget pageContent(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          _buildWeeklyArea(),
          Text('-- OR --', style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: 30),
          _buildDateArea(),
          SizedBox(height: 10),
          _buildTimeArea(),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned (
                  bottom: 30,
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
          Text("Weekly", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
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
          Text("Start Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          SizedBox(height: 10),
          TimePickerField(isSystemDateSelector: true, onTimePicked: _onSelectedStartDate, key: _startDateKey),
          SizedBox(height: 10),
          Text("End Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          TimePickerField(isSystemDateSelector: true, onTimePicked: _onSelectedEndDate, key: _endDateKey)
        ],
      ),
    );
  }

  Widget _buildTimeArea() {    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          SizedBox(height: 10),
          StartEndTimerPicker(onStartEndTimerChanged: _onSelectedStartEndTime, key: _timeKey)
        ],
      ),
    );
  }
  Widget _buildSaveButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      alignment: Alignment(0, 0),
      child:SizedBox(
        width: 200,
        height: 44,
        child: RaisedButton(
          child: Text("Save"),
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
      showErrorMessage(context, "Please choose aduit time");
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
        showErrorMessage(context, "Please choose one day in weekly section");
        return;
      }
      weekly = result;
    } else if(status == 2) {
      if(_startDateKey.currentState.displayText == "") {
        showErrorMessage(context, "Please choose start date first");
        return;
      }

      if(_endDateKey.currentState.displayText == "") {
        showErrorMessage(context, "Please choose end date");
        return;
      }

      var format = new DateFormat('d/MM/y', 'en');
      var startAt = format.parse(_startDateKey.currentState.displayText);
      var endAt = format.parse(_endDateKey.currentState.displayText);

      dateStartAt = DateTimeToTicks(startAt);
      dateEndAt = DateTimeToTicks(endAt);

      if(dateEndAt < dateStartAt) {
        showErrorMessage(context, "End Date must be behind Start Date");
        return;
      }
      
    }

    if(_timeKey.currentState.startTime() == -1 || _timeKey.currentState.endTime() == -1) {
      showErrorMessage(context, "Please choose time");
      return;
    }

    timeStartAt = _timeKey.currentState.startTime();
    timeEndAt = _timeKey.currentState.endTime(); 

    if(timeEndAt <= timeStartAt) {
      showErrorMessage(context, "End Time must be behind Start Time");
        return;
    }

    displayProgressIndicator(true);

    var request = ShowingAutoConfirmSettingModel(
      HouseGuid: widget.model.houseInfo.HouseGuid,
      DateType: status,
      WeekDay: weekly,
      SpecialStartDate: dateStartAt,
      SpecialEndDate: dateEndAt,
      StartTime: timeStartAt,
      EndTime:  timeEndAt,
      EnableRule: true
    );
    widget.model.showingAutoConfirmSettingList.add(request);

    var result = await UserServerApi().UpdateShowingAutoConfirmSetting(context, widget.model.showingAutoConfirmSettingList);

    displayProgressIndicator(false);
    if (result) {
      Navigator.pop(context);
    } 
  }
}