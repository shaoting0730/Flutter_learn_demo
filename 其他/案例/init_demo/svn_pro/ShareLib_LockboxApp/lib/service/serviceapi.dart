import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'baseapi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;
import '../models/iotdevice.dart';
import '../models/showing.dart';
import '../models/houseproduct.dart';
import '../models/loginmodel.dart';


int DateTimeToTicks(DateTime datetime) {
  return datetime.millisecondsSinceEpoch * 10000 + 621355968000000000;
}

DateTime TicksToDateTime(int ticks) {
  return DateTime.fromMillisecondsSinceEpoch(((ticks - 621355968000000000) / 10000).toInt());
}

String CUSTOMER_SERVER_URL = Server_Region=="us"?"https://customer.reliableshowing.com/api/v2b":"https://customer.imlockbox.com/api/v2b";
String IOT_SERVER_URL = Server_Region=="us"?"https://iot.reliableshowing.com/api/v2b":"https://iot.imlockbox.com/api/v2b";
String CONTENT_SERVER_URL = Server_Region=="us"?"https://content.reliableshowing.com/api/v2b":"https://content.imlockbox.com/api/v2b";

void displayErrorMessage(BuildContext context, String message) {
  if(context == null) {
    print("##### Context is null ####");
    return;
  }
  Flushbar flushbar;
  flushbar = Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.red,
    flushbarStyle: FlushbarStyle.GROUNDED,
    messageText: Text(message, style: TextStyle(fontSize: 16, color: Colors.white),),
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
  if(responseBody.containsKey('Data') && responseBody.containsKey('Success') && responseBody['Success'] == true) {
    return true;
  } else {
    displayErrorMessage(context, responseBody['ErrorDesc'] != null? responseBody['ErrorDesc'] : jsonEncode(responseBody));
    return false;
  }
}

class UserServerApi extends BaseApi {

  static final encrypt.Key aesKey = encrypt.Key.fromBase64("uYE2mSW3wJjPeXPTtV8TBL1wYnUdTcezeLulCrjlOuc=");

  Future<void> sendEmailVerificationCode(String email) async {
    var response = await postRaw(CUSTOMER_SERVER_URL+'/Customer/SendEmailVerificationCode', email);
    return response;
  }
  // Mobile Verfication API
  Future<void> sendMobileVerificationCode(String phoneNumber) async {
    var response = await postRaw(CUSTOMER_SERVER_URL+'/Customer/SendMobileVerificationCode', phoneNumber);
    return response;
  }
  Future<void> UpdateRegistrationId(String RegistrationId) async {
    StoreCustomerAttributeModel request = new StoreCustomerAttributeModel();
    request.AttributeName = "RegistrationId";
    request.AttributeValue = RegistrationId;
    request.Guid = "";
    request.AttributeType = "";
    request.ActionType = 1;
    var response = await postRaw(CUSTOMER_SERVER_URL+'/Customer/UpdateStoreCustomerAttribute', jsonEncode(request.toJson()));
    return response;
  }
  Future<void> UpdateStoreCustomerAttribute(String AttributeName, String AttributeValue) async {
    StoreCustomerAttributeModel request = new StoreCustomerAttributeModel();
    request.AttributeName = AttributeName;
    request.AttributeValue = AttributeValue;
    request.Guid = "";
    request.AttributeType = "";
    request.ActionType = 1;
    var response = await postRaw(CUSTOMER_SERVER_URL+'/Customer/UpdateStoreCustomerAttribute', jsonEncode(request.toJson()));
    return response;
  }
  // 用户登陆使用手机验证码登陆
  Future<LoginResponseModel> userLoginByVerificationCode(BuildContext context, String phoneNumber, String verifyCode, bool rememberMe) async {
    Map loginModel = {
      "PhoneNumber": phoneNumber,
      "VerifyCode": verifyCode,
    };
    try {
      var response = await post(CUSTOMER_SERVER_URL+'/Customer/MobileLogin', loginModel);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var loginResponseModel =LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(loginResponseModel, rememberMe);
        return loginResponseModel;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
      return null;
    }
  }

