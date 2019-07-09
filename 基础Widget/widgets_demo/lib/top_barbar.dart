import 'package:flutter/material.dart';
import './widgets/Keyboard/keyboard_main.dart';
import './widgets/appbar_widget.dart';
import './widgets/datepicker_widget.dart';
import './widgets//bottomsheet_widget.dart';
import './widgets/dialog_widget.dart';
import './widgets/stepper_widget.dart';
import './widgets/notification_scroll.dart';
import './widgets/rain_drop.dart';
import './widgets/webview_message.dart';
import './widgets/faceId_touchid_widget.dart';
import './widgets/up_drawer.dart';
import './widgets/callback_widget.dart';

class TopBar extends StatefulWidget {
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: topAry.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //  标题数目
  List<Widget> topAry = [
    Tab(text: 'appBar'),
    Tab(text: 'DatePicker'),
    Tab(text: 'BottomSheet'),
    Tab(text: 'Dialog'),
    Tab(text: 'Stepper'),
    Tab(text: '滚动监听'),
    Tab(text: '雨滴动画'),
    Tab(text: '密码输入框'),
    Tab(text: '与webView交互'),
    Tab(text: 'FaceID + TouchID'),
    Tab(text: '上拉抽屉'),
    Tab(text: '回调')
  ];

// 底部view
  bottomAry(context) {
    List<Widget> bottomAry = [
      AppbarWidget(),
      DatePickerWidget(),
      BottomSheetWidget(),
      DialogWidget(),
      StepperWidget(),
      NotificationListenerScroll(),
      Center(
          child: RainDropWidget(
        width: 300,
        height: 400,
      )),
      MainKoard(),
      WebViewPage(),
      TouchIDFaceID(),
      FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpDrawerDemo(),
              ));
        },
        child: Text('跳至上拉抽屉页面'),
      ),
      FlatButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallBackWidget(),
            ),
          );
          // 回调的内容
          print(result);
        },
        child: Text('跳转界面'),
      )
    ];
    return bottomAry;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBar'),
        backgroundColor: Colors.blue,
        bottom:
            TabBar(controller: _controller, isScrollable: true, tabs: topAry),
      ),
      body: TabBarView(
        controller: _controller,
        children: bottomAry(context),
      ),
    );
  }
}
