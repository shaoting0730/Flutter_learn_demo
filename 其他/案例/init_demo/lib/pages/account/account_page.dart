import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo/pages/account/second/second_page.dart';
import 'account_controller.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Text("结果 ${controller.counter.value}"),
            ),
            InkWell(
              onTap: () => controller.increaseCounter(),
              child: const Text(
                '加1',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
            InkWell(
              onTap: () {
                var result = Get.toNamed("/account/second", parameters: {
                  "name": controller.name,
                  "age": controller.age.toString(),
                });
                print(result);
                // Get.to(
                //   () => SecondPage(
                //     name: controller.name,
                //     age: controller.age,
                //     callBack: (e) {
                //       print('回来了 $e');
                //     },
                //   ),
                // );
              },
              child: const Text('跳转二级'),
            ),
          ],
        ),
      ),
    );
  }
}
