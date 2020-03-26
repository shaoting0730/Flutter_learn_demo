import 'package:dio/dio.dart';
import 'dart:async';

import '../model/twoModel.dart';

class ServiceApi {
  Future twoGetData() async {
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.get('https://gank.io/api/v2/banners');
      TwoModel model = TwoModel.fromJson(response.data);
      print('>>>>>>>>>>>>>>>status:${model.status}');
      return model;
    } catch (e) {
      print('发送错误');
      print(e);
    }
  }
}
