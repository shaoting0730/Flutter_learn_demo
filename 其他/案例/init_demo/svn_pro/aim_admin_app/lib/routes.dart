import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/app_model.dart';
import './pages/Home/index.dart';
import './pages/Login/index.dart';
import './pages/customer_list.dart';
import './pages/customers.dart';
import './pages/finance.dart';
import './pages/finance_prepay_detail.dart';
import './pages/customer_request.dart';
import './pages/finance_withdrawal_detail.dart';
import './pages/input_dialog.dart';
import './pages/login/welcome.dart';
import './pages/notify.dart';
import './pages/orders.dart';
import './pages/rewards.dart';
import './pages/settings.dart';
import './pages/share_app.dart';
import './pages/topic.dart';
import './pages/upgrade_center.dart';

import './pages/server_set.dart'; // 服务器设置页面
import './pages/user_agreement.dart'; // 用户协议
import './pages/goods_details.dart'; // 商品详情

class Routes {
  Routes() {
    var appModel = AppModel();
    var withAppModel = (context, Widget widget) {
      appModel.setContext(context);
      return widget;
    };

    var themeColor = MaterialColor(
      0xFFE74F42,
      <int, Color>{
        50: Color(0xFFFFE3E0),
        100: Color(0xFFFFC4BF),
        200: Color(0xFFFFB1AA),
        300: Color(0xFFF49087),
        400: Color(0xFFF3756A),
        500: Color(0xFFE74F42),
        600: Color(0xFFD94336),
        700: Color(0xFFCE382B),
        800: Color(0xFFC12C1F),
        900: Color(0xFFB72013),
      },
    );

    runApp(
      ChangeNotifierProvider(
        builder: (context) => appModel,
        child: MaterialApp(
          title: "海创管理平台",
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(
            primarySwatch: themeColor,
          ),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, WelcomeScreen()),
                  settings: settings,
                );
              case '/login':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, LoginScreen()),
                  settings: settings,
                );
              case '/home':
                return MyCustomRoute(
                  builder: (context) {
                    Provider.of<AppModel>(context).refresh(false);
                    return withAppModel(context, HomeScreen());
                  },
                  settings: settings,
                );
              case '/customers':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, Customers()),
                  settings: settings,
                );
              case '/customer_list':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, CustomerList()),
                  settings: settings,
                );
              case '/notify':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, Notify()),
                  settings: settings,
                );
              case '/orders':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, Orders()),
                  settings: settings,
                );
              case '/finance':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, Finance()),
                  settings: settings,
                );
              case '/finance_prepay_detail':
                return MyCustomRoute(
                  builder: (context) =>
                      withAppModel(context, FinancePrepayDetail()),
                  settings: settings,
                );
              case '/finance_withdrawal_detail':
                return MyCustomRoute(
                  builder: (context) =>
                      withAppModel(context, FinanceWithdrawalDetail()),
                  settings: settings,
                );
              case '/customer_request':
                return MyCustomRoute(
                  builder: (context) =>
                      withAppModel(context, CustomerRequest()),
                  settings: settings,
                );
              case '/topic':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, Topic()),
                  settings: settings,
                );
              case '/input':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, InputDialog()),
                  settings: settings,
                );
              case '/rewards':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, Rewards()),
                  settings: settings,
                );
              case '/share_app':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, ShareApp()),
                  settings: settings,
                );
              case '/settings':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, Settings()),
                  settings: settings,
                );
              case '/upgrade_center':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, UpgradeCenter()),
                  settings: settings,
                );
              case '/server_set':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, ServerSet()),
                  settings: settings,
                );
              case '/user_agreement':
                return MyCustomRoute(
                  builder: (context) => withAppModel(context, AgreementPage()),
                  settings: settings,
                );
              case '/goods_details':
                return MyCustomRoute(
                  builder: (context) =>
                      withAppModel(context, GoodsDetailsPage()),
                  settings: settings,
                );
            }
            return null;
          },
        ),
      ),
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return FadeTransition(opacity: animation, child: child);
  }
}
