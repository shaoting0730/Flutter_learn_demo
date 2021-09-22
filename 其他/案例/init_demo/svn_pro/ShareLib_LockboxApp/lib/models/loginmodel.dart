import 'package:json_annotation/json_annotation.dart';
/////flutter packages pub run build_runner build  --delete-conflicting-outputs

part 'loginmodel.g.dart';

@JsonSerializable()
class ImpersonationorInfoModel
{
  String Guid;
  String StoreCustomerGuid;
  String FirstName;
  String LastName;
  String PhoneNumber;
  String Email;
  String CustomerRoleGuid;
  String CustomerRoleSystemName;
  String ProductGuid;

  ImpersonationorInfoModel({
    this.Guid,
    this.StoreCustomerGuid,
    this.FirstName,
    this.LastName,
    this.PhoneNumber,
    this.Email,
    this.CustomerRoleGuid,
    this.CustomerRoleSystemName='',
    this.ProductGuid = '',
  });

  factory ImpersonationorInfoModel.fromJson(Map<String, dynamic> json) => _$ImpersonationorInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImpersonationorInfoModelToJson(this);

}

@JsonSerializable()
class ImpersonationModel
{
  String Guid;
  String ImpersonatorStoreCustomerGuid;
  String ImpersonateeStoreCustomerGuid;
  String CustomerRoleGuid;
  String CustomerRoleSystemName;
  String ProductGuid;

  ImpersonationModel({
    this.Guid,
    this.ImpersonatorStoreCustomerGuid,
    this.ImpersonateeStoreCustomerGuid,
    this.CustomerRoleGuid,
    this.CustomerRoleSystemName='',
    this.ProductGuid = '',
  });

  factory ImpersonationModel.fromJson(Map<String, dynamic> json) => _$ImpersonationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImpersonationModelToJson(this);

}
@JsonSerializable()
class UserRegisterInfo
{
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

  UserRegisterInfo({
    this.ReferredByCode = '',
    this.Username,
    this.Email,
    this.LanguageId = 0,
    this.Password,
    this.PhoneNumber,
    this.Newsletter = false,
    this.FirstName,
    this.LastName,
    this.LinkWithWechat = false,
    this.WechatAccessTokenJson = '',
    this.PhoneVerificationCode = '',
  });

  factory UserRegisterInfo.fromJson(Map<String, dynamic> json) => _$UserRegisterInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserRegisterInfoToJson(this);
}
@JsonSerializable()
class MLSMemberUpgrade
{
  String FirstName;
  String LastName;
  String MLSLoginID;
  String MLSOfficeID;

  MLSMemberUpgrade({
    this.FirstName,
    this.LastName,
    this.MLSLoginID,
    this.MLSOfficeID,
  });

  factory MLSMemberUpgrade.fromJson(Map<String, dynamic> json) => _$MLSMemberUpgradeFromJson(json);
  Map<String, dynamic> toJson() => _$MLSMemberUpgradeToJson(this);
}
@JsonSerializable()
class MLSMemberRegisterInfo
{
  String FirstName;
  String LastName;
  String MLSLoginID;
  String PhoneNumber;
  String Email;
  String Password;
  String MLSOfficeID;
  String VerificationCode;

  MLSMemberRegisterInfo({
    this.FirstName,
    this.LastName,
    this.MLSLoginID,
    this.PhoneNumber,
    this.Email,
    this.Password,
    this.MLSOfficeID,
    this.VerificationCode,
  });

  factory MLSMemberRegisterInfo.fromJson(Map<String, dynamic> json) => _$MLSMemberRegisterInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MLSMemberRegisterInfoToJson(this);
}
@JsonSerializable()
class StoreCustomerAttributeModel
{
  String Guid;
  String AttributeName;
  String AttributeValue;
  String AttributeType;
  int ActionType;
  StoreCustomerAttributeModel({
    this.Guid,
    this.AttributeName,
    this.AttributeValue,
    this.AttributeType,
    this.ActionType,
  });
  factory StoreCustomerAttributeModel.fromJson(Map<String, dynamic> json) => _$StoreCustomerAttributeModelFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCustomerAttributeModelToJson(this);
}
@JsonSerializable()
class PermissionRecordModel
{
  String Guid;
  String Name;
  String SystemName;
  String Category;
  PermissionRecordModel({
    this.Guid,
    this.Name,
    this.SystemName,
    this.Category,
  });
  factory PermissionRecordModel.fromJson(Map<String, dynamic> json) => _$PermissionRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionRecordModelToJson(this);
}

@JsonSerializable()
class LoginResponseModel
{
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

  LoginResponseModel({
    this.StoreGuid,
    this.StoreName,
    this.StoreCustomerGuid,
    this.Username,
    this.Email,
    this.CellPhone,
    this.FirstName,
    this.LastName,
    this.LastLoginDate,
    this.LastActivityDate,
    this.ErrorMessage,
    this.IsActive,
    this.LoginToken,
    this.IsImpersonation,
    this.ImpersonatorUserName,
    this.ImpersonatorURL,
    this.ImpersonatorToken,
    this.CustomerUniqueCode,
    this.IsSignedToday,
    this.ConsistantSignOnDays,
    this.RewardPointsBalance,
    this.AccountBalance,
    this.WechatNickName,
    this.WechatThumber,
    this.Permissions,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

}
