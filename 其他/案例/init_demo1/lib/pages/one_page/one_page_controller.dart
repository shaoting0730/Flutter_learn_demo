import 'package:get/get.dart';
import '../../service/ServiceProvider.dart';
import '../../utils/main_store.dart';
import 'one_data_model.dart';

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
      print('有数据');
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
