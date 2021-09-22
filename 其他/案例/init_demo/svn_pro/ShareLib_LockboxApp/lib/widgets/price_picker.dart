import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

typedef OnPricePicker = void Function();

class PricePicker extends StatefulWidget {

  final OnPricePicker onPricePicker;
  final String placeholder;
  final List<String> priceOptions;
  PricePicker({this.placeholder, this.priceOptions, Key key, this.onPricePicker}): super(key:key);

  @override
  State<PricePicker> createState() {
    return PricePrickerState();
  }

}

class PricePrickerState extends State<PricePicker> {

  String selectedValue = "";

  void clear(){
    setState(() {
      
      selectedValue = "";
    });
  }

  void setSelectedValue(String value) {
    setState(() {
      selectedValue = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    String value = selectedValue.isEmpty ? widget.placeholder : selectedValue;

    return InkWell(
      onTap: () {
        showPickerModal(context);
      },
      child: Container(
        height: 40,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(value, style:TextStyle(fontSize: 14, color:Color(0xFF979797))),
              )
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
    int nDefaultSelected = widget.priceOptions.indexOf(selectedValue);
    if(nDefaultSelected<0)
      nDefaultSelected = 0;
    widget.priceOptions.forEach((element){
      items.add(PickerItem(text: Text(element), value: element));
    });

    Picker(
      adapter: PickerDataAdapter<String>(data: items),
      changeToFirst: true,
      hideHeader: false,
      selecteds: [nDefaultSelected],
      onConfirm: (Picker picker, List value) {
        setState(() {
          selectedValue = picker.getSelectedValues()[0];
          if(widget.onPricePicker != null) {
            widget.onPricePicker();
          }
        });
      }
    ).showModal(this.context); 
  }
}