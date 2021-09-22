import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../pages/base_page.dart';


class NewsLetterSuccessPage extends BasePage {

  final bool byEmail;
  NewsLetterSuccessPage({this.byEmail = true});

  @override
  State<StatefulWidget> createState() {
    return NewsLetterSuccessPageState();
  }

}

class NewsLetterSuccessPageState extends BasePageState<NewsLetterSuccessPage> {
  @override
  void initState() {
    super.initState();
  
    title = "Send Success";
  }


  @override
  Widget pageContent(BuildContext context) {
    var icon = Image.asset('assets/icon_success_big.png');
    var text = "Success";
    var description =  "Your "+  (widget.byEmail? "email": "SMS") +" has been successfully distributed in groups";
    var submitText =  "Return";
    return Container(
      color: Colors.white,
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
            child: Text(description, style: TextStyle(fontSize: 14, color: Color(0xFF979797)), textAlign: TextAlign.center)
          ),
          SizedBox(height: 70,),
          _buildActionButton(context, submitText, true),

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
          if(text == "Return" || text == "Resubmit") {
            Navigator.pop(context);
            Navigator.pop(context);
          } 
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