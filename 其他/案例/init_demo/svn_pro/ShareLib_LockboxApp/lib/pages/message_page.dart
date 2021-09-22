import 'package:flutter/material.dart';
import '../service/baseapi.dart';
import './base_page.dart';
import '../models/showing.dart';
import './message_received_page.dart';
import './message_post_page.dart';
class MessagePage extends BasePage {

  final int curPageIndex;
  final bool canPop;
  MessagePage({this.curPageIndex = 0, this.canPop = true});

  @override
  State<StatefulWidget> createState() {
    return MessagePageState();
  }
}

class MessagePageState extends BasePageState<MessagePage> {

  TabController controller;
  MessageReceivedPage myApprovalPage;
  MessagePostPage myLogPage;
  int curPageIndex = 0;
  List<ShowingRequestModel> receivedMessages = List<ShowingRequestModel>();
  List<ShowingRequestModel> postMessages = List<ShowingRequestModel>();
  List<Tab> tabs = <Tab>[
    
  ];

  var myApprovalPageKey = GlobalKey<MessageReceivedPageState>();
  var myLogPageKey = GlobalKey<MessagePostPageState>();

  @override
  Widget getLeftAction() {
    if(widget.canPop == false) {
      return Container();
    }
    return super.getLeftAction();
  }

  @override
  void initState() {
    super.initState();
    title = "Message";
    
    tabs.add(Tab(
      text: "Approval",
    ));
    if(isAgent) {
      tabs.add(Tab(
        text: "My Showing Request"
      ));
    }
    controller = TabController(length: tabs.length, initialIndex: widget.curPageIndex, vsync: this)..addListener(() {
      setState(() {
        curPageIndex =controller.index;
      });
    });

    curPageIndex = widget.curPageIndex;

    myApprovalPage = MessageReceivedPage(key:myApprovalPageKey, parentPage: this, onRequestMessagePageRefresh:(String message) {
      _onRequestRefresh(context, message);
    } );
    myLogPage = MessagePostPage(key:myLogPageKey, parentPage: this, onRequestMessagePageRefresh:(String message) {
      _onRequestRefresh(context, message);
    } );

  }

  @override
  Widget pageContent(BuildContext context) {
    switch (curPageIndex) {
      case 0:
        return myApprovalPage;
      case 1:
        return myLogPage;
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
  void _onRequestRefresh(BuildContext context, String message) {
    if(message != null) {
      showErrorMessage(context, message);
    }

    if(mounted) {
      setState(() {
        myApprovalPage = MessageReceivedPage(key:myApprovalPageKey, parentPage: this, onRequestMessagePageRefresh:(String message) {
          _onRequestRefresh(context, message);
        });
        myLogPage = MessagePostPage(key:myLogPageKey, parentPage: this, onRequestMessagePageRefresh:(String message) {
          _onRequestRefresh(context, message);
        });
      });
    }
    
  }

  @override
  void onScrollToTopPressed() {
    if(myApprovalPageKey.currentState != null) {
      myApprovalPageKey.currentState.scrollToTop();
    }

    if(myLogPageKey.currentState != null) {
      myLogPageKey.currentState.scrollToTop();
    }

  }
}
