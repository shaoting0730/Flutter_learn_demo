import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import '../pages/appointment_calendar_page.dart';
import '../service/baseapi.dart';
import 'input_field.dart';
import '../models/ui/plan_model.dart';


typedef OnTimePicked = void Function();

class TimePickerField extends InputField {

  final OnTimePicked onTimePicked;
  final bool isSystemDateSelector;
  final bool IsNewBook;
  final HouseModel houseModel;

  TimePickerField({Key key, this.isSystemDateSelector = false, this.onTimePicked, this.houseModel, this.IsNewBook=false}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TimePickerFieldState();
  }
}

class TimePickerFieldState extends InputFieldState<TimePickerField> {

  DateTime startAt;
  DateTime endAt;
  String displayText = "";

  DateTime initialDate;

  void clear(){
    setState(() {
      displayText = "";
    });
  }
  
  void setDisplayText(String text) {
    setState(() {
      displayText = text;
      initialDate = DateFormat('dd/MM/yyyy').parse(text);
    });
  }
  
  @override
  Widget buildFieldContent(BuildContext context) {

    var list = List<Widget>();
    list.add(
      Expanded(
        child:Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 14, 0),
          child: Text(displayText, style: TextStyle(fontSize: 14, color: Color(0xFF536282)),)
        )
      )
    );

    list.add(
      Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          children: <Widget>[
            Image.asset('assets/icon_calendar.png', color: Color(0xFF727E98),)
          ],
        ),
      )
    );

    return InkWell(
      onTap: () {
        if(widget.isSystemDateSelector)  {
          showPickerDate(context);
        } else {
          Navigator.push(context, 
            MaterialPageRoute(builder: 
              (context) => AppointmentCalendarPage(
                IsNewBook: widget.IsNewBook,
                houseModel: widget.houseModel,
                onPickedTime: (startAt, endAt) {
                  setState(() {
                    this.startAt = startAt;
                    this.endAt = endAt;  
                    String formatted = DateFormat('dd/MM/yyyy').format(startAt) + " " + DateFormat('HH:mm').format(startAt) + " to " +  DateFormat('HH:mm').format(endAt);
                    displayText = formatted;
                  });
                },
              )
            )
          );
        }
        
      },
      child: Container(
        height: 40,
        child: Row(
          children: list
        ),
      )
    );
  }

  showPickerDate(BuildContext context) {

    var monthlist = [
      "一月",
    "二月",
    "三月",
    "四月",
    "五月",
    "六月",
    "七月",
    "八月",
    "九月",
    "十月",
    "十一月",
    "十二月"
    ];
    Picker(
      hideHeader: false,
      adapter: DateTimePickerAdapter(
        months: getLocaleCode() == 'zh'? monthlist: DateTimePickerAdapter.MonthsList_EN ,
        value: initialDate != null ? initialDate : DateTime.now(),
      ),
      title: Text(getLocaleCode() == 'zh' ?"选择日期": "Select Data"),
      onConfirm: (Picker picker, List value) {
        setState(() {
          displayText = DateFormat('dd/MM/yyyy').format((picker.adapter as DateTimePickerAdapter).value);
          if(widget.onTimePicked != null) {
            widget.onTimePicked();
          }
        });
      }
    ).showModal(context);
  }


}
