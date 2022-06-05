import 'package:init_demo1/utils/log_utils.dart';

import '../../service/ServiceProvider.dart';
import 'one_data_model.dart';
import '../../utils/export_library.dart';

class OnePageController extends GetxController with StateMixin<List<OneDataModelResult?>> {
  late final serviceProvider = ServiceProvider();
  MainStoreController get main => Get.put(MainStoreController());

  addCountAction() {
    main.count.value++;
  }

  @override
  void onInit() {
    super.onInit();
    serviceProvider.getOneData().then((value) {
      Log().logger.w('有数据');
      if (value.statusCode == 200 && value.body!.result != null) {
        List<OneDataModelResult?>? list = value.body!.result;
        change(list, status: RxStatus.success());
        return;
      } else {
        change([], status: RxStatus.empty());
        return;
      }
    }, onError: (err) {
      print('错误');
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}
