import 'package:json_annotation/json_annotation.dart';

/////flutter packages pub run build_runner build  --delete-conflicting-outputs
part 'customer.g.dart';

@JsonSerializable()
class MobileLoginRequest {
  String PhoneNumber;
  String Email;
  String VerifyCode;
  String Password;
  String WechatAccessTokenJson;

  MobileLoginRequest();

  factory MobileLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$MobileLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MobileLoginRequestToJson(this);
}

@JsonSerializable()
class SharePictureResponseModel {
  String ImageUrl;
  String ShareGuid;

  SharePictureResponseModel();

  factory SharePictureResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SharePictureResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SharePictureResponseModelToJson(this);
}

@JsonSerializable()
class SharePictureRequestModel {
  int TemplateType;
  String Message;

  SharePictureRequestModel();

  factory SharePictureRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SharePictureRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SharePictureRequestModelToJson(this);
}

@JsonSerializable()
class WxloginRequest {
  String WechatCode;
  String UserInfo;
  String Iv;
  String RefCode;
  bool AutoRegister;

  WxloginRequest();

  factory WxloginRequest.fromJson(Map<String, dynamic> json) =>
      _$WxloginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WxloginRequestToJson(this);
}

@JsonSerializable()
class StoreInfoModel {
  String StoreName;
  String StoreGuid;
  String StoreHost;
  String OwnerNickName;
  String StoreLogoUrl;
  String ShareQRCode;
  String OwnerGuid;
  bool IsPublished;
  bool IsOwner;

  StoreInfoModel();

  factory StoreInfoModel.fromJson(Map<String, dynamic> json) =>
      _$StoreInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreInfoModelToJson(this);
}

@JsonSerializable()
class StoreCustomerAddressModel {
  String Guid;
  String StoreCustomerGuid;
  int AddressType;
  String FullName;
  String AddressLine;
  String PostCode;
  String Town;
  String City;
  String Province;
  String PhoneNumber;
  int IDCardType;
  String IDCardNumber;
  String Country;
  int DisplayOrder;

  StoreCustomerAddressModel();

  factory StoreCustomerAddressModel.fromJson(Map<String, dynamic> json) =>
      _$StoreCustomerAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCustomerAddressModelToJson(this);
}

@JsonSerializable()
class AddressSearchModel {
  String Guid;
  String StoreCustomerGuid;
  int AddressType;
  String FullName;
  String AddressLine;
  String PostCode;
  String City;
  String Province;
  String PhoneNumber;
  int IDCardType;
  String IDCardNumber;
  String Country;
  int PageIndex;
  int PageSize;

  AddressSearchModel();

  factory AddressSearchModel.fromJson(Map<String, dynamic> json) =>
      _$AddressSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressSearchModelToJson(this);
}

@JsonSerializable()
class PagedListStoreCustomerAddressModel {
  int PageIndex;
  int PageSize;
  int TotalCount;
  List<StoreCustomerAddressModel> ListObjects;

  PagedListStoreCustomerAddressModel();

  factory PagedListStoreCustomerAddressModel.fromJson(
          Map<String, dynamic> json) =>
      _$PagedListStoreCustomerAddressModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PagedListStoreCustomerAddressModelToJson(this);
}

@JsonSerializable()
class ImpersonationorInfoModel {
  String Guid;
  String StoreCustomerGuid;
  String FirstName;
  String LastName;
  String PhoneNumber;
  String Email;
  String CustomerRoleGuid;
  String CustomerRoleSystemName;
  String ProductGuid;

  ImpersonationorInfoModel();

  factory ImpersonationorInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ImpersonationorInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImpersonationorInfoModelToJson(this);
}

@JsonSerializable()
class ImpersonationModel {
  String Guid;
  String ImpersonatorStoreCustomerGuid;
  String ImpersonateeStoreCustomerGuid;
  String CustomerRoleGuid;
  String CustomerRoleSystemName;
  String ProductGuid;

  ImpersonationModel();

  factory ImpersonationModel.fromJson(Map<String, dynamic> json) =>
      _$ImpersonationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImpersonationModelToJson(this);
}

@JsonSerializable()
class MyAccessStoresInfo {
  String StoreName;
  String StoreGuid;
  String StoreHost;
  String OwnerNickName;
  String StoreLogoUrl;
  String ShareQRCode;
  bool OwnerGuid;
  bool IsPublished;
  bool IsOwner;

  MyAccessStoresInfo();

  factory MyAccessStoresInfo.fromJson(Map<String, dynamic> json) =>
      _$MyAccessStoresInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MyAccessStoresInfoToJson(this);
}

@JsonSerializable()
class UserRegisterInfo {
  String ReferredByCode;
  String Username;
  String Email;
  int LanguageId;
  String Password;
  String PhoneNumber;
  bool Newsletter;
  String FirstName;
  String LastName;
  bool LinkWithWechat;
  String WechatAccessTokenJson;
  String PhoneVerificationCode;

  UserRegisterInfo();

  factory UserRegisterInfo.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterInfoToJson(this);
}

@JsonSerializable()
class MLSMemberUpgrade {
  String FirstName;
  String LastName;
  String MLSLoginID;
  String MLSOfficeID;

  MLSMemberUpgrade();

  factory MLSMemberUpgrade.fromJson(Map<String, dynamic> json) =>
      _$MLSMemberUpgradeFromJson(json);

  Map<String, dynamic> toJson() => _$MLSMemberUpgradeToJson(this);
}

@JsonSerializable()
class MLSMemberRegisterInfo {
  String FirstName;
  String LastName;
  String MLSLoginID;
  String PhoneNumber;
  String Email;
  String Password;
  String MLSOfficeID;
  String VerificationCode;

  MLSMemberRegisterInfo();

  factory MLSMemberRegisterInfo.fromJson(Map<String, dynamic> json) =>
      _$MLSMemberRegisterInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MLSMemberRegisterInfoToJson(this);
}

@JsonSerializable()
class StoreCustomerAttributeModel {
  String Guid;
  String AttributeName;
  String AttributeValue;
  String AttributeType;
  int ActionType;

  StoreCustomerAttributeModel();

  factory StoreCustomerAttributeModel.fromJson(Map<String, dynamic> json) =>
      _$StoreCustomerAttributeModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCustomerAttributeModelToJson(this);
}

@JsonSerializable()
class PermissionRecordModel {
  String Guid;
  String Name;
  String SystemName;
  String Category;

  PermissionRecordModel();

  factory PermissionRecordModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionRecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionRecordModelToJson(this);
}

@JsonSerializable()
class LoginResponseModel {
  String StoreGuid;
  String StoreName;
  String StoreCustomerGuid;
  String Username;
  String Email;
  String CellPhone;
  String FirstName;
  String LastName;
  int LastLoginDate;
  int LastActivityDate;
  int AcceptAgreement;
  int DisableComment;
  String ErrorMessage;
  bool IsActive;
  String LoginToken;
  bool IsImpersonation;
  String ImpersonatorUserName;
  String ImpersonatorURL;
  String ImpersonatorToken;
  String CustomerUniqueCode;
  String CurrentLanguageGuid;
  bool IsSignedToday;
  int ConsistantSignOnDays;
  double RewardPointsBalance;
  double AccountBalance;
  String WechatNickName;
  String WechatThumber;
  List<PermissionRecordModel> Permissions;
  Map StoreApplication;

  LoginResponseModel();

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
