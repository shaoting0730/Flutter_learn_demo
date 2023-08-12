import 'package:flutter/material.dart';
import 'package:state_example/custom_provider/model/logo_model.dart';
import 'package:state_example/custom_provider/model/change_notifier_provider.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LogoModel>();
    return Card(
      child: Transform.flip(
        flipX: model.flipX,
        flipY: model.flipY,
        child: FlutterLogo(size: model.size),
      ),
    );
  }
}
