import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:init_demo/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioUtil {
  Dio dio = Dio();

  DioUtil() {
    dio.options.connectTimeout = 3000;
  }

// 获取数据
  Future get(url, {formData}) async {
    try {
      Response response;
      if (formData == null) {
        response = await dio.get(url);
      } else {
        response = await dio.get(url, queryParameters: formData);
      }
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('后端接口出现异常');
      }
    } catch (e) {
      // BuildContext context = navigatorKey.currentState!.context;
      Fluttertoast.showToast(msg: '请求$url失败');
      return print(e);
    }
  }

  Future post(url, {formData}) async {
    try {
      SharedPreferences prefs =
          SharedPreferences.getInstance() as SharedPreferences;
      var token = prefs.getString('token');
      dio.options.headers = {
        'Content-Type': 'application/json',
        'token': token
      };
      Response response;
      if (formData == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: formData);
      }
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('后端接口出现异常');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '请求$url失败');
      return print(e);
    }
  }
}
