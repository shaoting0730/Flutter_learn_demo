import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('showDatePicker'),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: new DateTime.now(),
                firstDate: new DateTime.now()
                    .subtract(new Duration(days: 30)), // 减 30 天
                lastDate:
                    new DateTime.now().add(new Duration(days: 30)), // 加 30 天
              ).then((DateTime val) {
                print(val); // 2018-07-12 00:00:00.000
              }).catchError((err) {
                print(err);
              });
            },
          ),
          RaisedButton(
            child: Text('showTimePicker'),
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: new TimeOfDay.now(),
              ).then((val) {
                print(val);
              }).catchError((err) {
                print(err);
              });
            },
          ),
        ],
      ),
    );
  }
}
