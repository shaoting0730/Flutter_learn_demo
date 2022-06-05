import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/pages/two_page/two_details_page/two_details_controller.dart';
import 'package:init_demo1/widgets/empty_data.dart';
import 'package:init_demo1/widgets/loading.dart';
import 'package:init_demo1/widgets/no_network.dart';

class TwoDetailsPage extends GetView<TwoDetailsPageController> {
  const TwoDetailsPage({Key? key}) : super(key: key);
  TwoDetailsPageController get sc => Get.put(TwoDetailsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: Container(
        child: controller.obx(
          (state) => ListView(
            children: [
              Text(sc.t_id.toString()),
              Text(sc.t_name),
              TextButton(
                onPressed: sc.storeValue,
                child: const Text('存值'),
              ),
              TextButton(
                onPressed: sc.getValue,
                child: const Text('取值'),
              ),
            ],
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

  PreferredSizeWidget _appBarWidget() {
    return AppBar(
      title: Obx(
        () => Text(sc.title.value),
      ),
      centerTitle: true,
    );
  }
}
