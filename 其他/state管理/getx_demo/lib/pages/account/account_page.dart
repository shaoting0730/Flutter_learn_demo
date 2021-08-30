import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/pages/account/second/second_page.dart';

import 'account_controller.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              InkWell(
                onTap: () {
                  Get.to(
                    () => SecondPage(
                      name: controller.name,
                      age: controller.age,
                    ),
                  );
                },
                child: Text('跳转二级'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
