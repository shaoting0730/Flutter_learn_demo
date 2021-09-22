import 'package:flutter/material.dart';
import '../service/baseapi.dart';

typedef  OnTutorialPressClose = void Function();

class TutorialBindNewLock extends StatefulWidget {
  
  final OnTutorialPressClose onTutorialPressClose;
  TutorialBindNewLock({this.onTutorialPressClose});

  @override
  State<StatefulWidget> createState() {
    return TutorialBindNewLockState();
  }

}

class TutorialBindNewLockState extends State<TutorialBindNewLock> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'how_to_bind':"How to Bind new device",
      "step_1": "step 1",
      "step_2": "step 2",
      "step_3": "step 3",
      "step_1_detail": 'Press any key on the lockbox to wake it up',
      "step_2_detail": 'When you see the device display, click on \"Bind\" button',
      "step_3_detail": 'Scan the barcode on the back of the device'
    },
    'zh': {
      'how_to_bind':"如何绑定新设备",
      "step_1": "第一步",
      "step_2": "第二步",
      "step_3": "第三步",
      "step_1_detail": '按锁盒上面任意健来唤醒锁',
      "step_2_detail": '当锁盒上显示器亮起，按“绑定”按钮',
      "step_3_detail": '扫描设备背后的二维码'
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildClose(),
            _buildHead(),
            _buildContent()
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: 320,
      padding: const EdgeInsets.fromLTRB(20, 30, 29, 15),
      child: Column(
        children: <Widget>[
          Container(
            height: 280,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Color(0xFF536282),
                          borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(0xFFE1E1E1),
                          width: 1,
                        )
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_localizedValues[getLocaleCode()]["step_1"]),
                        Text(_localizedValues[getLocaleCode()]["step_1_detail"]),
                        SizedBox(height: 20,),
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: Image.asset('assets/ico_rule_lock_front.png')
                        )
                        
                      ]
                    )
                  )
                )
              ],
            ),
          ),
          Container(
            height: 280,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Color(0xFF536282),
                          borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(0xFFE1E1E1),
                          width: 1,
                        )
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_localizedValues[getLocaleCode()]["step_2"]),
                        Text(_localizedValues[getLocaleCode()]["step_2_detail"]),
                        SizedBox(height: 20,),
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: Image.asset('assets/bg_scan_confirm.png')
                        )
                        
                      ]
                    )
                  )
                )
              ],
            ),
          ),
          Container(
            height: 280,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Color(0xFF536282),
                          borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(0x00E1E1E1),
                          width: 1,
                        )
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_localizedValues[getLocaleCode()]["step_3"]),
                        Text(_localizedValues[getLocaleCode()]["step_3_detail"]),
                        SizedBox(height: 20,),
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: Image.asset('assets/bg_scan_open.png')
                        )
                      ]
                    )
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHead() {
    return Container(
      child: Text(_localizedValues[getLocaleCode()]["how_to_bind"], style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600), ),
    );
  }

  Widget _buildClose(){
    return Container(
      width: 320,
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      alignment: AlignmentDirectional.centerEnd,
      height: 30,
      child: InkWell(
        onTap: () {
          if(widget.onTutorialPressClose != null) {
            widget.onTutorialPressClose();
          }
        },
        child: Image.asset('assets/icon_dialog_close.png'),
      )
    );
  }

}