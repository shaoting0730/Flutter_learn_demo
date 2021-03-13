import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../account_controller.dart';

class SecondPage extends GetView<AccountController> {
  final String name;
  final int age;

  SecondPage({Key key, @required this.name, this.age});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('二级'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '参数--' + this.name + this.age.toString(),
              ),
              Obx(
                () => Text("结果 ${controller.counter.value}"),
              ),
              InkWell(
                onTap: () => controller.increaseCounter(),
                child: Text(
                  '加1',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
