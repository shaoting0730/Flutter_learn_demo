import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../pages/base_page.dart';
import '../service/baseapi.dart';
import '../pages/my_plans_page.dart';
import '../pages/message_page.dart';
import '../pages/my_houses_page.dart';
import '../pages/my_lockers_page.dart';

class SignupRealEstateAgentSuccessPage extends BasePage {
  @override
  State<StatefulWidget> createState() {
    return SignupRealEstateAgentSuccessPageState();
  }

}

class SignupRealEstateAgentSuccessPageState extends BasePageState<SignupRealEstateAgentSuccessPage> {
  @override
  void initState() {
    super.initState();
  
    title = "Register Real Estate Agent";
  }


  @override
  Widget pageContent(BuildContext context) {
    var icon = Image.asset('assets/ico_complete_wait.png');
    var text = "Success";
    var description =  "Please wait patiently for the successful application.";
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
          SizedBox(height: 10,),
          Container(
            width: 250,
            alignment: Alignment(0, 0),
            child: Text(description, style: TextStyle(fontSize: 14, color: Color(0xFF979797)), textAlign: TextAlign.center)
          ),
          SizedBox(height: 70,),
          _buildActionButton(context, submitText, true),
          SizedBox(height: 18,),
          _buildActionButton(context, "Back to Home Page", false),
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
          } else {
              if(isAgent)
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => MyPlansPage(pageIndex:0),
              )
              );
            else if(isAgentAssistant)
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => MessagePage(),
              )
              );
            else if(isHouseOwner)
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => MyHousesPage(),
              )
              );
            else
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => MyLockersPage(canPop: false,),
              )
            );
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