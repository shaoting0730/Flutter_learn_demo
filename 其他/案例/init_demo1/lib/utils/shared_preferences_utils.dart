import 'package:shared_preferences/shared_preferences.dart';

// 设置
setStorage(String key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (value is String) {
    prefs.setString(key, value);
  } else if (value is num) {
    prefs.setInt(key, value as int);
  } else if (value is double) {
    prefs.setDouble(key, value);
  } else if (value is bool) {
    prefs.setBool(key, value);
  } else if (value is List) {
    prefs.setStringList(key, value.cast<String>());
  }
}

// 获取
getStorage(String key, [dynamic replace]) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = prefs.get(key);
  return data ?? replace;
}

// 移除
removeStorage(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

removeAllStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
