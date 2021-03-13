import 'package:get/get.dart';

class AccountController extends GetxController {
  var counter = 0.obs;
  var name = '名字';
  var age = '年龄';

  void increaseCounter() {
    counter.value += 1;
  }
}
