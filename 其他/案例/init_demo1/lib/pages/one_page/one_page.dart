import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/pages/one_page/one_data_model.dart';
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
            itemCount: sc.state!.length,
            itemBuilder: (BuildContext context, int index) {
              return _contextWidget(sc.state![index]!);
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

  Widget _contextWidget(OneDataModelData data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '时间: ${data.year}年${data.year}月${data.day}日',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            '      ${data.details}',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
