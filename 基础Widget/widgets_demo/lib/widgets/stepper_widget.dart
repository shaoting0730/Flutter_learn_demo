import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _stepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        currentStep: _stepIndex, // <-- 激活的下标
        onStepCancel: () {
          if (_stepIndex == 0) {
            print('这是第一步');
          } else {
            setState(() {
              _stepIndex = _stepIndex - 1;
            });
          }
        },
        onStepContinue: () {
          if (_stepIndex == 2) {
            print('完成');
          } else {
            setState(() {
              _stepIndex = _stepIndex + 1;
            });
          }
        },
        onStepTapped: (e) {
          setState(() {
            _stepIndex = e.toInt();
          });
        },
        steps: <Step>[
          new Step(
            title: new Text('第一步'),
            content: new Text('第一步内容'),
            state: _stepIndex == 0 ? StepState.complete : StepState.indexed,
            isActive: _stepIndex == 0 ? true : false,
            subtitle: new Text('第一步小标题'),
          ),
          new Step(
            title: new Text('第二步'),
            content: new Text('第二步内容'),
            state: _stepIndex == 1 ? StepState.complete : StepState.indexed,
            isActive: _stepIndex == 1 ? true : false,
          ),
          new Step(
            title: new Text('第三步'),
            content: new Text('第三步内容'),
            state: _stepIndex == 2 ? StepState.complete : StepState.indexed,
            isActive: _stepIndex == 2 ? true : false,
          ),
        ],
      ),
    );
  }

  onStepCancel() {
    print('onStepCancel');
  }

  onStepContinue() {
    print('onStepContinue');
  }

  onStepTapped() {
    print('onStepTapped');
  }
}
