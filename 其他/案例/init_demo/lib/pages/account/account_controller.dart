import 'package:get/get.dart';
import 'package:init_demo/service/service_method.dart';
import 'package:init_demo/service/service_url.dart';

class AccountController extends GetxController {
  var counter = 0.obs;
  String name = '名字';
  int age = 18;

  void increaseCounter() {
    counter.value += 1;
  }

  @override
  void onInit() {
    super.onInit();

    DioUtil().get(servicePath['girlData']).then((value) {
      print(value);
    });
  }
}
