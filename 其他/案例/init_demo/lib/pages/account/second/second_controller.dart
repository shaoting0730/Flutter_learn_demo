import 'package:get/get.dart';
import 'package:init_demo/service/service_method.dart';
import 'package:init_demo/service/service_url.dart';
import '../account_controller.dart';

class SecondController extends GetxController {
  var counter = Get.find<AccountController>().counter.obs;
  @override
  void onInit() {
    super.onInit();

    DioUtil().get(servicePath['girlData']).then((value) {
      print(value);
    });
  }
}
