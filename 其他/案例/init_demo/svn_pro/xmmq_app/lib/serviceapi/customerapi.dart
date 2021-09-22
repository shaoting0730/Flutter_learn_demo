import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as prefix0;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../serviceapi/baseapi.dart';
import '../models/api/customer.dart';
import '../pages/login.dart';
import '../pages/store_main.dart';
import '../models/api/goodsGroup.dart';
import '../models/api/goods.dart';
import '../models/api/vendorCategoryList.dart';
import '../models/api/order.dart';
import '../models/api/vendors.dart';
import '../models/api/address.dart';
import '../models/api/shareImage.dart';
import '../models/api/supplierProduct.dart';
import '../models/api/tag.dart';
import '../models/api/topicModel.dart';
import '../models/api/all_comments_model.dart';

String CUSTOMER_SERVER_URL = "https://customer.xiaomaimaiquan.com/api/v2b";
String PRODUCT_SERVER_URL = "https://product.xiaomaimaiquan.com/api/v2b";
String ORDER_SERVER_URL = "https://order.xiaomaimaiquan.com/api/v2b";

class CustomerApi extends BaseApi {
  // 用户登录使用手机验证码登录
  Future<LoginResponseModel> MobileLogin(BuildContext context,
      String phoneNumber, String verifyCode, bool rememberMe) async {
    Map loginModel = {
      "PhoneNumber": phoneNumber,
      "VerifyCode": verifyCode,
    };
    var response = await postRawWithProcess(context,
        CUSTOMER_SERVER_URL + '/Customer/MobileLogin', jsonEncode(loginModel));
    if (response != null) {
      var loginResponseModel = LoginResponseModel.fromJson(response);
      setDefaultLoginResponse(loginResponseModel, rememberMe);
      return loginResponseModel;
    }
    return null;
  }

