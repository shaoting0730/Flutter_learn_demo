import 'package:get/get.dart';
import 'package:init_demo/service/service_method.dart';
import 'package:init_demo/service/service_url.dart';
import '../account_controller.dart';
import './second_model.dart';

class SecondController extends GetxController {
  var counter = Get.find<AccountController>().counter.obs;
  RxBool isLoading = false.obs;
  List<GirlsList> grilData = <GirlsList>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.toggle();
    DioUtil().get(servicePath['girlData']).then((value) {
      List list = value['data'];
      list.forEach((element) {
        grilData.add(GirlsList.fromJson(element));
        isLoading.toggle();
      });
    });
  }
}
