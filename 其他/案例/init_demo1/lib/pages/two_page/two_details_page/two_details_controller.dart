import 'package:get/get.dart';
import 'package:init_demo1/utils/log_utils.dart';
import '../../../utils/export_library.dart';

class TwoDetailsPageController extends GetxController with StateMixin<List> {
  var title = '第二的详情'.obs;
  var t_id = 0;
  var t_name = '';

  @override
  void onInit() {
    super.onInit();
    change([], status: RxStatus.success());
    var data = Get.arguments;
    var id = data['id'];
    var name = data['name'];

    t_id = id;
    t_name = name;
    print(data);
  }

  storeValue() async {
    // 存值取值
    setStorage(CONSTANTS.id, '存值的');
  }

  getValue() async {
    var value = await getStorage(CONSTANTS.id);
    Log().logger.d(value);
  }
}
