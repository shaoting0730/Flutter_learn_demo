import 'package:get/get.dart';

class HomeController extends GetxController {
  final String title = 'Home Title';
  var lgroupValue = '中文'.obs;
  void changeValue(value) {
    lgroupValue.value = value;
  }
}
