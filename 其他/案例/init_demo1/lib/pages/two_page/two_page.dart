import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/widgets/empty_data.dart';
import 'package:init_demo1/widgets/loading.dart';
import 'package:init_demo1/widgets/no_network.dart';
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
          onError: (error) => NoNetworkWidget(
            error: error!,
          ),
          onEmpty: const EmptyDataWidget(),
          onLoading: const LoadingWidget(),
        ),
      ),
    );
  }
}
