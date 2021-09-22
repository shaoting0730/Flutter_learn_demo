import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo/pages/account/account_controller.dart';
import 'package:init_demo/pages/account/second/second_controller.dart';

class SecondPage extends GetView<SecondController> {
  SecondController get sc => Get.put(SecondController());
  final String name;
  final int age;
  final Function callBack;
  const SecondPage({
    Key? key,
    required this.name,
    required this.age,
    required this.callBack,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            callBack("回调的值");
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Row(
          children: [
            Text(
              '参数--' + name + age.toString(),
            ),
            Obx(
              () => Text("结果 ${Get.put(SecondController()).counter}"),
            ),
            InkWell(
              onTap: () => Get.put(AccountController()).increaseCounter(),
              child: const Text(
                '加1',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: sc.grilData.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sc.grilData[index].author.toString()),
                Text(sc.grilData[index].desc.toString()),
                FadeInImage.assetNetwork(
                  height: 200,
                  placeholder: 'assets/tab/one.png',
                  image: sc.grilData[index].images![0],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