  // 用户的
  Future<LoginResponseModel> userLoginByPassword(BuildContext context, String phoneNumber, String password, bool rememberMe) async {
    Map loginModel = {
      "PhoneNumber": phoneNumber,
      "Password": password,
    };
    try {
      var response = await post(CUSTOMER_SERVER_URL+'/Customer/MobileLogin', loginModel);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var loginResponseModel =LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(loginResponseModel, rememberMe);
        return loginResponseModel;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }
  Future<LoginResponseModel> RefreshMyLogin(rememberMe) async {
    try {
      var response = await post(CUSTOMER_SERVER_URL+'/Customer/RefreshMyLogin', '');
      var responseBody = jsonDecode(response.body) ;
      if(responseBody.containsKey('Data')) {
        var loginResponseModel =LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(loginResponseModel, rememberMe);
        return loginResponseModel;
      }
    } catch(e) {
      print(e);
    }
    return null;
  }

  // MLS成员注册登陆API
  Future<LoginResponseModel> MLSMemberRegister(BuildContext context, String FirstName, String LastName, String MLSLoginID, String PhoneNumber, String Email, String Password, String MLSOfficeID, String VerificationCode) async {
    Map loginModel = {
      "FirstName": FirstName,
      "LastName": LastName,
      "MLSLoginID": MLSLoginID,
      "PhoneNumber": PhoneNumber,
      "Email": Email,
      'Password':Password,
      "MLSOfficeID": MLSOfficeID,
      "VerificationCode": VerificationCode,
    };

    try {
      var response = await post(CUSTOMER_SERVER_URL+'/Customer/MLSMemberRegister', loginModel);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var loginResponseModel = LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(loginResponseModel, false);
        return loginResponseModel;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }
  // MLS成员注册登陆API
  Future<LoginResponseModel> UpgradeAccountToMLSMember(BuildContext context, MLSMemberUpgrade request) async {
    try {
      var response = await postRaw(CUSTOMER_SERVER_URL+'/Customer/UpgradeAccountToMLSMember', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var loginResponseModel = LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(loginResponseModel, false);
        return loginResponseModel;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  // MLS成员注册登陆API
  Future<LoginResponseModel> userRegister(BuildContext context, String FirstName, String LastName, String PhoneNumber,String Email, String Password, String VerificationCode) async {
    Map loginModel = {
      "FirstName": FirstName,
      "LastName": LastName,
      "PhoneNumber": PhoneNumber,
      "Email": Email,
      'Password':Password,
      "PhoneVerificationCode": VerificationCode,
    };

    try {
      var response = await post(CUSTOMER_SERVER_URL+'/Customer/UserRegister', loginModel);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var loginResponseModel = LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(loginResponseModel, false);
        return loginResponseModel;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  Future<LoginResponseModel> userRegisterForPersonalOnly(BuildContext context, String username, String PhoneNumber, String Password, String VerificationCode) async {
    Map loginModel = {
      'Username': username,
      'Email':username,
      "PhoneNumber": PhoneNumber,
      'Password':Password,
      "VerifyCode": VerificationCode,
    };

    try {
      var response = await post(CUSTOMER_SERVER_URL+'/Customer/MobileRegister', loginModel);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var loginResponseModel = LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(loginResponseModel, false);
        return loginResponseModel;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  //查询MLS agent office list
  Future<List<MLSAgentOfficeModel>> SearchValidMLSAgentOfficeByOfficePhone(BuildContext context, String OfficePhone) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/SearchValidMLSAgentOfficeByOfficePhone',OfficePhone);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return List<MLSAgentOfficeModel>.from(responseBody['Data'].map((i)=>MLSAgentOfficeModel.fromJson(i)));
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }
  // 手机注册登陆API
  Future<LoginResponseModel> mobileRegister(BuildContext context, String phoneNumber, String verifyCode, String password) async {
      Map loginModel = {
      "PhoneNumber": phoneNumber,
      'Password':password,
      "VerifyCode": verifyCode,
    };

    try {
      var response = await post(CUSTOMER_SERVER_URL+'/Customer/MobileRegister', loginModel);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var loginResponseModel = LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(loginResponseModel, false);
        return loginResponseModel;
      }
    } catch(e) {
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }


  // 手机重置密码
  Future<LoginResponseModel> PasswordRecoveryByMobileVerification(BuildContext context, String phoneNumber, String verifyCode, String password) async {
    Map loginModel = {
      "PhoneNumber": phoneNumber,
      'Password':password,
      "VerifyCode": verifyCode,
    };

    try {
      var response = await post(CUSTOMER_SERVER_URL+'/Customer/PasswordRecoveryByMobileVerification', loginModel);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var loginResponseModel = LoginResponseModel.fromJson(responseBody['Data']);
        setLoginResponse(loginResponseModel, false);
        return loginResponseModel;
      }
    } catch(e) {
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }
  
  ///获取所有我授权的前台，房主列表
  Future<List<ImpersonationorInfoModel>> LoadMyImpersonators(BuildContext context) async {
    try {
      var response = await postRaw(CUSTOMER_SERVER_URL+'/Customer/LoadMyImpersonators','');
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return List<ImpersonationorInfoModel>.from(responseBody['Data'].map((i)=>ImpersonationorInfoModel.fromJson(i)));
      }
    } catch(e) {
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }

  ///授权前台，房主
  Future<bool> AssignImpersonation(BuildContext context, ImpersonationModel request) async {
    try {
      var response = await postRaw(CUSTOMER_SERVER_URL+'/Customer/AssignImpersonation', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
          return true;
      }
    } catch(e) {
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
      print(e);
    }

    return false;
  }
  
  ///删除前台，房主权限
  Future<bool>  RemoveImpersonation(BuildContext context, ImpersonationModel request) async {
    try {
      var response = await postRaw(CUSTOMER_SERVER_URL+'/Customer/RemoveImpersonation', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
          return true;
      }
    } catch(e) {
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
      print(e);
    }
    return false;
  }

///添加到收藏
  Future<bool> AddProductToWishList(BuildContext context, String ProductCode) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/AddProductToWishList', ProductCode);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
          return true;
      }

    }catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  ///从收藏夹删除
  Future<bool> RemoveProductFromWishList(BuildContext context, List<String> ProductCode) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/RemoveProductFromWishList', jsonEncode(ProductCode));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
          return true;
      }
    }catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  ///获取收藏列表
  Future<List<HouseProductModel>> LoadWishList(BuildContext context) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/LoadWishList','');
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return List<HouseProductModel>.from(responseBody['Data'].map((i)=>HouseProductModel.fromJson(i)));
      }
    }catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  ///更新锁实时信息
  Future<bool> UpdateIoTDeviceRealTimeInfo(BuildContext context, IOTDeviceRealTimeInfoModel request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/UpdateIoTDeviceRealTimeInfo', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  ///申请挂锁
  Future<bool> RequestIOTDevice(BuildContext context, IOTDeviceRequestModel request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/RequestIOTDevice', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  ///查询挂锁请求
  Future<PagedListIOTDeviceRequestModel> SearchIOTDeviceRequests(BuildContext context, IOTDeviceRequestSearch request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/SearchIOTDeviceRequests',jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var responseModel = PagedListIOTDeviceRequestModel.fromJson(responseBody['Data']);
        return responseModel;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  Future<IoTDeviceTokenModel> RetrieveIOTDevicePassword(BuildContext context, IOTDeviceRealTimeInfoModel request) async {
    try
    {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/RetrieveIOTDevicePassword',jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var responseModel = IoTDeviceTokenModel.fromJson(responseBody['Data']);
        return responseModel;
      }
    }
    catch(e)
    {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  ////更新挂锁请求
  Future<bool> UpdateIOTDeviceRequest(BuildContext context, IOTDeviceRequestModel request) async {
    try {
      
      var response = await postRaw(IOT_SERVER_URL+'/Iot/UpdateIOTDeviceRequest', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    }catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  ///查询房屋
  Future<PagedListIOTDeviceHouseInfo> SearchIoTDeviceHouse(BuildContext context, IOTDeviceHouseSearch request) async {
    try
    {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/SearchIoTDeviceHouse',jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var responseModel = PagedListIOTDeviceHouseInfo.fromJson(responseBody['Data']);
        return responseModel;
      }
    }
    catch(e)
    {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  ///预约看房
  Future<bool> CreateUpdateProfile(BuildContext context, ShowingProfileModel request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/CreateUpdateProfile', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  ///按看房客户查询看房预约
  Future<PagedListShowingProfileModel> SearchProfiles(BuildContext context, ShowingProfileSearch request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/SearchProfiles',jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var responseModel = PagedListShowingProfileModel.fromJson(responseBody['Data']);
        return responseModel;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  ///更新看房预约
  Future<bool>  UpdateShowingSchedule(BuildContext context, List<ShowingRequestModel> request) async {
    try {
      var requestValue = [];
      for(int i=0;i<request.length;i++)
        requestValue.add(request[i].toJson());
      var response = await postRaw(IOT_SERVER_URL+'/Iot/UpdateShowingSchedule', jsonEncode(requestValue));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
          return true;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }
  
  ///查询看房预约
  Future<PagedListShowingRequestModel> SearchShowingSchedules(BuildContext context, ShowingScheduleSearch request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/SearchShowingSchedules',jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var responseModel = PagedListShowingRequestModel.fromJson(responseBody['Data']);
        return responseModel;
      }
    }catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  Future<PagedListShowingRequestModel> SearchShowingRequestForApproval(BuildContext context, String keyGuid, int pageIndex, int pageSize) async {
    if(keyGuid==null)
      keyGuid = '';
    Map search = {
      "KeyGuid": keyGuid,
      'PageIndex':pageIndex,
      "PageSize": pageSize,
    };
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/SearchShowingRequestForApproval',jsonEncode(search));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var responseModel = PagedListShowingRequestModel.fromJson(responseBody['Data']);
        return responseModel;
      }
    } catch(e) {
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }

  Future<PagedListShowingRequestModel> SearchShowingRequestApprovalLogs(BuildContext context, String keyGuid, int pageIndex, int pageSize) async {
    if(keyGuid==null)
      keyGuid = '';
    Map search = {
      "KeyGuid": keyGuid,
      'PageIndex':pageIndex,
      "PageSize": pageSize,
    };    try  {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/SearchShowingRequestApprovalLogs',jsonEncode(search));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var responseModel = PagedListShowingRequestModel.fromJson(responseBody['Data']);
        return responseModel;
      }
    } catch(e) {
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
      print(e);
    }
    return null;
  }

  Future<BadgeDisplayModel> LoadMyBadgeDisplay() async {
    try
    {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/LoadMyBadgeDisplay','');
      var responseBody = jsonDecode(response.body) ;
      if(responseBody.containsKey('Data')) {
        var responseModel = BadgeDisplayModel.fromJson(responseBody['Data']);
        return responseModel;
      }
    }
    catch(e)
    {
      print(e);
    }
    return null;
  }

  ///更新自动确认预约设置
  Future<bool>  UpdateShowingAutoConfirmSetting(BuildContext context, List<ShowingAutoConfirmSettingModel> request) async {
    try {
      var requestValue = [];
      for(int i=0;i<request.length;i++)
        requestValue.add(request[i].toJson());
      var response = await postRaw(IOT_SERVER_URL+'/Iot/UpdateShowingAutoConfirmSetting', jsonEncode(requestValue));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
      print(e);
    }
    return false;
  }
  
  ///删除自动确认预约设置
  Future<bool>  DeleteShowingAutoConfirmSetting(BuildContext context, String request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/DeleteShowingAutoConfirmSetting', request);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  Future<String> uploadImageFiles(BuildContext context, String path) async {
    var request = new http.MultipartRequest(
      "POST", 
      Uri.parse(CONTENT_SERVER_URL + "/Content/UploadImageFiles"),
      );
    
    request.files.add(await http.MultipartFile.fromPath("file", path));
    
    request.headers .addAll({
        'Content-Type': 'application/json',
        "wbhost": getStoreName() ,
        "StoreGuid":getStoreGuid(),
        "token":getToken()
      });
    var response = await request.send();
    var responseStr = await response.stream.bytesToString();
    var responseBody = jsonDecode(responseStr);
    if(processResponse(context, responseBody)) {
      return responseBody["Data"].values.first;
    }
    return "";
  }

 ///查询 锁
  Future<PagedListIOTDeviceInfoModel> SearchIoTDevices(BuildContext context, IOTDeviceInfoSearch request) async{
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/SearchIoTDevices',jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        var responseModel = PagedListIOTDeviceInfoModel.fromJson(responseBody['Data']);
        return responseModel;
      }
    }catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  ///注册新锁
  Future<bool> CreateNewIoTDevice(BuildContext context, IOTDeviceInfoModel request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/CreateNewIoTDevice', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      print(e);
    }
    return false;
  }

  ///更新锁信息
  Future<bool> UpdateIoTDevice(BuildContext context, IOTDeviceInfoModel request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/UpdateIoTDevice', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    }catch(e) {
      print(e);
    }
    return false;
  }

  ///更新锁的时区信息
  Future<bool> UpdateIoTDeviceTimeZone(BuildContext context, IOTDeviceInfoModel request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/UpdateIoTDeviceTimeZone', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    }catch(e) {
      print(e);
    }
    return false;
  }

  ///删除锁设备
  Future<void> DeleteIoTDevice(BuildContext context, String guid) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/DeleteIoTDevice', guid);
      var responseBody = jsonDecode(response.body) ;
      processResponse(context, responseBody);
      return response;
    } catch(e) {
      print(e);
    }
  }

  Future<List<LockBoxDevicePermissionModel>> GetIoTDeviceAllPermissionRecords(BuildContext context, String DeviceGuid) async{
    try  {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/GetIoTDeviceAllPermissionRecords',DeviceGuid);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return List<LockBoxDevicePermissionModel>.from(responseBody['Data'].map((i)=>LockBoxDevicePermissionModel.fromJson(i)));
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  ///授权锁访问权限
  Future<bool> AssignIoTDevicePermission(BuildContext context, LockBoxDevicePermissionModel request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/AssignIoTDevicePermission', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  ///授权锁访问权限
  Future<String> RetrieveIOTDevicePasswordSMS(BuildContext context, LockBoxDeviceSharePasswordRequest request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/RetrieveIOTDevicePasswordSMS', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      return responseBody["Data"];
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return "";
  }

  ///删除锁访问权限
  Future<bool>  RemoveIoTDevicePermission(BuildContext context, LockBoxDevicePermissionModel request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/RemoveIoTDevicePermission', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  Future<List<LockBoxDeviceOpenRecordModel>> GetLockboxOpenRecordList(BuildContext context, String DeviceGuid) async{
    try  {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/GetLockboxOpenRecordList',DeviceGuid);
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return List<LockBoxDeviceOpenRecordModel>.from(responseBody['Data'].map((i)=>LockBoxDeviceOpenRecordModel.fromJson(i)));
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return null;
  }

  ///群发消息：Method:1=email;  2=sms
  Future<bool>  SendHouseNewsLetter(BuildContext context, HouseNewsLetterRequest request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/SendHouseNewsLetter', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

  ///代替客户预约时间
  Future<bool>  ImpersonateBookShowing(BuildContext context, ImpersonateBookingRequest request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/ImpersonateBookShowing', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    } catch(e) {
      print(e);
      displayErrorMessage(context, "Failed get response from server, please check your mobile network");
    }
    return false;
  }

////获取未完成的列表
  Future<List<ShowingRequestModel>> GetIncompleteSurveys() async{
    var response = await postRaw(IOT_SERVER_URL+'/Iot/GetIncompleteSurveys','');
    var responseBody = jsonDecode(response.body) ;
    if(processResponse(null, responseBody)) {
      return List<ShowingRequestModel>.from(responseBody['Data'].map((i)=>ShowingRequestModel.fromJson(i)));
    }
    return null;
  }

  ///获取选中的试卷的所有的问题
  Future<ShowingRequestSurveyModel>  GetSurveyQuestions(BuildContext context, String ShowingRequestGuid) async {
    var response = await postRaw(IOT_SERVER_URL+'/Iot/GetSurveyQuestions', ShowingRequestGuid);
    var responseBody = jsonDecode(response.body) ;
    if(processResponse(context, responseBody)) {
      var responseModel = ShowingRequestSurveyModel.fromJson(responseBody['Data']);
      return responseModel;
    }
  
    return null;
  }
  ///提交回答
  Future<bool> UpdateShowingRequestSurvey(BuildContext context, ShowingRequestSurveyAnswerModel request) async {
    try {
      var response = await postRaw(IOT_SERVER_URL+'/Iot/UpdateShowingRequestSurvey', jsonEncode(request.toJson()));
      var responseBody = jsonDecode(response.body) ;
      if(processResponse(context, responseBody)) {
        return true;
      }
    }catch(e) {
      print(e);
    }
    return false;
  }
}