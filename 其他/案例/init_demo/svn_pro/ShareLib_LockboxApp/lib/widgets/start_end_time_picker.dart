import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './price_picker.dart';
import 'input_field.dart';
import '../service/baseapi.dart';
import '../service/serviceapi.dart';
typedef OnStartEndTimerChanged = void Function();

class StartEndTimerPicker extends InputField {
  final OnStartEndTimerChanged onStartEndTimerChanged;

  StartEndTimerPicker({this.onStartEndTimerChanged, Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return StartEndTimerPickerState();
  }

}

class StartEndTimerPickerState extends InputFieldState<StartEndTimerPicker> {

  var _startTimeKey = GlobalKey<PricePrickerState>();
  var _endTimeKey = GlobalKey<PricePrickerState>();

  int startTime() {
    if(_startTimeKey.currentState.selectedValue == "") {
      return -1;
    }
    var now = DateTime.now();
    var hourFormatter = DateFormat('dd/MM/y HH:mm', 'en');
    var startAt = hourFormatter.parse(now.day.toString()+'/'+now.month.toString()+'/'+now.year.toString()+' '+_startTimeKey.currentState.selectedValue);
    return DateTimeToTicks(startAt);
  }

  int endTime() {
      if(_endTimeKey.currentState.selectedValue == "") {
      return -1;
    }

    var now = DateTime.now();
    var hourFormatter = DateFormat('dd/MM/y HH:mm', 'en');
    var endAt = hourFormatter.parse(now.day.toString()+'/'+now.month.toString()+'/'+now.year.toString()+' '+_endTimeKey.currentState.selectedValue);
    return DateTimeToTicks(endAt);
  }

  void clear() {
    _startTimeKey.currentState.clear();
    _endTimeKey.currentState.clear();
  }

  @override
  Widget buildFieldContent(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child:PricePicker(
              key: _startTimeKey,
              onPricePicker: () {
                _endTimeKey.currentState.setSelectedValue(_startTimeKey.currentState.selectedValue);
                if(widget.onStartEndTimerChanged != null) {
                  widget.onStartEndTimerChanged();
                }
              },
              placeholder: getLocaleCode() == 'en' ? 'Start time': '开始时间', 
              priceOptions: <String>["00:00","00:30", "01:00","01:30", "02:00", "02:30", "03:00", "03:30", "04:00", "04:30", "05:00", "05:30", "06:00", "06:30", "07:00", "07:30", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30"]
            )
          ),
          Divider(height: 10, color: Color(0xFFCCCCCC)),
          Flexible(
            child:PricePicker(
              key: _endTimeKey,
              onPricePicker: () {
                if(widget.onStartEndTimerChanged != null) {
                  widget.onStartEndTimerChanged();
                }
              },
              placeholder: getLocaleCode() == 'en' ? 'End time' : '结束时间', 
              priceOptions:<String>["00:00","00:30", "01:00","01:30", "02:00", "02:30", "03:00", "03:30", "04:00", "04:30", "05:00", "05:30", "06:00", "06:30", "07:00", "07:30", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30", "23:59"]
            )
          )
        ],
      )
    );
  }

}