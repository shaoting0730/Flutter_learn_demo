import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';
import 'base_page.dart';
import './booking_detail_page.dart';

class BookingSuccessPage extends BasePage {
  final bool success;
  final HouseModel houseModel;
  BookingSuccessPage({this.success=true, this.houseModel});
  
  @override
  State<BookingSuccessPage> createState() {
    return BookingSuccessPageState();
  }

}

class BookingSuccessPageState extends BasePageState<BookingSuccessPage> {

  @override
  void initState() {
    super.initState();
  
    title = widget.success ? "Submit success" : "Submit failure";
  }

  @override
  Widget getLeftAction() {
      return Container();
  }

  @override
  Widget pageContent(BuildContext context) {
    var icon = widget.success ? Image.asset('assets/icon_success_big.png') : Image.asset('assets/icon_fail_big.png');
    var text = widget.success ? "Success": "Fail";
    var description = widget.success ? "Your application has been submitted":  "Your application has failed to submit.\n Please check and resubmit it.";
    var submitText = widget.success ? "Return": "Resubmit";
    return Container(
      alignment: Alignment(0, 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 40,),
          Container(
            child: icon,
          ),
          SizedBox(height: 18,),
          Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color:Color(0xFF536282),)),
          SizedBox(height: 10,),
          Container(
            width: 250,
            alignment: Alignment(0, 0),
            child: Text(description, style: TextStyle(fontSize: 14, color: Color(0xFF979797)),),
          ),
          SizedBox(height: 70,),
          _buildActionButton(context, submitText, true),
          ///SizedBox(height: 18,),
          ///_buildActionButton(context, "Back to Home", false),
        ],
      )
    );
  }


  Widget _buildActionButton(BuildContext context, String text, bool fill) {
    Color color = fill ? Colors.red: Colors.white;
    Color textColor = fill ? Colors.white:Colors.red;
    return SizedBox(
      width: 200,
      child: RaisedButton(
        child: Text(text),
        onPressed: () {
          ///if(text == "Return" ) {
          ///  Navigator.pop(context);
          ///} else  {
            Navigator.pop(context);
            Navigator.pop(context);
          ///}
        },
      
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.red,)
        )
      ),
    );
  }
}