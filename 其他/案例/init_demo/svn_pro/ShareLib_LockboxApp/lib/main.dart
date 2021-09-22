import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import './pages/signin_page.dart';
import './service/baseapi.dart';
import './service/serviceapi.dart';
import './models/loginmodel.dart';
import './pages/my_plans_page.dart';
import './pages/message_page.dart';
import './pages/my_lockers_page.dart';
import './pages/my_houses_page.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'dart:convert' as JSON;


void main() {
  initializeDateFormatting('en', null);
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return MyAppState();
  }  
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {

  Widget currentPage;
  AppLifecycleState _notification;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    currentPage = Container();
    verifyLoginState();
  }

  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed) {
      try {
        jpush.setBadge(0);
      }catch(e) {
      }
    }
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: isOnlyForPerson? "ImLockbox" : 'ReliableShowing',
      home: currentPage
    );
  }

  void verifyLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = prefs.getString(TOKEN_KEY);
    var nextPage;
    if(json != null) {
      initPushNotification();
      var jsonObj = jsonDecode(json);
      UserServerApi().setLoginResponse(LoginResponseModel.fromJson(jsonObj), false);
      UserServerApi().RefreshMyLogin(true);
      if(isAgent)
        nextPage = MyPlansPage();
      else if(isAgentAssistant)
        nextPage = MessagePage();
      else if(isHouseOwner)
        nextPage = MyHousesPage();
      else
        nextPage = MyLockersPage();
    } else {
      nextPage = SignInPage();
    }

    setState(() {
      currentPage =nextPage;
    });
  }


  
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPushNotification() async {
    if(isOnlyForPerson)
    {
      jpush.setup(
        appKey: "4aba2811ce5959424ce7881c",
        channel: "ImLockbox",
        production: true,
        debug: false,
      );
    }
    else
    {
      jpush.setup(
        appKey: "64f017462994ea1b3fc92662",
        channel: "ReliableShowingApp",
        production: true,
        debug: false,
      );
    }

    jpush.applyPushAuthority(new NotificationSettingsIOS(
        sound: true,
        alert: true,
        badge: true));

    jpush.getRegistrationID().then((rid) {
      print("JPush RegistrationID: $rid");
      if(UserServerApi().getToken() != "" && rid != "") {
        UserServerApi().UpdateRegistrationId(rid);
      }
    });

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");

        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");

          if(message["extras"] != null){
            Map notification;
            if(message["extras"]["cn.jpush.android.EXTRA"] != null) {
              var redirectto = message["extras"]["cn.jpush.android.EXTRA"] as String;
              var decoder = JSON.JsonDecoder();
              notification = decoder.convert(redirectto);
            } else if(message["extras"] is Map)  {
              notification = message["extras"];
            }

            if(notification != null) {
              if(notification["redirectto"] == "message_approval") {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => MessagePage(curPageIndex: 0,)));
              } else if(notification["redirectto"] == "message_approval_log") {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => MessagePage(curPageIndex: 1,)));
              }
            }
          }
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
        },
      );

    } catch(e) {
      print(e);
    }

  }


}

