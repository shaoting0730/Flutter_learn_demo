import 'package:flutter/material.dart';
import './base_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';


typedef OnScanCompleted = void Function(String qrCode);

class ScanQRCodePage extends BasePage {

  final OnScanCompleted onScanCompleted;

  ScanQRCodePage({this.onScanCompleted});

  @override
  State<StatefulWidget> createState() {
    return ScanQRCodePageState();
  }

}

class ScanQRCodePageState extends BasePageState<ScanQRCodePage> {

  String barcode = "";

  @override
  void initState() {
    super.initState();
    title = "Locker QR code scanner";
    scan(context);

  }
  @override
  Widget pageContent(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: (){
                  scan(context);
                },
                child: const Text('Start to scan Locker QR code')
            ),
          )
          ,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(barcode, textAlign: TextAlign.center,),
          )
          ,
        ],
      ),
    );
  }

  Future scan(BuildContext context) async {
    String strPrefix = "DeviceQRCode=";
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        if(widget.onScanCompleted != null) {
            Navigator.pop(context);
            if (barcode.lastIndexOf(strPrefix) != -1) {
              this.barcode  = barcode.substring(barcode.lastIndexOf(strPrefix) + strPrefix.length, barcode.length);
              if(widget.onScanCompleted != null) {
                Navigator.pop(context);
                widget.onScanCompleted(this.barcode);
              }
            } else {
              this.barcode = barcode;
            }
            widget.onScanCompleted(this.barcode);
          }
      }
        
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Please grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
  

}

