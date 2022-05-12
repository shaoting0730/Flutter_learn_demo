import 'package:get/get.dart';

class TwoDetailsPageController extends GetxController with StateMixin<List> {
  var title = '第二的详情'.obs;

  @override
  void onInit() {
    super.onInit();
    change([], status: RxStatus.success());
    var data = Get.arguments;
    var id = data['id'];
    var name = data['name'];
    print(data);
  }
}
