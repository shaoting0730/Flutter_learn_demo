import 'package:flutter/material.dart';
import './widgets/appbar_widget.dart';
import './widgets/datepicker_widget.dart';
import './widgets//bottomsheet_widget.dart';
import './widgets/dialog_widget.dart';
import './widgets/stepper_widget.dart';
import './widgets/notification_scroll.dart';

class TopBar extends StatefulWidget {
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 10, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('topBar'),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: <Widget>[
            Tab(text: 'appBar'),
            Tab(text: 'DatePicker'),
            Tab(text: 'BottomSheet'),
            Tab(text: 'Dialog'),
            Tab(text: 'Stepper'),
            Tab(text: '滚动监听'),
            Tab(text: '柒'),
            Tab(text: '捌'),
            Tab(text: '玖'),
            Tab(icon:Icon(Icons.business_center)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          AppbarWidget(),
          DatePickerWidget(),
          BottomSheetWidget(),
          DialogWidget(),
          StepperWidget(),
          NotificationListenerScroll(),
          Text('77'),
          Text('88'),
          Text('99'),
          Text('100'),
        ],
      ),
    );
  }
}