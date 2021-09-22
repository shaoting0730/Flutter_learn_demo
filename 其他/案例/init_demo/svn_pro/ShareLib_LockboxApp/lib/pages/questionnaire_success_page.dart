import 'package:flutter/material.dart';
import 'base_page.dart';
import '../pages/my_plans_page.dart';
import '../service/baseapi.dart';
import '../pages/message_page.dart';
import '../pages/my_lockers_page.dart';
import '../pages/my_houses_page.dart';

class QuestionnaireSuccessPage extends BasePage {
  final bool success;
  
  QuestionnaireSuccessPage({this.success=true});
  
  @override
  State<QuestionnaireSuccessPage> createState() {
    return QuestionnaireSuccessPageState();
  }

}

class QuestionnaireSuccessPageState extends BasePageState<QuestionnaireSuccessPage> {

  @override
  void initState() {
    super.initState();
  
    title = "Submit Success";
  }


  @override
  Widget pageContent(BuildContext context) {
    var icon =  Image.asset('assets/icon_success_big.png') ;
    var text = "Success";
    var description = "Your questionnaire has been submitted.";
    var submitText =  "Return";
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
          SizedBox(height: 20,),
          Container(
            alignment: Alignment(0, 0),
            child: Text(description, style: TextStyle(fontSize: 14, color: Color(0xFF979797)),),
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
          Navigator.pop(context);
          Navigator.pop(context);
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