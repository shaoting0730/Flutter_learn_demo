import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/widgets/empty_data.dart';
import 'package:init_demo1/widgets/loading.dart';
import 'package:init_demo1/widgets/no_network.dart';
import 'one_page_controller.dart';

class OnePage extends GetView<OnePageController> {
  const OnePage({Key? key}) : super(key: key);

  OnePageController get sc => Get.put(OnePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('demo演示2'),
        centerTitle: true,
      ),
      body: Container(
        child: controller.obx(
          (state) => ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return Text('2ww');
            },
          ),
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
