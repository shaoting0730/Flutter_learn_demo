import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/store_main.dart';
import 'pages/welcome.dart';
import 'pages/personal_center/binding_phone.dart';
import 'pages/personal_center/advertising.dart';
import 'pages/personal_center/feedback.dart';
import 'pages/personal_center/freight_settings.dart';
import 'pages/login.dart';
import 'pages/personal_center/orders.dart';
import 'pages/phone_login.dart';
import 'pages/store_dynamic/publish_activity.dart';
import 'pages/personal_center/publish_activity_success.dart';
import 'pages/share_wechat_account.dart';
import 'package:provider/provider.dart';

import './routers/application.dart';
import './routers/routers.dart';
import './bloc/isPicWall_bloc.dart';
import './bloc/current_type.dart';
import './utils/common_localizations_delegate.dart';

final JPush jpush = JPush();

void main() {
//  initializeDateFormatting('en', null);
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  // 强制只能竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  var isPicWallBloc = IsPicWallBloc();
  var currentTypeBloc = CurrentTypeBloc();
  runApp(MultiProvider(providers: [
    Provider<IsPicWallBloc>.value(value: isPicWallBloc),
    Provider<CurrentTypeBloc>.value(value: currentTypeBloc),
  ], child: MyApp()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>
    with
        WidgetsBindingObserver,
        AutomaticKeepAliveClientMixin,
        SingleTickerProviderStateMixin {
  Widget currentPage;
  AppLifecycleState _notification;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      try {
        if (Platform.isAndroid) {
          // Android-specific code
        } else if (Platform.isIOS) {
          // iOS-specific code
          jpush.setBadge(0);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;
    return MaterialApp(
      title: '小买卖圈',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      home: WelcomeScreen(),
      localizationsDelegates: [
        CommonLocalizationsDelegate(), // 解决iOS输入框长按bug
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
      ],
    );
  }
}
