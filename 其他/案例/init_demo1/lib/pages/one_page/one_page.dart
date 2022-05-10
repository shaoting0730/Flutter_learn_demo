import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/pages/one_page/one_data_model.dart';
import 'package:init_demo1/widgets/empty_data.dart';
import 'package:init_demo1/widgets/loading.dart';
import 'package:init_demo1/widgets/no_network.dart';
import '../../utils/main_store.dart';
import 'one_page_controller.dart';
import 'package:init_demo1/utils/constants.dart';

class OnePage extends GetView<OnePageController> {
  const OnePage({Key? key}) : super(key: key);

  OnePageController get sc => Get.put(OnePageController());
  MainStoreController get main => Get.put(MainStoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
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

  PreferredSizeWidget _appBarWidget() {
    return AppBar(
      title: Obx(
        () => Text('${CONSTANTS.name}+${main.count}'),
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
      ],
    );
  }

  Widget _contextWidget(OneDataModelResult data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data.AssetLong}——${data.Asset}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          '详情:',
          style: TextStyle(color: Colors.blueGrey, fontSize: 12),
        ),
        Text(
          'MinConfirmation:${data.MinConfirmation}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'WithdrawTxFee:${data.WithdrawTxFee}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'WithdrawTxFeePercent:${data.WithdrawTxFeePercent}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'SystemProtocol:${data.SystemProtocol}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'IsActive:${data.IsActive}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'InfoMessage:${data.InfoMessage}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'MaintenanceMode:${data.MaintenanceMode}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'MaintenanceMessage:${data.MaintenanceMessage}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'FormatPrefix:${data.FormatPrefix}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'FormatSufix:${data.FormatSufix}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'DecimalSeparator:${data.DecimalSeparator}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'ThousandSeparator:${data.ThousandSeparator}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'DecimalPlaces:${data.DecimalPlaces}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          'withdrawal_fee_schedule:${data.withdrawalFeeSchedule}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
