import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'input_field.dart';


typedef FindMyOfficeCallback = void Function();


class FindMyOfficeField extends InputField {

  final FindMyOfficeCallback onFindMyOfficeTap;

  FindMyOfficeField({Key key, this.onFindMyOfficeTap}): super(key:key);

  @override
  State<FindMyOfficeField> createState() {
    return FindMyOfficeFieldState();
  }
}

class FindMyOfficeFieldState extends InputFieldState<FindMyOfficeField> {

  String get officeCode => _officeCode;
  String _officeCode = '';

  
  
  @override
  Widget buildFieldContent(BuildContext context) {

    Widget findOfficeBtn = new InkWell(
      onTap: () {
        if(widget.onFindMyOfficeTap != null) {
          widget.onFindMyOfficeTap();
        }
      },
      child: new Container(
        alignment: Alignment.center,
        width: 130.0,
        height: 40.0,
        child: new Text('Search Office', style: new TextStyle(fontSize: 14.0, color:Color(0xFF727E98)),
        ),
      ),
    );

    var node = new FocusNode();
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child:TextField(
              onChanged: (str) {
                _officeCode = str;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                border: InputBorder.none
              ),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onSubmitted: (text) {
                FocusScope.of(context).reparentIfNeeded(node);
              }
            )
          ),
          Container(
            height: 40.0,
            width: 1.0,
            color: Color(0xFF727E98),
          ),
          findOfficeBtn
        ],
      ),
    );
  }

}