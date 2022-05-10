import 'package:get/get.dart';

import '../../service/ServiceProvider.dart';
import '../../utils/main_store.dart';
import '../one_page/one_data_model.dart';

class TwoPageController extends GetxController with StateMixin<List<OneDataModelResult?>> {
  late final serviceProvider = ServiceProvider();
  MainStoreController get main => Get.put(MainStoreController());

  addCountAction() {
    main.count.value++;
  }

  @override
  void onInit() {
    super.onInit();
    serviceProvider.postCity({'xxx': 'YYY'}).then((value) {
      print('有数据');
      if (value.statusCode == 200) {
        // ...
        change([], status: RxStatus.success());
        return;
      } else {
        // ....
        change([], status: RxStatus.empty());
        return;
      }
    }, onError: (err) {
      print('错误');
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}
