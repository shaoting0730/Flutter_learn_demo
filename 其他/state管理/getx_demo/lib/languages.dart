import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'hello': '你好 世界',
          'one': '首页',
          'two': '我的',
        },
        'en_US': {
          'hello': 'Hello World',
          'one': 'Home',
          'two': 'Mine',
        }
      };
}
