import 'package:flutter/material.dart';

typedef OnSelected = void Function(bool isSelected);
class PropertyType extends StatefulWidget {
  final String title;
  final OnSelected onSelected;
  final bool isSelected;
  PropertyType({this.title, this.onSelected, this.isSelected = false, Key key}): super(key:key);

  @override
  State<PropertyType> createState() {
    return PropertyTypeState();
  }

}

class PropertyTypeState extends State<PropertyType> {
  bool isSelected;
  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {

    Color backgroundColor = isSelected ? Color(0xFF536282) : Colors.white;
    Color textColor =isSelected? Colors.white : Color(0xFF979797);
    return GestureDetector(
      onTap: _onPressed,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF979797)),
          color: backgroundColor
        ),
        child: Text(widget.title, style: TextStyle(fontSize: 14, color: textColor),)
      )
    );
  }

  void _onPressed() {
    setState(() {
      isSelected = !isSelected;

      if(widget.onSelected != null) {
        widget.onSelected(isSelected);
      }
    });
  }
}