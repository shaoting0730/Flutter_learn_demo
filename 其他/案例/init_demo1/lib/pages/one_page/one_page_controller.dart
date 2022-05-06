import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../service/CityProvider.dart';
import 'one_data_model.dart';

class OnePageController extends GetxController with StateMixin<List<OneDataModel>> {
  late final oneProvider = OneProvider();

  @override
  void onInit() {
    super.onInit();
    oneProvider.getCity().then((value) {
      print('有数据');
      if (value.statusCode == 200) {
        change(value.body, status: RxStatus.success());
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
