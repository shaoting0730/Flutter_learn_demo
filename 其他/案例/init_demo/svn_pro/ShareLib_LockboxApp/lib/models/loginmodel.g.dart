// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImpersonationorInfoModel _$ImpersonationorInfoModelFromJson(
    Map<String, dynamic> json) {
  return ImpersonationorInfoModel(
      Guid: json['Guid'] as String,
      StoreCustomerGuid: json['StoreCustomerGuid'] as String,
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      PhoneNumber: json['PhoneNumber'] as String,
      Email: json['Email'] as String,
      CustomerRoleGuid: json['CustomerRoleGuid'] as String,
      CustomerRoleSystemName: json['CustomerRoleSystemName'] as String,
      ProductGuid: json['ProductGuid'] as String);
}

Map<String, dynamic> _$ImpersonationorInfoModelToJson(
        ImpersonationorInfoModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'PhoneNumber': instance.PhoneNumber,
      'Email': instance.Email,
      'CustomerRoleGuid': instance.CustomerRoleGuid,
      'CustomerRoleSystemName': instance.CustomerRoleSystemName,
      'ProductGuid': instance.ProductGuid
    };

ImpersonationModel _$ImpersonationModelFromJson(Map<String, dynamic> json) {
  return ImpersonationModel(
      Guid: json['Guid'] as String,
      ImpersonatorStoreCustomerGuid:
          json['ImpersonatorStoreCustomerGuid'] as String,
      ImpersonateeStoreCustomerGuid:
          json['ImpersonateeStoreCustomerGuid'] as String,
      CustomerRoleGuid: json['CustomerRoleGuid'] as String,
      CustomerRoleSystemName: json['CustomerRoleSystemName'] as String,
      ProductGuid: json['ProductGuid'] as String);
}

Map<String, dynamic> _$ImpersonationModelToJson(ImpersonationModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'ImpersonatorStoreCustomerGuid': instance.ImpersonatorStoreCustomerGuid,
      'ImpersonateeStoreCustomerGuid': instance.ImpersonateeStoreCustomerGuid,
      'CustomerRoleGuid': instance.CustomerRoleGuid,
      'CustomerRoleSystemName': instance.CustomerRoleSystemName,
      'ProductGuid': instance.ProductGuid
    };

UserRegisterInfo _$UserRegisterInfoFromJson(Map<String, dynamic> json) {
  return UserRegisterInfo(
      ReferredByCode: json['ReferredByCode'] as String,
      Username: json['Username'] as String,
      Email: json['Email'] as String,
      LanguageId: json['LanguageId'] as int,
      Password: json['Password'] as String,
      PhoneNumber: json['PhoneNumber'] as String,
      Newsletter: json['Newsletter'] as bool,
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      LinkWithWechat: json['LinkWithWechat'] as bool,
      WechatAccessTokenJson: json['WechatAccessTokenJson'] as String,
      PhoneVerificationCode: json['PhoneVerificationCode'] as String);
}

Map<String, dynamic> _$UserRegisterInfoToJson(UserRegisterInfo instance) =>
    <String, dynamic>{
      'ReferredByCode': instance.ReferredByCode,
      'Username': instance.Username,
      'Email': instance.Email,
      'LanguageId': instance.LanguageId,
      'Password': instance.Password,
      'PhoneNumber': instance.PhoneNumber,
      'Newsletter': instance.Newsletter,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'LinkWithWechat': instance.LinkWithWechat,
      'WechatAccessTokenJson': instance.WechatAccessTokenJson,
      'PhoneVerificationCode': instance.PhoneVerificationCode
    };

MLSMemberUpgrade _$MLSMemberUpgradeFromJson(Map<String, dynamic> json) {
  return MLSMemberUpgrade(
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      MLSLoginID: json['MLSLoginID'] as String,
      MLSOfficeID: json['MLSOfficeID'] as String);
}

Map<String, dynamic> _$MLSMemberUpgradeToJson(MLSMemberUpgrade instance) =>
    <String, dynamic>{
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'MLSLoginID': instance.MLSLoginID,
      'MLSOfficeID': instance.MLSOfficeID
    };

MLSMemberRegisterInfo _$MLSMemberRegisterInfoFromJson(
    Map<String, dynamic> json) {
  return MLSMemberRegisterInfo(
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      MLSLoginID: json['MLSLoginID'] as String,
      PhoneNumber: json['PhoneNumber'] as String,
      Email: json['Email'] as String,
      Password: json['Password'] as String,
      MLSOfficeID: json['MLSOfficeID'] as String,
      VerificationCode: json['VerificationCode'] as String);
}

