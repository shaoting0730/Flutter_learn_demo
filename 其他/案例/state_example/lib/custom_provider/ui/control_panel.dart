import 'package:flutter/material.dart';
import 'package:state_example/custom_provider/model/logo_model.dart';
import 'package:state_example/custom_provider/model/change_notifier_provider.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<LogoModel>();

    return Card(
      margin: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Flip X: '),
              Switch(
                  value: model.flipX,
                  onChanged: (bool value) => model.flipX = value),
              Text('Flip Y: '),
              Switch(
                  value: model.flipY,
                  onChanged: (bool value) => model.flipY = value),
            ],
          ),
          Slider(
              min: 50,
              max: 300,
              value: model.size,
              onChanged: (double value) => model.size = value)
        ],
      ),
    );
  }
}
