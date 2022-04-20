import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'one_page_controller.dart';

class OnePage extends GetView<OnePageController> {
  const OnePage({Key? key}) : super(key: key);

  OnePageController get sc => Get.put(OnePageController());

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
          onLoading: Container(
            child: Center(
              child: Text('网络正在加载中'),
            ),
          ),
        ),
      ),
    );
  }
}
