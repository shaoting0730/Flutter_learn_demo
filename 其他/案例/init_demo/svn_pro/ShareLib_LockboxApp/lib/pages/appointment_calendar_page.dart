import 'package:flutter/material.dart';
import 'base_page.dart';
import '../widgets/calendar.dart';
import '../widgets/shadow_decoration.dart';
import '../widgets/hour_button.dart';
import '../models/ui/plan_model.dart';
import '../service/serviceapi.dart';

class _AppointmentTime {
  String time;
  int index;
  String displayTime;
  _AppointmentTime({this.time, this.index, this.displayTime});

}


typedef OnPickedTime = void Function(DateTime startAt, DateTime endAt);

class AppointmentCalendarPage extends BasePage {
  final DateTime initDateTime;
  final bool IsNewBook;
  final OnPickedTime onPickedTime;
  final HouseModel houseModel;
  AppointmentCalendarPage({this.onPickedTime, this.houseModel, this.IsNewBook = false, this.initDateTime });

  @override
  State<StatefulWidget> createState() {
    return AppointmentCalendarPageState();
  }

}

class AppointmentCalendarPageState extends BasePageState<AppointmentCalendarPage> {

  int selectedStartAt = -1;
  int selectedEndAt = -1;
  bool _hasPickedTime = false;

  String _selectedHelpText = "Please choose your time";

  DateTime _selectedDateTime = DateTime.now();
  List<Widget> _timeLabels = List<Widget>();
  List<_AppointmentTime> _appointmentTimes;


  List<List<DateTime>> _bookedTimes = List<List<DateTime>>();

  @override
  void initState() {
    super.initState();
    if(widget.initDateTime != null) {
      _selectedDateTime = widget.initDateTime;
    }
    _parseTime();

    title = "Schedule Time";
    _appointmentTimes = <_AppointmentTime>[
      _AppointmentTime(time:"00:00", displayTime: "00:00 ~ 00:30", index:0),
      _AppointmentTime(time:"00:30", displayTime: "00:30 ~ 01:00", index:1),
      _AppointmentTime(time:"01:00", displayTime: "01:00 ~ 01:30", index:2),
      _AppointmentTime(time:"01:30", displayTime: "01:30 ~ 02:00", index:3),
      _AppointmentTime(time:"02:00", displayTime: "02:00 ~ 02:30", index:4),
      _AppointmentTime(time:"02:30", displayTime: "02:30 ~ 03:00", index:5),
      _AppointmentTime(time:"03:00", displayTime: "03:00 ~ 03:30", index:6),
      _AppointmentTime(time:"03:30", displayTime: "03:30 ~ 04:00", index:7),
      _AppointmentTime(time:"04:00", displayTime: "04:00 ~ 04:30", index:8),
      _AppointmentTime(time:"04:30", displayTime: "04:30 ~ 05:00", index:9),
      _AppointmentTime(time:"05:00", displayTime: "05:00 ~ 05:30", index:10),
      _AppointmentTime(time:"05:30", displayTime: "05:30 ~ 06:00", index:11),
      _AppointmentTime(time:"06:00", displayTime: "06:00 ~ 06:30", index:12),
      _AppointmentTime(time:"06:30", displayTime: "06:30 ~ 07:00", index:13),
      _AppointmentTime(time:"07:00", displayTime: "07:00 ~ 07:30", index:14),
      _AppointmentTime(time:"07:30", displayTime: "07:30 ~ 08:00", index:15),
      _AppointmentTime(time:"08:00", displayTime: "08:00 ~ 08:30", index:16),
      _AppointmentTime(time:"08:30", displayTime: "08:30 ~ 09:00", index:17),
      _AppointmentTime(time:"09:00", displayTime: "09:00 ~ 09:30", index:18),
      _AppointmentTime(time:"09:30", displayTime: "09:30 ~ 10:00", index:19),
      _AppointmentTime(time:"10:00", displayTime: "10:00 ~ 10:30", index:20),
      _AppointmentTime(time:"10:30", displayTime: "10:30 ~ 11:00", index:21),
      _AppointmentTime(time:"11:00", displayTime: "11:00 ~ 11:30", index:22),
      _AppointmentTime(time:"11:30", displayTime: "11:30 ~ 12:00", index:23),
      _AppointmentTime(time:"12:00", displayTime: "12:00 ~ 12:30", index:24),
      _AppointmentTime(time:"12:30", displayTime: "12:30 ~ 13:00", index:25),
      _AppointmentTime(time:"13:00", displayTime: "13:00 ~ 13:30", index:26),
      _AppointmentTime(time:"13:30", displayTime: "13:30 ~ 14:00", index:27),
      _AppointmentTime(time:"14:00", displayTime: "14:00 ~ 14:30", index:28),
      _AppointmentTime(time:"14:30", displayTime: "14:30 ~ 15:00", index:29),
      _AppointmentTime(time:"15:00", displayTime: "15:00 ~ 15:30", index:30),
      _AppointmentTime(time:"15:30", displayTime: "15:30 ~ 16:00", index:31),
      _AppointmentTime(time:"16:00", displayTime: "16:00 ~ 16:30", index:32),
      _AppointmentTime(time:"16:30", displayTime: "16:30 ~ 17:00", index:33),
      _AppointmentTime(time:"17:00", displayTime: "17:00 ~ 17:30", index:34),
      _AppointmentTime(time:"17:30", displayTime: "17:30 ~ 18:00", index:35),
      _AppointmentTime(time:"18:00", displayTime: "18:00 ~ 18:30", index:36),
      _AppointmentTime(time:"18:30", displayTime: "18:30 ~ 19:00", index:37),
      _AppointmentTime(time:"19:00", displayTime: "19:00 ~ 19:30", index:38),
      _AppointmentTime(time:"19:30", displayTime: "19:30 ~ 20:00", index:39),
      _AppointmentTime(time:"20:00", displayTime: "20:00 ~ 20:30", index:40),
      _AppointmentTime(time:"20:30", displayTime: "20:30 ~ 21:00", index:41),
      _AppointmentTime(time:"21:00", displayTime: "21:00 ~ 21:30", index:42),
      _AppointmentTime(time:"21:30", displayTime: "21:30 ~ 22:00", index:43),
      _AppointmentTime(time:"22:00", displayTime: "22:00 ~ 22:30", index:44),
      _AppointmentTime(time:"22:30", displayTime: "22:30 ~ 23:00", index:45),
      _AppointmentTime(time:"23:00", displayTime: "23:00 ~ 23:30", index:46),
      _AppointmentTime(time:"23:30", displayTime: "23:30 ~ 23:59", index:47)
    ];
    _timeLabels = _buildTimeLabels(context);

    
  }

