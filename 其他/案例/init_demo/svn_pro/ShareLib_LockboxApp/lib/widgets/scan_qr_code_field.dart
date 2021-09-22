import 'package:flutter/material.dart';

import 'input_field.dart';
import '../pages/scan_qr_code_page.dart';

class ScanQRCodeField extends InputField {

  final bool qrCode ;
  final OnScanCompleted onScanCompleted;
  final String code;
  ScanQRCodeField({Key key, this.qrCode = true, this.onScanCompleted, this.code = ""}):super(key: key);
  
  @override
  State<ScanQRCodeField> createState() {
    return ScanQRCodeFieldState();
  }

} 

class ScanQRCodeFieldState extends InputFieldState<ScanQRCodeField> {

  String _qrCode;
  String get qrCode => _qrCode;

  TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    _qrCode = widget.code;
    _editController = TextEditingController(text: widget.code);
  }

  @override
  Widget buildFieldContent(BuildContext context) {
    var node = new FocusNode();

    var list = List<Widget>();

    list.add(
      Expanded(
        child:TextField(
          controller: _editController,
          onChanged: (str) {
            _qrCode = str;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            border: InputBorder.none
          ),
          onSubmitted: (text) {
            FocusScope.of(context).reparentIfNeeded(node);
          }
        )
      ),
    );

    if(widget.qrCode) {
      list.add(
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.camera_alt, color: Color(0xFF727E98)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScanQRCodePage(onScanCompleted: (qrcode) {
                    setState(() {
                      this._qrCode = qrcode;
                      _editController.text = qrcode;
                    });
                  })));
                }
              )
            ]
          )
        )
      );
    }

    return Container(
      child: Row(
        children: list
      ),
    );
  }
}