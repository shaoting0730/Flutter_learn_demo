import 'package:encrypt/encrypt.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../models/loginmodel.dart';
import '../models/app_model.dart';
import '../services/serviceapi.dart';

const TOKEN_KEY = "token2";
const HTTP_REQUEST_TIMEOUT = 300;
const APP_VERSION = "1.1.0";

// 微信登陆后从我们自己的服务器获的token
LoginResponseModel loginResponse = null;
bool isAgent, isAgentAssistant, isHouseOwner;

bool isOnlyForPerson = false;

String getStoreName() {
  return "abm.51taouk.com";
}

String encrypt(String content) {
  var key =
      crypto.Key.fromBase64("2VpXCltbXc425r2Oh9qJfbwOQGACuVKoy+7WKFsUIW8=");
  var iv = crypto.IV.fromUtf8(content);
  var encrypt = crypto.Encrypter(crypto.AES(key, iv, mode: crypto.AESMode.ecb));
  return encrypt.encrypt(content).base64;
}

String getLocaleCode() {
  if (isOnlyForPerson == false) {
    return "en";
  }

  var code = ui.window.locale.languageCode;
  if (code != 'zh') {
    return 'en';
  }
  return code;
}

class BaseApi {
  Future<http.Response> get(String api) async {
    return await http.get(api, headers: {"token": getToken()}).timeout(
        Duration(seconds: HTTP_REQUEST_TIMEOUT));
  }

  Future<http.Response> post(String url, data) async {
    var postBody = jsonEncode(data);
    print(getStoreName());
    return http
        .post(url,
            headers: {
              'Content-Type': 'application/json',
              "wbhost": getStoreName(),
              "token": getToken()
            },
            body: postBody)
        .timeout(Duration(seconds: HTTP_REQUEST_TIMEOUT));
  }

  Future<http.Response> postLogin(String url, data) async {
    var postBody = encrypt(jsonEncode(data));
    return http.post(url, headers: {
      'Content-Type': 'application/json',
      "wbhost": getStoreName(),
      "token": postBody
    }).timeout(Duration(seconds: HTTP_REQUEST_TIMEOUT));
  }

  String getToken() {
    return loginResponse == null
        ? "uO8wyX8PXHIA/B4UjfaRu7YXONFdoTWZ8g5DqHUMLMv4ssNl4et+PEM8WctqqA/+2nIUjZvdO7RgHc8EeUHGPjCx9iQxkvhYq9NjFo1zol1tyqgEz2KKXx+HyfLp9Mw9ldPdFf33mEzk1As1VVm4dQ=="
        : loginResponse.LoginToken;
  }

  String getStoreCustomerGuid() {
    return loginResponse == null ? "" : loginResponse.StoreCustomerGuid;
  }

  List<PermissionRecordModel> getPermissionList() {
    return loginResponse == null ? [] : loginResponse.Permissions;
  }

  // 设置token
  void setLoginResponse(Map loginResponse, bool rememberMe) async {
    if (rememberMe) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(TOKEN_KEY, jsonEncode(loginResponse));
    }
  }

  static Future<bool> clearLoginResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
    return true;
  }

  loadLoginResponse(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonString = prefs.getString(TOKEN_KEY);
    return jsonString != null
        ? processLoginResponse(context, jsonDecode(jsonString))
        : null;
  }

  LoginResponseModel processLoginResponse(
      BuildContext context, Map responseBody) {
    if (!processResponse(context, responseBody)) {
      return null;
    }

    if (responseBody.containsKey('Success') &&
        responseBody['Success'] == true) {
      loginResponse = LoginResponseModel.fromJson(responseBody);
      Provider.of<AppModel>(context).updateLoginInfo(loginResponse);
      return loginResponse;
    }

    return null;
  }

  bool processResponse(BuildContext context, Map responseBody) {
    if (responseBody.containsKey('Success') &&
        responseBody['Success'] == false) {
      if (responseBody.containsKey('Message') &&
          responseBody['Message'] != null &&
          responseBody['Message'] != '') {
        displayErrorMessage(context, responseBody['Message']);
      }
      return false;
    }

    if (responseBody.containsKey('Success') &&
        responseBody['Success'] == true) {
      return true;
    }

    if (responseBody.containsKey('Message') &&
        responseBody['Message'] != null &&
        responseBody['Message'] != '') {
      displayErrorMessage(context, responseBody['Message']);
      return false;
    }

    return true;
  }
}
