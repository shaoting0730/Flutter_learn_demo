import 'package:flutter/material.dart';


class RoomNumberPicker extends StatefulWidget {

  RoomNumberPicker({Key key}): super(key: key);
  
  @override
  State<RoomNumberPicker> createState() {
    return RoomNumberPickerState();
  }

}

class RoomNumberPickerState extends State<RoomNumberPicker> {
  static Color selectedBackground = Color(0xFF536282);
  static Color selectedTextColor = Colors.white;
  static Color unselectedBackground = Colors.white;
  static Color unselectedTextColor = Color(0xFF979797);

  int selectedIndex = -1;

  void clear() {
    setState(() {
      selectedIndex = -1;
    });
  }

  int getSelectedNumber() {
    switch(selectedIndex) {
      case 0:
        return 1;
      case 1:
        return 2;
      case 2:
        return 3;
      case 3:
        return 4;
      case 4:
        return 5;
      default:
        return 0;
    }
  }

  @override
  void initState() {
    super.initState();

    selectedIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildNumber("1", 0),
          _buildNumber("2", 1),
          _buildNumber("3", 2),
          _buildNumber("4", 3),
          _buildNumber("5+", 4),
        ],
      ),
    );
  }

  Widget _buildNumber(String number, int index) {

    Color backgroundColor =selectedIndex == index? selectedBackground :unselectedBackground;
    Color textColor =selectedIndex ==index? selectedTextColor :unselectedTextColor;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if(selectedIndex == index) {
            selectedIndex = -1;
          } else {
            selectedIndex = index;
          }
        });
      },
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF979797)),
          borderRadius: BorderRadius.all(Radius.circular(14)),
          color: backgroundColor
        ),
        alignment: Alignment(0, 0),
        child: Text(number, style: TextStyle(fontSize: 14, color:textColor)),
      )
    );
  }
}