  void verifyLoginState(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = prefs.getString(DEFAULT_STORE_TOKEN_KEY);

    if (json != null) {
      var jsonObj = jsonDecode(json);
      var loginResponse = LoginResponseModel.fromJson(jsonObj);
      if (loginResponse.LoginToken?.isNotEmpty ?? false) {
        await CustomerApi().setDefaultLoginResponse(loginResponse, false);

        json = prefs.getString(CURRENT_STORE_TOKEN_KEY);
        if (json != null) {
          var jsonObj = jsonDecode(json);
          var loginResponse = LoginResponseModel.fromJson(jsonObj);
          if (loginResponse.LoginToken?.isNotEmpty ?? false) {
            await CustomerApi()
                .setCurrentStoreLoginResponse(loginResponse, false);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => StoreMainPage()),
                (route) => route == null);
            return;
          }
//        await CustomerApi().RefreshMyLogin(context, false);
//        if (loginResponse.CellPhone?.isNotEmpty ?? false) {
////          Navigator.pushReplacementNamed(context, '/store_main');
////          Application.router.navigateTo(context, "./store_main",
////              transition: TransitionType.inFromBottom);
//          Navigator.of(context).pushAndRemoveUntil(
//              MaterialPageRoute(builder: (context) => StoreMainPage()),
//              (route) => route == null);
        }
      }
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => route == null);
//    Application.router.navigateTo(context, "./login",
//        transition: TransitionType.inFromBottom);
//    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<LoginResponseModel> RefreshMyLogin(
      BuildContext context, rememberMe) async {
    await GetMyAccessStores(context, {});
    var response = await postRawWithProcess(
        context, CUSTOMER_SERVER_URL + '/Customer/RefreshMyLogin', '');
//    print('刷新数据');
//    print(response);
    if (response != null) {
      var loginResponseModel = LoginResponseModel.fromJson(response);
      setDefaultLoginResponse(loginResponseModel, rememberMe);

      return loginResponseModel;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '刷新登录请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 手机注册登录API
  Future<LoginResponseModel> MobileRegister(BuildContext context,
      String phoneNumber, String verifyCode, String password) async {
    Map loginModel = {
      "PhoneNumber": phoneNumber,
      'Password': password,
      "VerifyCode": verifyCode,
    };
    var response = await postRawWithProcess(
        context, CUSTOMER_SERVER_URL + '/Customer/MobileRegister', loginModel);
    if (response != null) {
      var loginResponseModel = LoginResponseModel.fromJson(response);
      setDefaultLoginResponse(loginResponseModel, false);

      return loginResponseModel;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '手机注册登录请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
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
    var response = await postRawWithProcess(
        context,
        CUSTOMER_SERVER_URL + '/Customer/PasswordRecoveryByMobileVerification',
        loginModel);
    if (response != null) {
      var loginResponseModel = LoginResponseModel.fromJson(response);
      setDefaultLoginResponse(loginResponseModel, false);

      return loginResponseModel;
    }
    return null;
  }

  Future<LoginResponseModel> VerificationCodeLogin(
      BuildContext context, MobileLoginRequest request) async {
    var response = await postRawWithProcess(
        context,
        CUSTOMER_SERVER_URL + '/Customer/VerificationCodeLogin',
        jsonEncode(request.toJson()));
    if (response != null) {
      var loginResponseModel = LoginResponseModel.fromJson(response);
      setDefaultLoginResponse(loginResponseModel, false);
      return loginResponseModel;
    }
    return null;
  }

  Future<LoginResponseModel> WechatLogin(
      BuildContext context, WxloginRequest request) async {
    await cleanLoginInfo();
    var response = await postRawWithProcess(
        context,
        CUSTOMER_SERVER_URL + '/Customer/WechatLogin',
        jsonEncode(request.toJson()));
//    print(' WechatLogin response---$response');
    if (response != null) {
      var loginResponseModel = LoginResponseModel.fromJson(response);
      setDefaultLoginResponse(loginResponseModel, true);
      return loginResponseModel;
    }
    return null;
  }

  Future<LoginResponseModel> RefreshUserInfo(BuildContext context) async {
    var response = await postRawWithProcess(
        context, CUSTOMER_SERVER_URL + '/Customer/RefreshUserInfo', '');
    if (response != null) {
      var loginResponseModel = LoginResponseModel.fromJson(response);
      setDefaultLoginResponse(loginResponseModel, true);
      return loginResponseModel;
    }
    return null;
  }

  Future<void> SendEmailVerificationCode(
      BuildContext context, String email) async {
    await postRaw(context,
        CUSTOMER_SERVER_URL + '/Customer/SendEmailVerificationCode', email);
  }

  // Mobile Verfication API
  Future<void> SendMobileVerificationCode(
      BuildContext context, String phoneNumber) async {
    await postRaw(
        context,
        CUSTOMER_SERVER_URL + '/Customer/SendMobileVerificationCode',
        phoneNumber);
  }

  Future<void> UpdateRegistrationId(
      BuildContext context, String RegistrationId) async {
    StoreCustomerAttributeModel request = StoreCustomerAttributeModel();
    request.AttributeName = "RegistrationId";
    request.AttributeValue = RegistrationId;
    request.Guid = "";
    request.AttributeType = "";
    request.ActionType = 1;
    await post(
        context,
        CUSTOMER_SERVER_URL + '/Customer/UpdateStoreCustomerAttribute',
        jsonEncode(request.toJson()));
  }

  Future<void> UpdateStoreCustomerAttribute(
      BuildContext context, String AttributeName, String AttributeValue) async {
    StoreCustomerAttributeModel request = StoreCustomerAttributeModel();
    request.AttributeName = AttributeName;
    request.AttributeValue = AttributeValue;
    request.Guid = "";
    request.AttributeType = "";
    request.ActionType = 1;
    await post(
        context,
        CUSTOMER_SERVER_URL + '/Customer/UpdateStoreCustomerAttribute',
        jsonEncode(request.toJson()));
  }

  Future<void> RegisterAsOwner(
      BuildContext context, String OwnerRegister) async {
    //await postRaw(context, CUSTOMER_SERVER_URL + '/Customer/RegisterAsOwner', OwnerRegister);
  }

  // 获取商家名下商店信息,返回默认一家
  Future<List<StoreInfoModel>> GetMyAccessStores(
      BuildContext context, data) async {
    try {
      var response = await postRaw(
          context, CUSTOMER_SERVER_URL + '/Customer/GetMyAccessStores', data);
      var responseBody = jsonDecode(response.body);
//      print(responseBody);
      if (responseBody != null && responseBody['Data'] != null) {
        var list = List<StoreInfoModel>.from(
            responseBody['Data'].map((i) => StoreInfoModel.fromJson(i)));
        list.removeWhere((o) => !o.IsOwner);
        return list;
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '获取所有商家名下商店信息失败了～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
      return null;
    } catch (e) {
      displayErrorMessage(context,
          "Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }

  // 获取所有商家名下商店信息
  Future<List<StoreInfoModel>> GetAllMyAccessStores(
      BuildContext context, data) async {
    try {
      var response = await postRaw(
          context, CUSTOMER_SERVER_URL + '/Customer/GetMyAccessStores', data);
      var responseBody = jsonDecode(response.body);
      if (responseBody != null) {
        if (processResponse(context, responseBody)) {
          var list = List<StoreInfoModel>.from(
              responseBody['Data'].map((i) => StoreInfoModel.fromJson(i)));
          return list;
        }
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '获取所有商家名下商店信息失败～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
    } catch (e) {
      displayErrorMessage(context,
          "Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }

  // 获取选择的store的登录信息
  Future<LoginResponseModel> LoadUserBind(
      BuildContext context, String storeGuid) async {
    try {
      var response = await postRaw(
          context, CUSTOMER_SERVER_URL + '/Customer/LoadUserBind', storeGuid);
      var responseBody = jsonDecode(response.body);

      if (responseBody != null) {
        if (processResponse(context, responseBody)) {
          LoginResponseModel loginResponse =
              LoginResponseModel.fromJson(responseBody['Data']);

          setCurrentStoreLoginResponse(loginResponse, true);
          return loginResponse;
        }
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '获取选择的store的登录信息请求失败～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
    } catch (e) {
      displayErrorMessage(context,
          "Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }

  // 删除动态方法
  Future<bool> RemoveMoment(
    BuildContext context,
    String Guid,
  ) async {
    Map param = {
      "Guid": Guid,
    };
    try {
      var response = await postRaw(
          context, PRODUCT_SERVER_URL + '/Product/RemoveMoment', param);
      var responseBody = jsonDecode(response.body);
//      print('删除接口${responseBody}');
      if (responseBody != null) {
        return responseBody['Success'];
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '删除动态方法请求失败～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
      return null;
    } catch (e) {
      displayErrorMessage(context,
          "发布接口出错,Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }

  // 发布新商品
  Future AddNewMoment(BuildContext context, Map map) async {
    try {
      var response = await postRaw(
          context, PRODUCT_SERVER_URL + '/Product/AddNewMoment', map);
      var responseBody = jsonDecode(response.body);
      if (responseBody != null) {
        return responseBody;
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '发布新商品请求失败～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
      return null;
    } catch (e) {
      displayErrorMessage(context,
          "发布接口出错,Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }

  // 店主推荐发布新商品
  Future PromoteProducts(BuildContext context, Map map) async {
    try {
      var response = await postRaw(
          context, PRODUCT_SERVER_URL + '/Product/PromoteProducts', map);
      var responseBody = jsonDecode(response.body);
      if (responseBody != null) {
        return responseBody;
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '发布新商品请求失败～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
      return null;
    } catch (e) {
      displayErrorMessage(context,
          "发布接口出错,Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }

  // 编辑商品
  Future UpdateDQProduct(BuildContext context, Map params) async {
    try {
      var response = await postRaw(
          context, PRODUCT_SERVER_URL + '/Product/UpdateDQProduct', params);
      var responseBody = jsonDecode(response.body);
      if (responseBody != null) {
        return responseBody;
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '编辑商品请求失败～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
      return null;
    } catch (e) {
      displayErrorMessage(context,
          "编辑接口出错,Failed get response from server, please check your mobile network");
    }
    return null;
  }

  // 关闭评论
  Future DisableComment(BuildContext context, int params) async {
    try {
      var response = await postRaw(
          context, CUSTOMER_SERVER_URL + '/Customer/DisableComment', params);
      var responseBody = jsonDecode(response.body);
      if (responseBody != null) {
        return responseBody;
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: 'DisableComment请求失败～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
      return null;
    } catch (e) {
      displayErrorMessage(context,
          "DisableComment请求失败,Failed get response from server, please check your mobile network");
    }
    return null;
  }

  // 获取到商品的标签
  Future<TagModel> LoadAllProductTags(BuildContext context, Map params) async {
    try {
      var response = await postRaw(
          context, PRODUCT_SERVER_URL + '/Product/LoadAllProductTags', params);
      var responseBody = jsonDecode(response.body);
      if (responseBody != null && responseBody['Data'] != null) {
        return TagModel.fromJson(responseBody);
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '获取标签请求失败～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
      return null;
    } catch (e) {
      displayErrorMessage(context,
          "编辑接口出错,Failed get response from server, please check your mobile network");
    }
    return null;
  }

  // 加载话题
  Future<TopicModel> LoadAllMomentTopics(
      BuildContext context, Map params) async {
    try {
      var response = await postRaw(
          context, PRODUCT_SERVER_URL + '/Product/LoadAllMomentTopics', params);
      var responseBody = jsonDecode(response.body);
      if (responseBody != null && responseBody['Data'] != null) {
        return TopicModel.fromJson(responseBody);
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '话题请求失败～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
      return null;
    } catch (e) {
      displayErrorMessage(context,
          "编辑接口出错,Failed get response from server, please check your mobile network");
    }
    return null;
  }

  // 得到供应商
  Future GetVendorCategoryList(BuildContext context) async {
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/GetVendorCategoryList', {});
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null && responseBody['Data'] != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '得到供应商请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  //  点赞
  Future AddNewLike(BuildContext context, Map map) async {
    var response =
        await postRaw(context, PRODUCT_SERVER_URL + '/Product/AddNewLike', map);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null && responseBody['Data'] != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '点赞请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  //  取消点赞
  Future RemoveLike(BuildContext context, Map map) async {
    var response =
        await postRaw(context, PRODUCT_SERVER_URL + '/Product/RemoveLike', map);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null && responseBody['Data'] != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '点赞请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  //  置顶/取消置顶--动态
  Future SetMomentAtTop(BuildContext context, Map map) async {
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/SetMomentAtTop', map);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '置顶动态请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  //  置顶/取消置顶-评论
  Future SetCommentAtTop(BuildContext context, Map map) async {
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/SetCommentAtTop', map);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '置顶评论请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  //  发表评论/回复评论
  Future AddNewComment(BuildContext context, Map map) async {
//    print(map);
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/AddNewComment', map);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: 'AddNewComment失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 编辑/发布供应商
  Future PublishVendorProduct(BuildContext context, Map map) async {
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/PublishVendorProduct', map);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null && responseBody['Data'] != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '编辑供应商失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  //提交店面申请
  Future AddNewStoreApplication(BuildContext context, Map parmsMap) async {
    var response = await postRaw(context,
        CUSTOMER_SERVER_URL + '/Customer/AddNewStoreApplication', parmsMap);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '提交店面申请请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 获取当前用户的商品
  Future<GoodsModel> SearchDQProduct(
      BuildContext context, Map ParamsMap) async {
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/SearchDQProduct', ParamsMap);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null && responseBody['Data'] != null) {
      return GoodsModel.fromJson(responseBody['Data']);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '获取当前用户的商品请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 获取收货地址
  Future<AddressModel> SearchStoreCustomerAddress(
    BuildContext context,
    int PageIndex,
    int PageSize,
    String StoreCustomerGuid,
  ) async {
    Map param = {
      "PageIndex": PageIndex,
      'PageSize': PageSize,
      "StoreCustomerGuid": StoreCustomerGuid,
    };
    var response = await postRaw(context,
        CUSTOMER_SERVER_URL + '/Customer/SearchStoreCustomerAddress', param);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null) {
      return AddressModel.fromJson(responseBody);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '获取收货地址请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 删除地址
  Future DeleteStoreCustomerAddress(
    BuildContext context,
    String Guid,
    String StoreCustomerGuid,
  ) async {
    Map param = {
      'Guid': Guid,
      "StoreCustomerGuid": StoreCustomerGuid,
    };
    var response = await postRaw(context,
        CUSTOMER_SERVER_URL + '/Customer/DeleteStoreCustomerAddress', param);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '删除地址请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 设置默认地址
  Future SetDefaultAddress(
    BuildContext context,
    String Guid,
  ) async {
    var response = await postRaw(
        context, CUSTOMER_SERVER_URL + '/Customer/SetDefaultAddress', Guid);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '设置默认地址请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 获取商品分组信息
  Future<GoodsGroupModel> SearchDQProductGroup(
      BuildContext context, Map paramsMap) async {
    var response = await postRaw(context,
        PRODUCT_SERVER_URL + '/Product/SearchDQProductGroup', paramsMap);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null && responseBody['Data'] != null) {
//      print('0000000000000');
//      print(response.body);
//      print('0000000000000');
      return GoodsGroupModel.fromJson(responseBody['Data']);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '获取商品分组信息失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 得到分享出去的的产品拼装图片
  Future<ShareImageModel> GetDQMomentSharePicture(
      BuildContext context, String Guid) async {
    List list = [Guid, 128 * 1000];
    print(list);
    var response = await postRaw(context,
        CUSTOMER_SERVER_URL + '/Customer/GetDQMomentSharePicture', list);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null && responseBody['Data'] != null) {
      return ShareImageModel.fromJson(responseBody);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '请求分享图失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 得到我的店的分享图片
  Future GetMySharePicture(BuildContext context, int TemplateType) async {
    Map param = {
      'TemplateType': TemplateType,
    };
    var response = await postRaw(
        context, CUSTOMER_SERVER_URL + '/Customer/GetMySharePicture', param);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null && responseBody['Data'] != null) {
      return responseBody['Data'];
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '请求分享图失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 获取当前账户信息
  Future<StoreInfoModel> RetrieveStoreInfo(
      BuildContext context, bool IncludeBarcode) async {
    var response = await postRaw(
        context,
        CUSTOMER_SERVER_URL + '/Customer/RetrieveStoreInfo',
        IncludeBarcode.toString());
    var responseBody = jsonDecode(response.body);
    if (responseBody != null && responseBody['Data'] != null) {
      return StoreInfoModel.fromJson(responseBody['Data']);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '获取账户信息失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 获取订单信息
  Future<OrderModel> SearchOrder(
    BuildContext context,
    String OrderShareGuid,
    List OrderStatusBatchList,
    int PageIndex,
    int PageSize,
    String StoreGuid,
  ) async {
    Map param = {
      "OrderShareGuid": OrderShareGuid,
      'OrderStatusBatchList': OrderStatusBatchList,
      "PageIndex": PageIndex,
      "PageSize": PageSize,
      "StoreGuid": StoreGuid
    };
    var response =
        await postRaw(context, ORDER_SERVER_URL + '/Order/SearchOrder', param);
    var responseBody = jsonDecode(response.body);
//    print(param);
//    print(response.body);

    if (responseBody != null && responseBody['Data'] != null) {
      return OrderModel.fromJson(responseBody);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '请求订单失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 获取消息列表
  Future<AllCommentModel> StoreRecentComment(
      BuildContext context, Map map) async {
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/StoreRecentComment', map);
    var responseBody = jsonDecode(response.body);
//    print(111111111);
//    print(response.body);
    if (responseBody != null && responseBody['Data'] != null) {
      return AllCommentModel.fromJson(responseBody);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '消息获取失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 导出订单
  Future ExportDQOrders(
    BuildContext context,
    String ExportOrderDateType,
    String ExportOrderEndDate,
    String ExportOrderStartDate,
    String ExportOrderStatus,
  ) async {
    Map param = {
      "ExportOrderDateType": ExportOrderDateType,
      'ExportOrderEndDate': ExportOrderEndDate,
      "ExportOrderStartDate": ExportOrderStartDate,
      "ExportOrderStatus": ExportOrderStatus,
    };
    var response = await postRaw(
        context, ORDER_SERVER_URL + '/Order/ExportDQOrders', param);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null && responseBody['Data'] != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '请求导出订单失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 得到运费信息
  Future GetBasicShippingFee(BuildContext context) async {
    var response = await postRaw(
        context, ORDER_SERVER_URL + '/Order/GetBasicShippingFee', {});
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null && responseBody['Data'] != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '请求运费信息失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 得到二维码
  Future GetGZHQRCode(BuildContext context) async {
    var response = await postRaw(
        context, CUSTOMER_SERVER_URL + '/Customer/GetGZHQRCode', {});
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null && responseBody['Data'] != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '请求二维码信息失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 设置运费信息
  Future SetBasicShippingFee(BuildContext context, String money) async {
    var response = await postRaw(
        context, ORDER_SERVER_URL + '/Order/SetBasicShippingFee', money);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '设置运费信息失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 设置运费信息
  Future UpdateStoreApplicationWechatInfo(BuildContext context, Map map) async {
    var response = await postRaw(
        context,
        CUSTOMER_SERVER_URL + '/Customer/UpdateStoreApplicationWechatInfo',
        map);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '设置微信号失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 设置发货面单
  Future UpdateOrderImage(BuildContext context, Map map) async {
    var response = await postRaw(
        context, ORDER_SERVER_URL + '/Order/UpdateOrderImage', map);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '设置发货面单失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 合并商品
  Future MergeDQProducts(BuildContext context, List list) async {
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/MergeDQProducts', list);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '合并商品失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 商品下架
  Future RemoveDQProduct(BuildContext context, List list) async {
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/RemoveDQProduct', list);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '商品下架失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 删除订单
  Future DeleteOrder(BuildContext context, Map map) async {
    var response =
        await postRaw(context, ORDER_SERVER_URL + '/Order/DeleteOrder', map);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '删除订单失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 订单得到分享图片
  Future GetDQOrderSharePictureEx(BuildContext context, Map map) async {
    var response = await postRaw(context,
        CUSTOMER_SERVER_URL + '/Customer/GetDQOrderSharePictureEx', map);
    var responseBody = jsonDecode(response.body);
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '得到分享图片请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 绑定供应商
  Future BindInternalVendor(
    BuildContext context,
    String BindVendorCode,
    String MainGuid,
  ) async {
    Map param = {
      "BindVendorCode": BindVendorCode,
      'MainGuid': MainGuid,
    };
    print(param);
    var response = await postRaw(
        context, CUSTOMER_SERVER_URL + '/Customer/BindInternalVendor', param);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');

    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '绑定供应商请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 得到线上供应商
  Future LoadAllVendors(BuildContext context) async {
    var response = await postRaw(
        context, CUSTOMER_SERVER_URL + '/Customer/LoadAllVendors', {});
    var responseBody = jsonDecode(response.body);
//    print('--->>> ${response.body}');
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '线上供应商请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 得到线上供应商的产品
  Future SearchVendorProduct(BuildContext context, Map map) async {
    var response = await postRaw(
        context, PRODUCT_SERVER_URL + '/Product/SearchVendorProduct', map);
    var responseBody = jsonDecode(response.body);
//    print('--->>> ${response.body}');
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '线上供应商产品请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  // 标记接口
  Future BatchUpdateOrderStatus(BuildContext context, List list) async {
    print(list);
    var response = await postRaw(
        context, ORDER_SERVER_URL + '/Order/BatchUpdateOrderStatus', list);
    var responseBody = jsonDecode(response.body);
//    print('返回数据$responseBody');
    if (responseBody != null) {
      return responseBody;
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '标记产品请求失败～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    return null;
  }

  Future<bool> AddStoreCustomerAddress(
      BuildContext context, StoreCustomerAddressModel request) async {
    var response = await postRawWithProcess(
        context,
        CUSTOMER_SERVER_URL + '/Customer/AddStoreCustomerAddress',
        jsonEncode(request.toJson()));
    return (response != null);
  }

  Future<bool> UpdateStoreCustomerAddress(
      BuildContext context, StoreCustomerAddressModel request) async {
    var response = await postRawWithProcess(
        context,
        CUSTOMER_SERVER_URL + '/Customer/UpdateStoreCustomerAddress',
        jsonEncode(request.toJson()));
    return (response != null);
  }
}
