import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import './tutorial_binding_new_locker.dart';
import '../service/baseapi.dart';

class ScanNewLockboxSearching extends StatefulWidget {
  ScanNewLockboxSearching();

  @override
  State<StatefulWidget> createState() {
    return ScanNewLockboxSearchingState();
  }

}

class ScanNewLockboxSearchingState extends State<ScanNewLockboxSearching> with TickerProviderStateMixin {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'wake_it_up':"Press any key on the lockbox to wake it up",
      'start_scan':"Click center to start scan",
      'how_to_bind':"How to Bind new device",
      'cannot_find':"Cannot find any lockers nearby, please make sure your locker is active",
      'searching': 'Searching device...'
    },
    'zh': {
      'wake_it_up':"按lockbox上面任何按键来唤醒它",
      'start_scan':"按中间按钮来扫描新设备",
      'how_to_bind':"如何绑定新设备",
      'cannot_find':"在附近不能找到任何设备，请确保你的设备是激活状态",
      'searching': '搜索设备中...'
    },
  };

  AnimationController _controller;
  Widget _tutorialPage;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000000),
      vsync: this,
    );

    _controller.forward();


    Future.delayed(Duration(seconds: 30), () {
      if(mounted) {
        Flushbar flushbar;
        flushbar = Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          flushbarStyle: FlushbarStyle.GROUNDED,
          messageText: Text(_localizedValues[getLocaleCode()]["cannot_find"], style: TextStyle(fontSize: 16, color: Colors.white),),
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
          duration: Duration(seconds: 1000),
          // Show it with a cascading operator
        )..show(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.reset();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    var list = List<Widget>();
    list.add(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_add_search_red.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 22,),
            Text(_localizedValues[getLocaleCode()]["searching"], style: TextStyle(color: Colors.white, fontSize: 16),),
            SizedBox(height: 34,),
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg_add_search.png"),
                      fit: BoxFit.none,
                    ),
                  ),
                  width: 350,
                  height: 350,
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1000.0).animate(_controller),
                    child: Image.asset("assets/bg_add_search_turn.png"),
                  )
                ),
                Positioned(
                  top: 70,
                  left: 200,
                  child: Image.asset('assets/ico_add_search_lock.png')
                ),
                Positioned(
                  top:180,
                  left: 80,
                  child: Image.asset('assets/ico_add_search_lock.png')
                ),
                Positioned(
                  top: 250,
                  left: 200,
                  child: Image.asset('assets/ico_add_search_lock.png')
                )
              ],
            ),
            SizedBox(height:35,),
            Text(_localizedValues[getLocaleCode()]["wake_it_up"], style: TextStyle(color: Colors.white, fontSize: 16),),
            Text(_localizedValues[getLocaleCode()]["start_scan"], style: TextStyle(color: Colors.white, fontSize: 16),),
          ]
        )
      ),
    );

    list.add(
      Positioned(
        bottom: 0,
        child: Container(
          alignment: AlignmentDirectional.center,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              _showTutorial();
            },
            child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x15000000),
                  blurRadius: 2.0, // has the effect of softening the shadow
                  spreadRadius: 2.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    0.0, // vertical, move down 10
                  ),
                )
              ]
            ),
              height: 40,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text(_localizedValues[getLocaleCode()]["how_to_bind"], style: TextStyle(color: Colors.white),),
            ),
          )       
        )
      )        
    );
    
    if(_tutorialPage != null) {
      list.add(_tutorialPage);
    }

    return Stack(
      children: list
    );
  }

  void _showTutorial() {
    setState(() {
      _tutorialPage = Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        alignment: AlignmentDirectional.center,
        color: Colors.black.withAlpha(80),
        child: TutorialBindNewLock(onTutorialPressClose: () {
          setState(() {
            _tutorialPage = null;
          });
        },)
      );
    });
  }
}