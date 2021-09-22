import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import '../widgets/transparent_route.dart';
import './fast_pass_page.dart';

abstract class BasePage extends StatefulWidget {
  
}

abstract class BasePageState<T extends StatefulWidget> extends State<T> with TickerProviderStateMixin {

  // a flag to display the loading Indicator
  bool shouldDisplayProgressIndicator = false;

  String title = "Untitled";

  bool isFloatingPanelDisplayed = false;
  bool isDisplayScrollToTop = false;
  bool hiddenAppBar = false;
  bool hiddenFastPass = false;
  Animation<double> _floatingPositionAnimation;
  AnimationController _controller;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync:this, duration: Duration(microseconds: 600));

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void willPopup()
  {

  }

  @override
  Widget build(BuildContext context) {
    
    var builder = Builder(
      builder: (BuildContext context) {
        var list = <Widget>[];
        list.add(pageContent(context));
        if(shouldDisplayProgressIndicator) {
          list.add(_buildProgressSpinner());
        }

        var floatingLayer =_buildFloatingLayer(context);
        if(floatingLayer != null) {
          list.add(floatingLayer);
        }

        return GestureDetector(
          onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: list,
          )
        );
      
      }
    );
    if(hiddenAppBar) {
      return WillPopScope(
        child: Scaffold(
            body: builder
        ),
        onWillPop: () {
          willPopup();
          if(Navigator.canPop(context))
            Navigator.pop(context);
        },
      );
    } else {
      return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
                key: scaffoldKey,
                titleSpacing: 0.0,
                title: Text(title, style: TextStyle(color:Color(0xFF3A3A3A))),
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                bottom: getTabBars(),
                leading: getLeftAction(),
                actions:getRightActions()
            ),
            floatingActionButton: scrollToTopFloatingActionButton(),
            body: builder
        ),
        onWillPop: () {
          willPopup();
          if(Navigator.canPop(context))
            Navigator.pop(context);
        },
      );
    }
  }

  @protected
  Widget pageContent(BuildContext context) ;

  void displayScrollToTop() {
    setState(() {
      isDisplayScrollToTop = true;
    });
  }

  void hidenScrollToTop() {
    setState(() {
      isDisplayScrollToTop = false;
    });
  }

  Widget scrollToTopFloatingActionButton() {
    if(isDisplayScrollToTop) {
      return Container(
        height: 50.0,
        width: 50.0,
        alignment: AlignmentDirectional.center,
        child: FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white.withAlpha(0),
            onPressed: () {
              onScrollToTopPressed();
            },
            child: Container(
              height: 55,
              width: 55,
              alignment: AlignmentDirectional.center,
              child: Image.asset('assets/icon_listing_top.png', height: 55, width: 55, fit: BoxFit.fill,),
            ),
          )
      );
    }
    return null;
  }

  void onScrollToTopPressed() {

  }

  Widget getTabBars() {
    return null;
  }

  List<Widget> getRightActions() {
    if(hiddenFastPass)
      return List<Widget>();
    return <Widget>[
      IconButton(
        icon: ImageIcon(AssetImage('assets/ic_mine_s.png')),
        color: Colors.black,
        onPressed: () {
          onTapFastPass(scaffoldKey.currentContext);
        },
      )
    ];
  }

  void onTapFastPass(BuildContext context) {
    Navigator.push(context, TransparentRoute(builder: (BuildContext context) => FastPassPage(fromPageTitle: title,)));
  }

  Widget getLeftAction() {
    if(!Navigator.canPop(context))
    {
      return Container();
    }
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: (){
        willPopup();
        if(Navigator.canPop(context))
          Navigator.pop(scaffoldKey.currentContext);
      },
    );

  }

  Widget floatingLayer(BuildContext context) {
    return null;
  }

  Widget _buildFloatingLayer(BuildContext context) {
    var layer = floatingLayer(context);
    double floatingPanelHeight = MediaQuery.of(context).size.height - 200;
    if(_floatingPositionAnimation == null) {
      _floatingPositionAnimation = Tween<double>(begin:  - (floatingPanelHeight - 100), end: 0).animate(_controller);
    }
    if(layer!= null) {

      return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget widget) {
          return Positioned(
            bottom: _floatingPositionAnimation.value,
            child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: floatingPanelHeight,
                child: layer,
              ),
              onTap: () {
                displayFloatingPanel(true);
              },
            )
          );
        },
      
      );
    } else {
      return null;
    }
  }

  void displayFloatingPanel(bool display) {
    isFloatingPanelDisplayed = display;
    if(display) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void displayProgressIndicator(bool display) {
    if(mounted == false) {
      return ;
    }
    
    setState(() {
      shouldDisplayProgressIndicator = display;
    });
  }

  // 显示 loading spinner
  Widget _buildProgressSpinner() {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: const ModalBarrier(dismissible: false, color: Colors.black)
        ),
        Center(
          child: CircularProgressIndicator()
        )
      ]
    );
  }

  void showToastMessage(BuildContext context, String message) {
    final scaffold =  scaffoldKey.currentContext != null ? Scaffold.of(scaffoldKey.currentContext): Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(message, style: TextStyle(fontSize: 16),),
        action: SnackBarAction(
          label: 'OK', 
          onPressed: scaffold.hideCurrentSnackBar
        ),
      ),
    );
  }

  void showErrorMessage(BuildContext context, String message) {
    Flushbar flushbar;
    flushbar = Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.red,
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageText: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text(message, style: TextStyle(fontSize: 16, color: Colors.white),)
      ),
      // Even the button can be styled to your heart's content
      mainButton: FlatButton(
        child: Text(
          'OK',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          flushbar.dismiss(true);
        },
      ),
      duration: Duration(seconds: 5),
      // Show it with a cascading operator
    )..show(context);
  }
}
