import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'input_field.dart';

typedef DropDownSelectCallback = void Function(String option);

class DropDownSelectField extends InputField {

  final String placeholder;
  final List<String> options;

  final DropDownSelectCallback onDropDownSelected;
  final bool usePlaceholderAsValue;

  DropDownSelectField({this.placeholder, this.options, Key key, this.onDropDownSelected, this.usePlaceholderAsValue = false}): super(key:key);

  @override
  State<DropDownSelectField> createState() {
    return DropDownSelectFieldState();
  }

}

class DropDownSelectFieldState extends InputFieldState<DropDownSelectField> {

  String selectedValue = "";

  @override
  void initState() {
    super.initState();

    if(widget.usePlaceholderAsValue) {
      selectedValue = widget.placeholder;
    }
  }

  @override
  Widget buildFieldContent(BuildContext context) {
    String value = selectedValue.isEmpty ? widget.placeholder : selectedValue;

    return InkWell(
      onTap: () {
        showPickerModal(context);
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(value, style:TextStyle(fontSize: 14, color:Color(0xFF979797))),
            ),
            Image.asset('assets/ic_keyboard_arrow_down.png'),
            SizedBox(width: 15,)
          ],
        ),
      )
    );
  }

  showPickerModal(BuildContext context) {
    
    List<PickerItem<String>> items = List<PickerItem<String>>();

    widget.options.forEach((element){
      items.add(PickerItem(text: Text(element), value: element));
    });

    Picker(
      adapter: PickerDataAdapter<String>(data: items),
      changeToFirst: true,
      hideHeader: false,
      onConfirm: (Picker picker, List value) {
        setState(() {
          selectedValue = picker.getSelectedValues()[0];
          if(widget.onDropDownSelected != null) {
            widget.onDropDownSelected(selectedValue);
          }
        });
      }
    ).showModal(this.context); 
  }

}