import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'baseapi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/loginmodel.dart';

int DateTimeToTicks(DateTime datetime) {
  return datetime.millisecondsSinceEpoch * 10000 + 621355968000000000;
}

DateTime TicksToDateTime(int ticks) {
  return DateTime.fromMillisecondsSinceEpoch(
      ((ticks - 621355968000000000) / 10000).toInt());
}

//String WEBAPI_SERVER_URL = "http://uatwebapi.aimoversea.com"; // 测试 香港

//String WEBAPI_SERVER_URL = "http://webapi.aimoversea.com"; // 正式 香港

// http://webapi.51taouk.com
// http://uatwebapi.51cpk.com

void displayErrorMessage(BuildContext context, String message) {
  print(message);

  if (context == null) {
    print("##### Context is null ####");
    return;
  }
  Flushbar flushbar;
  flushbar = Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Color.fromARGB(128, 30, 30, 30),
    flushbarStyle: FlushbarStyle.GROUNDED,
    animationDuration: const Duration(milliseconds: 300),
    messageText: Text(
      message,
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
    // Even the button can be styled to your heart's content
    mainButton: FlatButton(
      child: Icon(
        Icons.close,
        color: Colors.white,
      ),
      onPressed: () {
        flushbar.dismiss(true);
      },
    ),
    duration: Duration(seconds: 5),
    // Show it with a cascading operator
  )..show(context);
}

class UserServerApi extends BaseApi {
  /*
  * 返回服务器地址 0或者null:正式  1:测试
  * */
  Future<String> _getUrl() async {
    // 取值
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = await prefs.get('serVerValue');
    if (str == null || str == '0') {
      str = 'http://webapi.51taouk.com';
    } else {
      str = 'http://uatwebapi.51cpk.com';
    }
    return str;
  }

