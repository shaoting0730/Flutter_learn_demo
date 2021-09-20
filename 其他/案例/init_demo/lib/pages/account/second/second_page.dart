import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo/pages/account/second/second_controller.dart';

import '../account_controller.dart';

class SecondPage extends GetView<SecondController> {
  final String name;
  final int age;

  const SecondPage({Key? key, required this.name, required this.age})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('二级'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '参数--' + this.name + this.age.toString(),
            ),
            Obx(
              () => Text("结果 ${Get.put(SecondController()).counter}"),
            ),
            InkWell(
              onTap: () => Get.put(AccountController()).increaseCounter(),
              child: Text(
                '加1',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
