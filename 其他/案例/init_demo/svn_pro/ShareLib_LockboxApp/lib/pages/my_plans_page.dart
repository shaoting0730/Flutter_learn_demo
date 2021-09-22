import 'package:flutter/material.dart';
import './my_plans_upcoming_page.dart';
import './my_plans_today_page.dart';
import 'base_page.dart';
import 'search_page.dart';
import '../models/ui/plan_model.dart';
import '../widgets/message_badge.dart';

bool postRegistration = false;

class MyPlansPage extends BasePage {

  final int pageIndex;
  MyPlansPage({this.pageIndex = 0});

  @override
  State<StatefulWidget> createState() {
    return MyPlansPageState();
  }
}


MyPlansPageState gMyPlansPageState;

void updateMyPlanMessageCount(int badge) {
  if(gMyPlansPageState != null) {
    gMyPlansPageState.updateMessageBadge(badge);
  }
}

class MyPlansPageState extends BasePageState<MyPlansPage> {
  
  TabController controller;
  Widget todayPage;
  Widget upcomingPage;
  int curPageIndex = 0;
  int _badge = 0;

  List<PlanModel> todayPlans = List<PlanModel>();
  List<PlanModel> upcomingPlans = List<PlanModel>();
  var _todayPageKey = GlobalKey<TodayPlanPageState>();
  var _upcomingPageKey = GlobalKey<UpcomingPlanPageState>();

  void updateMessageBadge(int badge) {
    if(mounted) {
      setState(() {
        _badge = badge;
      });
    }
  }
  List<Tab> tabs = <Tab>[
    Tab(
      text: "Today",
    ),
    Tab(
        text: "All Upcoming"
    ),
  ];

  void _onRequestRefresh(BuildContext context, String message) {
    if(message != null){
      showErrorMessage(context, message);
    }
  }

  @override
  void initState() {
    super.initState();
    title = "My Showing Request";
    controller = TabController(length: 2, initialIndex:widget.pageIndex, vsync: this)..addListener(() {
      setState(() {
        curPageIndex =controller.index;
      });
    });

    curPageIndex = widget.pageIndex;

    gMyPlansPageState = this;

    todayPage = TodayPlanPage(key:_todayPageKey, onRequestMessagePageRefresh:(String message) {
      _onRequestRefresh(context, message);});
    upcomingPage = UpcomingPlanPage(key:_upcomingPageKey, onRequestMessagePageRefresh:(String message) {
      _onRequestRefresh(context, message);});

      displayScrollToTop();

  }

  @override
  Widget pageContent(BuildContext context) {
    switch (curPageIndex) {
      case 0:
        return todayPage;
      case 1:
        return upcomingPage;
      default:
        return null;
    }
  }

  @override
  Widget getTabBars() {
    return TabBar(
      isScrollable: true,
      labelColor: Colors.black,
      tabs: tabs,
      controller: controller,
    );
  }

  @override
  Widget getLeftAction() {
      return IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        onPressed: (){
          Navigator.push(scaffoldKey.currentContext, MaterialPageRoute(builder: (context) => SearchPage()));
        },
      );
  }

  @override
  List<Widget> getRightActions() {
    return <Widget>[
      MessageBadgeIcon(badge: _badge),
      IconButton(
        icon: ImageIcon(AssetImage('assets/ic_mine_s.png')),
        color: Colors.black,
        onPressed: () {
          onTapFastPass(scaffoldKey.currentContext);
        },
      )
    ];
  }

  @override
  void onScrollToTopPressed() {
    if(_todayPageKey.currentState != null) {
      _todayPageKey.currentState.scrollToTop();
    }

    if(_upcomingPageKey.currentState != null) {
      _upcomingPageKey.currentState.scrollToTop();
    }
  }
}