  // Mobile Verification API
  Future<void> sendMobileVerificationCode(String phoneNumber) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    var response = await post(str + '/api/customer/PhoneCodeRequestLogin',
        {'PhoneNumber': phoneNumber});
    return response;
  }

  Future<void> UpdateRegistrationId(String RegistrationId) async {
    StoreCustomerAttributeModel request = StoreCustomerAttributeModel();
    request.AttributeName = "RegistrationId";
    request.AttributeValue = RegistrationId;
    request.Guid = "";
    request.AttributeType = "";
    request.ActionType = 1;

    var str = await _getUrl();
    print('当前服务器是:$str');

    var response = await post(str + '/Customer/UpdateStoreCustomerAttribute',
        jsonEncode(request.toJson()));
    return response;
  }

  Future<void> UpdateStoreCustomerAttribute(
      String AttributeName, String AttributeValue) async {
    StoreCustomerAttributeModel request = StoreCustomerAttributeModel();
    request.AttributeName = AttributeName;
    request.AttributeValue = AttributeValue;
    request.Guid = "";
    request.AttributeType = "";
    request.ActionType = 1;

    var str = await _getUrl();
    print('当前服务器是:$str');

    var response = await post(str + '/Customer/UpdateStoreCustomerAttribute',
        jsonEncode(request.toJson()));
    return response;
  }

  // 用户登陆使用手机验证码登陆
  Future<LoginResponseModel> userLoginByVerificationCode(
      BuildContext context,
      String phoneNumber,
      String verifyCode,
      String referCode,
      bool isRegister,
      bool rememberMe) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await postLogin(str + '/api/customer/PhoneLogin', {
        "IsAutoRegister": isRegister,
        "PhoneNumber": phoneNumber,
        "PhoneValidationCode": verifyCode,
        "ReferredByCode": referCode,
      });
      var responseBody = jsonDecode(response.body);
      var loginResponseModel = processLoginResponse(context, responseBody);
      if (loginResponseModel != null) {
        setLoginResponse(responseBody, rememberMe);
        return loginResponseModel;
      } else if (responseBody != null &&
          responseBody.containsKey('ErrorCode') &&
          responseBody['ErrorCode'].toString().isNotEmpty) {
        var model = LoginResponseModel();
        model.ErrorMessage = responseBody['ErrorCode'];
        return model;
      }
    } catch (e) {
      print(e);
      displayErrorMessage(context, "从网络读取数据失败！");
    }

    return null;
  }

  // 用户的
  Future<LoginResponseModel> userLoginByPassword(BuildContext context,
      String username, String password, bool rememberMe) async {
    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await postLogin(str + '/api/customer/login', {
        "Username": username,
        "Email": username,
        "Password": password,
      });
      var responseBody = jsonDecode(response.body);
      var loginResponseModel = processLoginResponse(context, responseBody);
      if (loginResponseModel != null) {
        setLoginResponse(responseBody, rememberMe);
        return loginResponseModel;
      }
    } catch (e) {
      print(e);
      displayErrorMessage(context, "从网络读取数据失败！");
    }
    return null;
  }

  // MLS成员注册登陆API
  Future<LoginResponseModel> userRegister(
      BuildContext context,
      String FirstName,
      String LastName,
      String PhoneNumber,
      String Email,
      String Password,
      String VerificationCode) async {
    Map loginModel = {
      "FirstName": FirstName,
      "LastName": LastName,
      "PhoneNumber": PhoneNumber,
      "Email": Email,
      'Password': Password,
      "PhoneVerificationCode": VerificationCode,
    };

    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await post(str + '/Customer/UserRegister', loginModel);
      var responseBody = jsonDecode(response.body);
      var loginResponseModel = processLoginResponse(context, responseBody);
      if (loginResponseModel != null) {
        setLoginResponse(responseBody, true);
        return loginResponseModel;
      }
    } catch (e) {
      print(e);
      displayErrorMessage(context, "从网络读取数据失败！");
    }
    return null;
  }

  Future<LoginResponseModel> userRegisterForPersonalOnly(
      BuildContext context,
      String username,
      String PhoneNumber,
      String Password,
      String VerificationCode) async {
    Map loginModel = {
      'Username': username,
      'Email': username,
      "PhoneNumber": PhoneNumber,
      'Password': Password,
      "VerifyCode": VerificationCode,
    };

    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await post(str + '/Customer/MobileRegister', loginModel);
      var responseBody = jsonDecode(response.body);
      var loginResponseModel = processLoginResponse(context, responseBody);
      if (loginResponseModel != null) {
        setLoginResponse(responseBody, true);
        return loginResponseModel;
      }
    } catch (e) {
      print(e);
      displayErrorMessage(context, "从网络读取数据失败！");
    }
    return null;
  }

  // 手机注册登陆API
  Future<LoginResponseModel> mobileRegister(BuildContext context,
      String phoneNumber, String verifyCode, String password) async {
    Map loginModel = {
      "PhoneNumber": phoneNumber,
      'Password': password,
      "VerifyCode": verifyCode,
    };

    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await post(str + '/Customer/MobileRegister', loginModel);
      var responseBody = jsonDecode(response.body);
      var loginResponseModel = processLoginResponse(context, responseBody);
      if (loginResponseModel != null) {
        setLoginResponse(responseBody, true);
        return loginResponseModel;
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  // 手机重置密码
  Future<LoginResponseModel> PasswordRecoveryByMobileVerification(
      BuildContext context,
      String phoneNumber,
      String verifyCode,
      String password) async {
    Map loginModel = {
      "PhoneNumber": phoneNumber,
      'Password': password,
      "VerifyCode": verifyCode,
    };

    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await post(
          str + '/Customer/PasswordRecoveryByMobileVerification', loginModel);
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        var loginResponseModel =
            LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(responseBody, false);
        return loginResponseModel;
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  Future<AimRevenueModel> getRevenueSummary(BuildContext context) async {
    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await post(str + '/api/aim/MyRevenue/Summary', {});
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return AimRevenueModel.fromJson(responseBody);
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return AimRevenueModel();
  }

  Future<NotifySummaryModel> getNotifyCount(BuildContext context) async {
    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await get(str + '/api/notify/info');
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return NotifySummaryModel.fromJson(responseBody);
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return NotifySummaryModel();
  }

  Future<List<NotifyListItemModel>> getNotifyList(BuildContext context) async {
    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await get(str + '/api/notify/list');
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return responseBody['Data']
            .map<NotifyListItemModel>(
                (item) => NotifyListItemModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return List<NotifyListItemModel>();
  }

  Future<List<AffiliateSummaryModel>> getAffiliates(BuildContext context,
      String level, String sortDirection, String orderBy) async {
    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await post(str + '/api/customer/AimAffiliates', {
        "Filters": [
          {"Field": "Level", "Value": level}
        ],
        "OrderBy": orderBy,
        "OrderDirection": sortDirection
      });
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return responseBody['ListObjects']
            .map<AffiliateSummaryModel>(
                (item) => AffiliateSummaryModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return List<AffiliateSummaryModel>();
  }

  Future<AffiliateSummaryModel> myAffiliateInfo(
      BuildContext context, DateTime month) async {
    try {
      var str = await _getUrl();
      print('当前服务器是:$str');
      var response = await post(str + '/api/customer/AimMyAffiliateInfo', {
        "Filters": [
          {"Field": "month", "Value": month?.toIso8601String()}
        ]
      });
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return AffiliateSummaryModel.fromJson(responseBody);
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  Future<String> uploadImageFiles(BuildContext context, String path) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(str + "/Content/UploadImageFiles"),
    );

    request.files.add(await http.MultipartFile.fromPath("file", path));

    request.headers.addAll({
      'Content-Type': 'application/json',
      "wbhost": getStoreName(),
      "token": getToken()
    });
    var response = await request.send();
    var responseStr = await response.stream.bytesToString();
    var responseBody = jsonDecode(responseStr);
    if (processResponse(context, responseBody)) {
      return responseBody["Data"].values.first;
    }
    return "";
  }

  Future<OrderResponse> searchOrders(
      BuildContext context, String orderStatus, int statusId, int page) async {
    var str = await _getUrl();
    print('当前服务器是:$str');

    try {
      var response = await post(str + '/api/order/search', {
        "OrderTypeId": 99,
        "OrderStatusId": statusId,
        "OrderStatus": orderStatus,
        "PageIndex": page,
        "PageSize": 10,
        "AllowPaging": true,
        "IncludeAffiliateOrders": true
      });
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return OrderResponse.fromJson(responseBody);
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  Future<CustomerPrepayAccountHistoryList> getPrepayAccount(
      BuildContext context, String filter, int pageIndex) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await post(str + '/api/aim/prepayaccount', {
        "PageIndex": pageIndex,
        "PageSize": 100,
        "Filters": [
          {"Field": "ListType", "Value": filter}
        ]
      });
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return CustomerPrepayAccountHistoryList.fromJson(responseBody);
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  Future<CustomerPrepayAccountHistoryList> getDrawalAccount(
      BuildContext context, int id, int pageIndex) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await post(str + '/api/aim/withdrawalaccount', {
        "PageIndex": pageIndex,
        "PageSize": 100,
        "AllowPaging": false,
        "RequestTypeId": id,
      });
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
//        print(123456789);
//        print(responseBody);
        return CustomerPrepayAccountHistoryList.fromJson(responseBody);
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  Future<bool> addServiceRequest(BuildContext context, int serviceTypeId,
      Map<String, dynamic> data) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await post(str + '/api/Order/ServiceRequest/Add', {
        "OrderServiceId": serviceTypeId,
        "RequestCustomerNotes": jsonEncode(data)
      });
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return true;
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return false;
  }

  Future<TopicModel> getTopic(BuildContext context, String name) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await get(str + '/api/content/GetTopicByName/$name');
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return TopicModel.fromJson(responseBody);
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  Future<CustomerModel> getCustomerInfo(BuildContext context) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await post(str + '/api/customer', {});
      var responseBody = jsonDecode(response.body);
//      print('返回数据-----------${response.body}');
      if (processResponse(context, responseBody)) {
        return CustomerModel.fromJson(responseBody);
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  Future<bool> setAffiliateCode(BuildContext context, String code) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await post(str + '/api/customer/Affiliate/InsertByCode',
          {"ReferredByStoreCustomer": code});
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return true;
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return false;
  }

  Future<CustomerRewardPointsResponse> getRewardPointsHistory(
      BuildContext context, int pageIndex) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await post(str + '/api/customer/rewardpointshistory', {
        "PageIndex": pageIndex,
        "PageSize": 100,
        "AllowPaging": true,
      });
      print('返回数据');
      print(response.body);
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return CustomerRewardPointsResponse.fromJson(responseBody);
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  //  获取头像
  Future queryStoreCustomerHead(BuildContext context) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await get(str + '/api/customer/QueryStoreCustomerHead');
      var responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  //  设置头像
  Future updateStoreCustomerHead(BuildContext context, Map params) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response =
          await post(str + '/api/customer/UpdateStoreCustomerHead', params);
      var responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return null;
  }

  Future<bool> updateCustomerInfo(BuildContext context, {String name}) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await post(str + '/api/customerupdate', {
        "FirstName": name,
      });
      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return true;
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return false;
  }

  Future uploadFileAsync(BuildContext context, {String name}) async {
    var str = await _getUrl();
    print('当前服务器是:$str');
    try {
      var response = await post(str + '/api/FileAdmin/UploadFileAsync', {
        "FirstName": name,
      });

      var responseBody = jsonDecode(response.body);
      if (processResponse(context, responseBody)) {
        return true;
      }
    } catch (e) {
      displayErrorMessage(context, "从网络读取数据失败！");
      print(e);
    }
    return false;
  }
}
