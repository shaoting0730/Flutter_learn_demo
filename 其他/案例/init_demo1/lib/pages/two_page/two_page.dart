import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/widgets/empty_data.dart';
import 'package:init_demo1/widgets/loading.dart';
import 'package:init_demo1/widgets/no_network.dart';
import '../../utils/main_store.dart';
import 'two_page_controller.dart';

class TwoPage extends GetView<TwoPageController> {
  const TwoPage({Key? key}) : super(key: key);

  TwoPageController get sc => Get.put(TwoPageController());
  MainStoreController get main => Get.put(MainStoreController());

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
        () => Text('${main.count}'),
      ),
      centerTitle: true,
      actions: [
        InkWell(
          onTap: () => sc.addCountAction(),
          child: Container(
            height: 200,
            width: 100,
            color: Colors.red,
            child: const Center(
              child: Text('+1'),
            ),
          ),
        ),
        InkWell(
          onTap: () => sc.pushTwoDetails(1),
          child: Container(
            width: 50,
            height: 200,
            color: Colors.cyan,
            child: const Center(
              child: Text('去详情'),
            ),
          ),
        )
      ],
    );
  }
}
