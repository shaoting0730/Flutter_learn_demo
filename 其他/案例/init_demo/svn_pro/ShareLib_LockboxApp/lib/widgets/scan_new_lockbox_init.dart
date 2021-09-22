import 'package:flutter/material.dart';
import './tutorial_binding_new_locker.dart';
import '../service/baseapi.dart';

typedef OnTapBeginScan = void Function();

class ScanNewLockboxInit extends StatefulWidget {
  final OnTapBeginScan onTapBeginScan;

  ScanNewLockboxInit({this.onTapBeginScan});

  @override
  State<StatefulWidget> createState() {
    return ScanNewLockboxInitState();
  }
}

class ScanNewLockboxInitState extends State<ScanNewLockboxInit> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'to_find_your_device':'To find your device',
      'wake_it_up':"Press any key on the lockbox to wake it up",
      'start_scan':"Click center to start scan",
      'how_to_bind':"How to Bind new device"
    },
    'zh': {
      'to_find_your_device':'去发现你的设备',
      'wake_it_up':"按锁盒上面任何按键来唤醒它",
      'start_scan':"按中间按钮来扫描新设备",
      'how_to_bind':"如何绑定新设备"
    },
  };

  Widget _tutorialPage;

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
            Text(_localizedValues[getLocaleCode()]["to_find_your_device"], style: TextStyle(color: Colors.white, fontSize: 16),),
            SizedBox(height: 34,),
            Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg_add_search.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: InkWell(
                onTap: () {
                  if(widget.onTapBeginScan != null) {
                    widget.onTapBeginScan();
                  }
                },
                child: Image.asset('assets/ico_add_touch_lock.png')
              )
            ),
            SizedBox(height:35,),
            Text(_localizedValues[getLocaleCode()]["wake_it_up"], style: TextStyle(color: Colors.white, fontSize: 16),),
            Text(_localizedValues[getLocaleCode()]["start_scan"], style: TextStyle(color: Colors.white, fontSize: 16),),
          ]
        )
      )
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