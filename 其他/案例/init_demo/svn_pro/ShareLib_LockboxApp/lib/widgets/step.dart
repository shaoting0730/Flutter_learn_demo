import 'package:flutter/material.dart';

class StepProgress extends StatefulWidget {
  
  final int step;
  StepProgress({this.step = 0});
  @override
  State<StatefulWidget> createState() {
    return StepProgressState();
  }

}

class StepProgressState extends State<StepProgress> {

  int _curStep = 0;

  void next(int step) {

    setState(() {
      _curStep = step;
    });
  }

  @override
  void initState() {
    super.initState();
    _curStep = widget.step;
  }

  @override
  Widget build(BuildContext context) {
    var image = _curStep == 0 ? Image.asset('assets/bg_step1.png') : Image.asset('assets/bg_step2.png');
    return Container(
      width: 200,
      alignment: AlignmentDirectional.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child:Text('Step 1', style: TextStyle(fontSize: 14, color: Color(0xFF536282)))
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child:Text('Step 2', style: TextStyle(fontSize: 14, color: Color(0xFF536282)))
                ),
                flex: 1,
              )
            ]
          ),
          SizedBox(height: 3,),
          image
        ],
      ),
    );
  }

}