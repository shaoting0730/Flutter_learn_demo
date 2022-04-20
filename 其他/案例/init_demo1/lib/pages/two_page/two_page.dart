import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'two_page_controller.dart';

class TwoPage extends GetView<TwoPageController> {
  const TwoPage({Key? key}) : super(key: key);

  TwoPageController get sc => Get.put(TwoPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('demo演示'),
        centerTitle: true,
      ),
      body: Container(
        child: controller.obx(
          (state) => ListView(),
          onError: (error) => const Text('错误了'),
          onEmpty: const Text('空数据'),
          onLoading: const Text('loading'),
        ),
      ),
    );
  }
}
