import 'package:riverpod_pro/service/service_method.dart';
import 'package:riverpod_pro/service/service_url.dart';

import '../pages/home_page/model/home_page_model.dart';

// 请求数据
Future<HomeDataModel> getHomeData() async {
  var json = await DioUtil().get(servicePath['homeData']);
  return HomeDataModel.fromJson(json);
}
