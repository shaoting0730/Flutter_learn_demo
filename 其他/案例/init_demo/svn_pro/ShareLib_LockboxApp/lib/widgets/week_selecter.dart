import 'package:flutter/material.dart';
import './hour_button.dart';
import '../service/baseapi.dart';

typedef OnWeeklyChanged = void Function();

class WeeklySelector extends StatefulWidget {

  final OnWeeklyChanged onWeeklyChanged;
  WeeklySelector({this.onWeeklyChanged, Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return WeeklySelectorState();
  }
}

class WeeklySelectorState extends State<WeeklySelector> {

  List<bool> status;

  @override
  void initState() {
    super.initState();
    status = <bool>[
      false, false, false, false, false, false, false
    ];
  }

  void clear() {
    setState(() {
      status = <bool>[
        false, false, false, false, false, false, false
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio:2.4,
        crossAxisCount: 4,
        children: <Widget>[
          _buildDayOfWeek(getLocaleCode() == 'en'? "Sun" : '日', 0, status[0]),
          _buildDayOfWeek(getLocaleCode() == 'en'? "Mon" : '一', 1, status[1]),
          _buildDayOfWeek(getLocaleCode() == 'en'? "Tue" : '二', 2, status[2]),
          _buildDayOfWeek(getLocaleCode() == 'en'? "Wed" : '三', 3, status[3]),
          _buildDayOfWeek(getLocaleCode() == 'en'? "Thu" : '四', 4, status[4]),
          _buildDayOfWeek(getLocaleCode() == 'en'? "Fri" : '五', 5, status[5]),
          _buildDayOfWeek(getLocaleCode() == 'en'? "Sat" : '六', 6, status[6]),
        ]
      ),
    );
  }

  Widget _buildDayOfWeek(String time, int index, bool selected) {
    return InkWell(
      onTap: () {
        setState(() {
          status[index] = !selected;
          if(widget.onWeeklyChanged !=null) {
            widget.onWeeklyChanged();
          }
        });
      },
      child: HourButton(time: time, status: selected? HouseButtonStatus.selected: HouseButtonStatus.unselected),
    );
  }
}