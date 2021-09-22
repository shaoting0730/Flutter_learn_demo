import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart';
import '../models/loginmodel.dart';
import './scheduled_service.dart';

const TOKEN_KEY = "token2";
const HTTP_REQUEST_TIMEOUT=300;
const APP_VERSION = "1.1.0";

String encrypt(String content) {
  final Key key = Key.fromBase64(isOnlyForPerson ? "sVs8WLiPzyFyN7redmCh5e5BwB91MgQ/WuqRL0//+mc=" : "uYE2mSW3wJjPeXPTtV8TBL1wYnUdTcezeLulCrjlOuc=");
  final iv = IV.fromUtf8(content);
  final encrypter = Encrypter(AES(key, iv, mode: AESMode.ecb));
  return encrypter.encrypt(content).base64;
}

// 微信登陆后从我们自己的服务器获的token
LoginResponseModel loginResponse = null;
bool isAgent = false, isAgentAssistant = false, isHouseOwner = false;

bool isOnlyForPerson = false;///true=imlockbox app;  false=reliableshowing app
String Server_Region = "us";///us=美国服务器 , china=中国服务器

String getLocaleCode() {
  
  if(isOnlyForPerson == false) {
    if(isAgent || isAgentAssistant || isHouseOwner)
      return "en";
  }
  if(ui.window.locale==null)
    return 'en';
  var code = ui.window.locale.languageCode;
  if(code != 'zh') {
    return 'en';
  }
  return code;
}

class BaseApi {

  Future<http.Response> get(String api) {
    return http.get(api).timeout(new Duration(seconds: HTTP_REQUEST_TIMEOUT));
  }

  Future<http.Response> post(String url, data) async {
    var postBody =  encrypt(jsonEncode(data));
    return http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "wbhost": getStoreName() ,
        "StoreGuid":getStoreGuid(),
        "token":getToken()
      },
      body: postBody
    ).timeout(new Duration(seconds: HTTP_REQUEST_TIMEOUT));
  }

  Future<http.Response> postRaw(String url, data) async {
    return http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "wbhost": getStoreName() ,
        "StoreGuid":getStoreGuid(),
        "token":getToken()
      },
      body: data
    ).timeout(new Duration(seconds: HTTP_REQUEST_TIMEOUT));
  }

  String getStoreName() {
    return isOnlyForPerson?"ImLockbox":"ReliableShowing";
    ///return "ReliableShowing";
  }

  String getStoreGuid() {
    return isOnlyForPerson?"6DCD29B5-DEBA-447D-B50F-D5C2050B8B9D":"83D9D399-4099-4E12-B1BF-56C9868FB5B0";
    ///return "83D9D399-4099-4E12-B1BF-56C9868FB5B0";
  }

  String getToken() {
    return loginResponse==null?"":loginResponse.LoginToken;
  }
  String getStoreCustomerGuid() {
    return loginResponse==null?"":loginResponse.StoreCustomerGuid;
  }
  List<PermissionRecordModel> getPermissionList()
  {
    return loginResponse==null?[]:loginResponse.Permissions;
  }
  // 设置token
  void setLoginResponse(LoginResponseModel model, bool rememberMe) async {
    var json = jsonEncode(model.toJson());
    isAgent = false;
    isAgentAssistant = false;
    isHouseOwner = false;
    loginResponse = model;
    if(rememberMe) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(TOKEN_KEY, json);
    }
    if(!isOnlyForPerson)
    {
      if(loginResponse.Permissions != null ) {
        for(var i=0;i<loginResponse.Permissions.length;i++)
        {
          PermissionRecordModel item = loginResponse.Permissions[i];
          if(item.SystemName=="MLSAgent")
            isAgent = true;
          else if(item.SystemName=="MLSAgentAssistant")
            isAgentAssistant = true;
          else if(item.SystemName=="HouseOwner")
            isHouseOwner = true;
        }
      }
      if(isAgentAssistant || isAgent)
        startScheduledTimer(); // Start the scheduler timer task
    }
  }
}