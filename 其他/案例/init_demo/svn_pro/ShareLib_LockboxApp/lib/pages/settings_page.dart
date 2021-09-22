import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_page.dart';
import './signin_page.dart';
import '../service/baseapi.dart';
import './reset_password_page.dart';
import './signup_real_estate_agent_page.dart';
import './front_desk_assistant_page.dart';


class SettingsPage extends BasePage {
  @override
  State<SettingsPage> createState() {
    return SettingsPageState();
  }

}

class SettingsPageState extends BasePageState<SettingsPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'setting':'Setting',
      'reset_password': "Reset password",
      'logout':"Log Out",
    },
    'zh': {
      'setting':'设置',
      'reset_password': "重置密码",
      'logout':"退出登录",
    },
  };
  @override
  void initState() {
    super.initState();
    title = _localizedValues[getLocaleCode()]["setting"];
    
    hiddenAppBar = true;
  }
  @override
  Widget pageContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _buildHeader(),
              _buildBody(),
              
            ],
          ),
        ),
        Positioned(
          top: 5,
          left: 10,
          child: SafeArea(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                child: Image.asset('assets/ic_back.png'),
              ),
            )
          )
          
        ),
        Positioned(
          bottom: 30,
          child: SafeArea(
            bottom: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: AlignmentDirectional.center,
              child:Text("Version: " + APP_VERSION, style: TextStyle(color: Color(0xFFD8D8D8), fontSize: 13)),
            )
          )
          
        )
      ],
    );
  }

  Widget _buildHeader() {
    String strName = loginResponse.Username;
    if(loginResponse.FirstName!="" && loginResponse.LastName!="")
      strName = loginResponse.FirstName+' '+loginResponse.LastName;
    return Container(
      height: 180,
      width: double.infinity,
      color: Color(0xFF536282),
      alignment: Alignment(0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30,),
          Image.asset('assets/icon_empty_avatar.png'),
          SizedBox(height: 9,),
          Text(strName, style: TextStyle(color: Colors.white, fontSize: 14)),
          SizedBox(height: 9,),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/icon_small_cellphone.png'),
                Text(loginResponse.CellPhone != null && loginResponse.CellPhone != ""? loginResponse.CellPhone: " *no mobile number*", style: TextStyle(color: Colors.white, fontSize: 13))
              ],
            ),
          )
        ]
      )
    );
  }

  Widget _buildBody() {

    var list = List<Widget>();
    if(isAgent) {  
      list.add(
        InkWell(
          onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FrontDeskAssistantPage()));
          },
          child:_buildCell("Front desk assistant", "assets/ico_my_houselist.png"),
        )
      );
    }

    if(isAgent == false && isOnlyForPerson==false) {
      list.add(
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupRealEstateAgentPage(registerOnly: true,)));
          },
          child:_buildCell("Upgrade to Real Estate Agent", "assets/ico_my_houselist.png"),
          )
       );
    }

    list.add(
      InkWell(
        onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
        },
        child:_buildCell(_localizedValues[getLocaleCode()]["reset_password"], "assets/ico_my_password.png"),
      )
    );

    list.add(
      InkWell(
        onTap:  () {
          _logout(context);
        },
        child: _buildCell(_localizedValues[getLocaleCode()]["logout"], "assets/ico_my_signout.png"),
      )
    );

    
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list
      ),
    );
  }

  Widget _buildCell(String title, String icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 15),
      child: Row(
        children: <Widget>[
          Image.asset(icon),
          SizedBox(width: 12,),
          Text(title, style: TextStyle(fontSize: 14, color: Color(0xFF536282), fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN_KEY);
    while(Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));

  }
}