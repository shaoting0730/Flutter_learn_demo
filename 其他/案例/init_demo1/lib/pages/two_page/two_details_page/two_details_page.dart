import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/pages/two_page/two_details_page/two_details_controller.dart';
import 'package:init_demo1/widgets/empty_data.dart';
import 'package:init_demo1/widgets/loading.dart';
import 'package:init_demo1/widgets/no_network.dart';

class TwoPage extends GetView<TwoDetailsPageController> {
  const TwoPage({Key? key}) : super(key: key);
  TwoDetailsPageController get sc => Get.put(TwoDetailsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
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

  PreferredSizeWidget _appBarWidget() {
    return AppBar(
      title: Obx(
        () => Text(sc.title.value),
      ),
      centerTitle: true,
    );
  }
}
