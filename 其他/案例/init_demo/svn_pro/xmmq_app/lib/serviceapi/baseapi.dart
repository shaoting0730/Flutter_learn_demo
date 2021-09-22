import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api/customer.dart';

// 微信登录后从我们自己的服务器获的token
dynamic tempToken =
    "8EVh4H7wL9XTbXZH6I1tK9P7akt9dmb0bLkH3mpEvmQ1UBp3p1U/GARDBUVuq3G1eJC1GqJwPKTDre0LI/gVcFc5Wyb4Z+YBr2GE0zWt7YlqheLMB8sHmtKvXBgSNTc60dOTMV0w75T8Cfc0y470IHkFKu9Jcswd7/y+mqHZIIkwa+IGdDVS5NhSSDAco/M3FfO6RR9JemI2PuU4rI94jVKO0oo5Szu5i0JzhL33kIYqWJ22t07gJA3tK9MkqZCo";

// 微信后台给的 code
dynamic wechatCode = "081JRFrc2yAogF0lnpsc2WbArc2JRFrn";

const DEFAULT_STORE_TOKEN_KEY = "cachedtoken";
const CURRENT_STORE_TOKEN_KEY = "cachedcurrenttoken";
const HTTP_REQUEST_TIMEOUT = 300;
const APP_VERSION = "1.1.0";
const IS_ME_KEY = "IS_ME_KEY";

// 微信登录后从我们自己的服务器获的token
LoginResponseModel loginResponse = null;
String DefaultStoreGuid = "404D0EFB-BDA5-4E3A-827F-CF0E4A2AEA24";
String DefaultStoreHost = "WXStore";
String DefaultLoginKey = "uYE2mSW3wJjPeXPTtV8TBL1wYnUdTcezeLulCrjlOuc=";

String getLocaleCode() {
  var code = ui.window.locale.languageCode;
  if (code != 'zh') {
    return 'en';
  }
  return code;
}

String encryptContent(String content) {
  final encrypt.Key key = encrypt.Key.fromBase64(DefaultLoginKey);
  final iv = encrypt.IV.fromUtf8(content);
  final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));
  return encrypter.encrypt(content, iv: iv).base64;
}

void displayErrorMessage(BuildContext context, String message) {
  if (context == null) {
    print("##### Context is null ####");
    return;
  }
  print(message);
  Flushbar flushbar;
  flushbar = Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.red,
    flushbarStyle: FlushbarStyle.GROUNDED,
    messageText: Text(
      message,
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
    // Even the button can be styled to your heart's content
    mainButton: FlatButton(
      child: Text(
        'OK',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        flushbar.dismiss(true);
      },
    ),
    duration: Duration(seconds: 5),
    // Show it with a cascading operator
  )..show(context);
}

bool processResponse(BuildContext context, Map responseBody) {
  if (responseBody.containsKey('Data') &&
      responseBody.containsKey('Success') &&
      responseBody['Success'] == true) {
    return true;
  } else {
    displayErrorMessage(
        context,
        responseBody['ErrorDesc'] != null
            ? responseBody['ErrorDesc']
            : jsonEncode(responseBody));
    return false;
  }
}

int DateTimeToTicks(DateTime datetime) {
  return datetime.millisecondsSinceEpoch * 10000 + 621355968000000000;
}

DateTime TicksToDateTime(int ticks) {
  return DateTime.fromMillisecondsSinceEpoch(
      ((ticks - 621355968000000000) / 10000).toInt());
}

class BaseApi {
  Future<http.Response> get(String api) {
    return http.get(api).timeout(Duration(seconds: HTTP_REQUEST_TIMEOUT));
  }

  Future<Map<String, dynamic>> postWithProcess(
      BuildContext context, String url, data) async {
    var response = await post(context, url, data);
    var responseBody = jsonDecode(response.body);
    if (processResponse(context, responseBody)) return responseBody['Data'];
    return null;
  }

  Future<Map<String, dynamic>> postRawWithProcess(
      BuildContext context, String url, data) async {
//    print(data);
    var response = await postRaw(context, url, data);
    var responseBody = jsonDecode(response.body);
    if (processResponse(context, responseBody)) return responseBody['Data'];
    return null;
  }

  Future<http.Response> post(BuildContext context, String url, data) async {
    try {
      var postBody = encryptContent(jsonEncode(data));
      return http
          .post(url,
              headers: {
                'Content-Type': 'application/json',
                "wbhost": getStoreHost(),
                "StoreGuid": getStoreGuid(),
                "token": getToken(),
                "Platform": "app"
              },
              body: postBody)
          .timeout(Duration(seconds: HTTP_REQUEST_TIMEOUT));
    } catch (e) {
      displayErrorMessage(context,
          "Failed get response from server, please check your mobile network");
      return null;
    }
  }

  Future<http.Response> postRaw(BuildContext context, String url, data) async {
//    print('getStoreHost--- ${getStoreHost()}');
//    print('getStoreGuid--- ${getStoreGuid()}');
//    print('getToken--- ${getToken()}');
//    print('url--- $url');
//    print('参数- $data');
    var postBody;
    if (data is String) {
      postBody = data;
    } else {
      postBody = jsonEncode(data);
    }
    try {
      var response = await http
          .post(url,
              headers: {
                "wbhost": getStoreHost(),
                "StoreGuid": getStoreGuid(),
                "token": getToken(),
                "Platform": "app"
              },
              body: postBody)
          .timeout(Duration(seconds: HTTP_REQUEST_TIMEOUT));
      return response;
    } catch (e) {
      displayErrorMessage(context,
          "Failed get response from server, please check your mobile network");
      return null;
    }
  }

  String getStoreGuid() {
    return loginResponse == null ? DefaultStoreGuid : loginResponse.StoreGuid;
  }

  int getDisableComment() {
    return loginResponse == null ? 0 : loginResponse.DisableComment;
  }

  String getStoreHost() {
    return loginResponse == null ? DefaultStoreHost : loginResponse.StoreName;
  }

  String getWechatCode() {
    return wechatCode;
  }

  void setWechatCode(String code) {
    wechatCode = code;
  }

  String getToken() {
    return loginResponse == null ? tempToken : loginResponse.LoginToken;
  }

  String getStoreCustomerGuid() {
    return loginResponse == null ? "" : loginResponse.StoreCustomerGuid;
  }

  List<PermissionRecordModel> getPermissionList() {
    return loginResponse == null ? [] : loginResponse.Permissions;
  }

  // 设置token
  void setDefaultLoginResponse(
      LoginResponseModel model, bool rememberMe) async {
    loginResponse = model;

    if (rememberMe) {
      var json = jsonEncode(model);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(DEFAULT_STORE_TOKEN_KEY, json);
    }
  }

  void cleanLoginInfo() async {
    loginResponse = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(DEFAULT_STORE_TOKEN_KEY);
    await prefs.remove(CURRENT_STORE_TOKEN_KEY);
    await prefs.remove(IS_ME_KEY);
  }

  // 设置token
  void setCurrentStoreLoginResponse(
      LoginResponseModel model, bool rememberMe) async {
    loginResponse = model;
//    print(json.encode(model));
    if (rememberMe) {
      var json = jsonEncode(model);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(CURRENT_STORE_TOKEN_KEY, json);
    }
  }
}