Map<String, dynamic> _$MLSMemberRegisterInfoToJson(
        MLSMemberRegisterInfo instance) =>
    <String, dynamic>{
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'MLSLoginID': instance.MLSLoginID,
      'PhoneNumber': instance.PhoneNumber,
      'Email': instance.Email,
      'Password': instance.Password,
      'MLSOfficeID': instance.MLSOfficeID,
      'VerificationCode': instance.VerificationCode
    };

StoreCustomerAttributeModel _$StoreCustomerAttributeModelFromJson(
    Map<String, dynamic> json) {
  return StoreCustomerAttributeModel(
      Guid: json['Guid'] as String,
      AttributeName: json['AttributeName'] as String,
      AttributeValue: json['AttributeValue'] as String,
      AttributeType: json['AttributeType'] as String,
      ActionType: json['ActionType'] as int);
}

Map<String, dynamic> _$StoreCustomerAttributeModelToJson(
        StoreCustomerAttributeModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'AttributeName': instance.AttributeName,
      'AttributeValue': instance.AttributeValue,
      'AttributeType': instance.AttributeType,
      'ActionType': instance.ActionType
    };

PermissionRecordModel _$PermissionRecordModelFromJson(
    Map<String, dynamic> json) {
  return PermissionRecordModel(
      Guid: json['Guid'] as String,
      Name: json['Name'] as String,
      SystemName: json['SystemName'] as String,
      Category: json['Category'] as String);
}

Map<String, dynamic> _$PermissionRecordModelToJson(
        PermissionRecordModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'Name': instance.Name,
      'SystemName': instance.SystemName,
      'Category': instance.Category
    };

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) {
  return LoginResponseModel(
      StoreGuid: json['StoreGuid'] as String,
      StoreName: json['StoreName'] as String,
      StoreCustomerGuid: json['StoreCustomerGuid'] as String,
      Username: json['Username'] as String,
      Email: json['Email'] as String,
      CellPhone: json['CellPhone'] as String,
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      LastLoginDate: json['LastLoginDate'] as int,
      LastActivityDate: json['LastActivityDate'] as int,
      ErrorMessage: json['ErrorMessage'] as String,
      IsActive: json['IsActive'] as bool,
      LoginToken: json['LoginToken'] as String,
      IsImpersonation: json['IsImpersonation'] as bool,
      ImpersonatorUserName: json['ImpersonatorUserName'] as String,
      ImpersonatorURL: json['ImpersonatorURL'] as String,
      ImpersonatorToken: json['ImpersonatorToken'] as String,
      CustomerUniqueCode: json['CustomerUniqueCode'] as String,
      IsSignedToday: json['IsSignedToday'] as bool,
      ConsistantSignOnDays: json['ConsistantSignOnDays'] as int,
      RewardPointsBalance: (json['RewardPointsBalance'] as num)?.toDouble(),
      AccountBalance: (json['AccountBalance'] as num)?.toDouble(),
      WechatNickName: json['WechatNickName'] as String,
      WechatThumber: json['WechatThumber'] as String,
      Permissions: (json['Permissions'] as List)
          ?.map((e) => e == null
              ? null
              : PermissionRecordModel.fromJson(e as Map<String, dynamic>))
          ?.toList())
    ..CurrentLanguageGuid = json['CurrentLanguageGuid'] as String;
}

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'StoreGuid': instance.StoreGuid,
      'StoreName': instance.StoreName,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'Username': instance.Username,
      'Email': instance.Email,
      'CellPhone': instance.CellPhone,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'LastLoginDate': instance.LastLoginDate,
      'LastActivityDate': instance.LastActivityDate,
      'ErrorMessage': instance.ErrorMessage,
      'IsActive': instance.IsActive,
      'LoginToken': instance.LoginToken,
      'IsImpersonation': instance.IsImpersonation,
      'ImpersonatorUserName': instance.ImpersonatorUserName,
      'ImpersonatorURL': instance.ImpersonatorURL,
      'ImpersonatorToken': instance.ImpersonatorToken,
      'CustomerUniqueCode': instance.CustomerUniqueCode,
      'CurrentLanguageGuid': instance.CurrentLanguageGuid,
      'IsSignedToday': instance.IsSignedToday,
      'ConsistantSignOnDays': instance.ConsistantSignOnDays,
      'RewardPointsBalance': instance.RewardPointsBalance,
      'AccountBalance': instance.AccountBalance,
      'WechatNickName': instance.WechatNickName,
      'WechatThumber': instance.WechatThumber,
      'Permissions': instance.Permissions
    };