  void _parseTime() {
    if(widget.houseModel != null) {
      if(widget.houseModel.houseInfo != null) {
        if(widget.houseModel.houseInfo.BookedShowingList != null) {
          widget.houseModel.houseInfo.BookedShowingList.forEach((element) {
            
            if(element.ScheduledStartTime == widget.houseModel.selfScheduledStartTime && element.ScheduledEndTime == widget.houseModel.selfScheduledEndTime) {
              // 自己的时间
              if(widget.IsNewBook)
              {
                var startTime = TicksToDateTime(element.ScheduledStartTime);
                var endTime = TicksToDateTime(element.ScheduledEndTime);
                _bookedTimes.add([startTime, endTime]);
              }
            } else {
              var startTime = TicksToDateTime(element.ScheduledStartTime);
              var endTime = TicksToDateTime(element.ScheduledEndTime);
              _bookedTimes.add([startTime, endTime]);
            }
          
          });
        }
      }
    }
  }

  @override
  Widget pageContent(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildCalendar(context),
          SizedBox(height: 20,),
          Expanded(
            child: _buildScheduleHours(context)
          ),
          _buildSubmitButton(context)
        ],
      )
    );
  }
  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 100,
      decoration: shadowDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(_selectedHelpText, style: TextStyle(color: Color(0xFF536282), fontSize: 14),)
            )
          ),
          SizedBox(width: 5,),
          Container(
            width: 100,
            height: 44,
            child: RaisedButton(
              child: Text("Submit"),
              onPressed: () {
                _onSubmit(context);
              },
              color: Colors.red,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.red,)
              )
            ),
          )
          
        ],
      ),
    );
  }
  Widget _buildCalendar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Color(0xFF536282),
      child: Calendar(
        initialCalendarDateOverride: _selectedDateTime,
        onDateSelected: (datetime) {
          setState(() {
            _selectedDateTime = datetime;
            selectedStartAt = -1;
            selectedEndAt = -1;
            _selectedHelpText = "Please choose your time";
            _timeLabels = _buildTimeLabels(context);
          });
        }
      ),
    );
  }

  Widget _buildScheduleHours(BuildContext context) {
    return GridView.count(
              shrinkWrap: true,
              childAspectRatio:3.0,
              crossAxisCount: 3,
              children: _timeLabels
            )
          ;
  }

  List<Widget> _buildTimeLabels(BuildContext context) {

    List<Widget> times = List<Widget>();
    for(int i = 0 ; i < _appointmentTimes.length ;i ++ ) {
      var time = _appointmentTimes[i];
      times.add(_buildTime(context, time.time, time.displayTime, time.index));
    }
    return times;
  }


  bool _isTimeValid(DateTime time) {
    if (time.millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch) {
      return false;
    }

    bool isFlag = true;
    _bookedTimes.forEach((element){
      DateTime startTime = element.first;
      DateTime endTime = element.last;
      if (time.millisecondsSinceEpoch >= startTime.millisecondsSinceEpoch && time.millisecondsSinceEpoch < endTime.millisecondsSinceEpoch) {
        isFlag = false;
      } 
    });

    return isFlag;
  }

  Widget _buildTime(BuildContext context, String time, String diplayTime, int index) {
    
    int hour = int.parse(time.split(":")[0]);
    int min = int.parse(time.split(":")[1]);
    DateTime pickTime = DateTime(_selectedDateTime.year, _selectedDateTime.month, _selectedDateTime.day, hour, min);
    if(_isTimeValid(pickTime) == false) {
      return HourButton(time: diplayTime, status: HouseButtonStatus.disabled);
    }


    var status = HouseButtonStatus.unselected;
    
    if(selectedStartAt != -1 && selectedEndAt != -1) {
      var startAt = selectedStartAt < selectedEndAt? selectedStartAt : selectedEndAt;
      var endAt = selectedEndAt > selectedStartAt? selectedEndAt : selectedStartAt;
      status = (index >= startAt && index <= endAt)? HouseButtonStatus.selected : HouseButtonStatus.unselected;
    } else if(selectedStartAt != -1) {
      status = index == selectedStartAt ? HouseButtonStatus.selected : HouseButtonStatus.unselected;
    }

    // 在没有开始选择的情况下，先显示自己的时间
    if(selectedStartAt == -1 && selectedEndAt == -1 && _hasPickedTime == false) {
      if(widget.houseModel != null ) {
        if(widget.houseModel.selfScheduledStartTime > 0 && widget.houseModel.selfScheduledEndTime > 0) {
          DateTime startTime = TicksToDateTime(widget.houseModel.selfScheduledStartTime);
          DateTime endTime = TicksToDateTime(widget.houseModel.selfScheduledEndTime);
          if(pickTime.millisecondsSinceEpoch >= startTime.millisecondsSinceEpoch && pickTime.millisecondsSinceEpoch < endTime.millisecondsSinceEpoch) {
            if(widget.IsNewBook==false)
              status = HouseButtonStatus.selected;
          }
        }
      }
    }

    return InkWell(
      onTap: () {
        setState(() {

          int pickStartAt;
          int pickEndAt;
          if(selectedStartAt == -1) {
            selectedStartAt = index;
            selectedEndAt = -1;
            pickStartAt = selectedStartAt;
            pickEndAt = selectedStartAt + 1;

          } else if(selectedEndAt == -1) {
            selectedEndAt = index;
            pickStartAt = selectedStartAt < selectedEndAt ? selectedStartAt : selectedEndAt;
            pickEndAt = (selectedEndAt > selectedStartAt ? selectedEndAt : selectedStartAt) + 1;
            
          } else {
            selectedStartAt = index;
            selectedEndAt = -1;

            pickStartAt = selectedStartAt;
            pickEndAt = selectedStartAt + 1;
          } 
          _hasPickedTime = true; 

          
          if(pickEndAt >= _appointmentTimes.length) {
            _selectedHelpText = "You have choose " + _appointmentTimes[pickStartAt].time + " to 23:59 , " +  ((pickEndAt - pickStartAt) / 2).toString() + " hours of booking time" ; 
          } else {
            _selectedHelpText = "You have choose " + _appointmentTimes[pickStartAt].time + " to " + _appointmentTimes[pickEndAt].time + ", " + ((pickEndAt - pickStartAt) / 2).toString() + " hours of booking time" ; 
          }
        
          _timeLabels = _buildTimeLabels(context);
        });
        
      },
      child: HourButton(time: diplayTime, status: status,),
    );
  }

  void _onSubmit(BuildContext context) {
    if(selectedEndAt == -1 && selectedStartAt == -1) {
      showToastMessage(context, "Please choose your schedule time");
      return;
    }

    DateTime startAt;
    DateTime endAt;

    if(selectedEndAt != -1 && selectedStartAt != -1) {
        if(selectedStartAt>selectedEndAt)
        {
          int nTemp = selectedStartAt;
          selectedStartAt = selectedEndAt;
          selectedEndAt = nTemp;
        }
        if((selectedEndAt - selectedStartAt ) > 3)
        {
          showToastMessage(context, "You only can choose maximum 2 hours for showing!");
          return;
        }

        startAt = _getPickedTime(selectedStartAt);
        endAt = _getPickedTime(selectedEndAt + 1);
    } else {
        var index = selectedStartAt != -1 ? selectedStartAt : selectedEndAt;
        startAt = _getPickedTime(index);
        endAt = _getPickedTime(index + 1);
    }

    if(widget.onPickedTime != null){
      widget.onPickedTime(startAt, endAt);
    }
    Navigator.pop(context);

  }

  DateTime _getPickedTime(int index) {
    if(index >= _appointmentTimes.length) {
      String time = _appointmentTimes[index - 1].time;
      int hour = int.parse(time.split(":")[0]);
      int min = int.parse(time.split(":")[1]);
      var result = DateTime(_selectedDateTime.year, _selectedDateTime.month, _selectedDateTime.day, hour, min);  
      return result.add(Duration(minutes: 30));
    } else {
      String time = _appointmentTimes[index].time;
      int hour = int.parse(time.split(":")[0]);
      int min = int.parse(time.split(":")[1]);
      return DateTime(_selectedDateTime.year, _selectedDateTime.month, _selectedDateTime.day, hour, min);  
    }
  }

}