import 'package:get/get.dart';

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
    // ignore: avoid_print
    print('我的加载了');
  }
}
