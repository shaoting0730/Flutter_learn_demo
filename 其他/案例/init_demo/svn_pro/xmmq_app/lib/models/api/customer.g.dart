// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileLoginRequest _$MobileLoginRequestFromJson(Map<String, dynamic> json) {
  return MobileLoginRequest()
    ..PhoneNumber = json['PhoneNumber'] as String
    ..Email = json['Email'] as String
    ..VerifyCode = json['VerifyCode'] as String
    ..Password = json['Password'] as String
    ..WechatAccessTokenJson = json['WechatAccessTokenJson'] as String;
}

Map<String, dynamic> _$MobileLoginRequestToJson(MobileLoginRequest instance) =>
    <String, dynamic>{
      'PhoneNumber': instance.PhoneNumber,
      'Email': instance.Email,
      'VerifyCode': instance.VerifyCode,
      'Password': instance.Password,
      'WechatAccessTokenJson': instance.WechatAccessTokenJson,
    };

SharePictureResponseModel _$SharePictureResponseModelFromJson(
    Map<String, dynamic> json) {
  return SharePictureResponseModel()
    ..ImageUrl = json['ImageUrl'] as String
    ..ShareGuid = json['ShareGuid'] as String;
}

Map<String, dynamic> _$SharePictureResponseModelToJson(
        SharePictureResponseModel instance) =>
    <String, dynamic>{
      'ImageUrl': instance.ImageUrl,
      'ShareGuid': instance.ShareGuid,
    };

SharePictureRequestModel _$SharePictureRequestModelFromJson(
    Map<String, dynamic> json) {
  return SharePictureRequestModel()
    ..TemplateType = json['TemplateType'] as int
    ..Message = json['Message'] as String;
}

Map<String, dynamic> _$SharePictureRequestModelToJson(
        SharePictureRequestModel instance) =>
    <String, dynamic>{
      'TemplateType': instance.TemplateType,
      'Message': instance.Message,
    };

WxloginRequest _$WxloginRequestFromJson(Map<String, dynamic> json) {
  return WxloginRequest()
    ..WechatCode = json['WechatCode'] as String
    ..UserInfo = json['UserInfo'] as String
    ..Iv = json['Iv'] as String
    ..RefCode = json['RefCode'] as String
    ..AutoRegister = json['AutoRegister'] as bool;
}

Map<String, dynamic> _$WxloginRequestToJson(WxloginRequest instance) =>
    <String, dynamic>{
      'WechatCode': instance.WechatCode,
      'UserInfo': instance.UserInfo,
      'Iv': instance.Iv,
      'RefCode': instance.RefCode,
      'AutoRegister': instance.AutoRegister,
    };

StoreInfoModel _$StoreInfoModelFromJson(Map<String, dynamic> json) {
  return StoreInfoModel()
    ..StoreName = json['StoreName'] as String
    ..StoreGuid = json['StoreGuid'] as String
    ..StoreHost = json['StoreHost'] as String
    ..OwnerNickName = json['OwnerNickName'] as String
    ..StoreLogoUrl = json['StoreLogoUrl'] as String
    ..ShareQRCode = json['ShareQRCode'] as String
    ..OwnerGuid = json['OwnerGuid'] as String
    ..IsPublished = json['IsPublished'] as bool
    ..IsOwner = json['IsOwner'] as bool;
}

Map<String, dynamic> _$StoreInfoModelToJson(StoreInfoModel instance) =>
    <String, dynamic>{
      'StoreName': instance.StoreName,
      'StoreGuid': instance.StoreGuid,
      'StoreHost': instance.StoreHost,
      'OwnerNickName': instance.OwnerNickName,
      'StoreLogoUrl': instance.StoreLogoUrl,
      'ShareQRCode': instance.ShareQRCode,
      'OwnerGuid': instance.OwnerGuid,
      'IsPublished': instance.IsPublished,
      'IsOwner': instance.IsOwner,
    };

StoreCustomerAddressModel _$StoreCustomerAddressModelFromJson(
    Map<String, dynamic> json) {
  return StoreCustomerAddressModel()
    ..Guid = json['Guid'] as String
    ..StoreCustomerGuid = json['StoreCustomerGuid'] as String
    ..AddressType = json['AddressType'] as int
    ..FullName = json['FullName'] as String
    ..AddressLine = json['AddressLine'] as String
    ..PostCode = json['PostCode'] as String
    ..Town = json['Town'] as String
    ..City = json['City'] as String
    ..Province = json['Province'] as String
    ..PhoneNumber = json['PhoneNumber'] as String
    ..IDCardType = json['IDCardType'] as int
    ..IDCardNumber = json['IDCardNumber'] as String
    ..Country = json['Country'] as String
    ..DisplayOrder = json['DisplayOrder'] as int;
}

Map<String, dynamic> _$StoreCustomerAddressModelToJson(
        StoreCustomerAddressModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'AddressType': instance.AddressType,
      'FullName': instance.FullName,
      'AddressLine': instance.AddressLine,
      'PostCode': instance.PostCode,
      'Town': instance.Town,
      'City': instance.City,
      'Province': instance.Province,
      'PhoneNumber': instance.PhoneNumber,
      'IDCardType': instance.IDCardType,
      'IDCardNumber': instance.IDCardNumber,
      'Country': instance.Country,
      'DisplayOrder': instance.DisplayOrder,
    };

AddressSearchModel _$AddressSearchModelFromJson(Map<String, dynamic> json) {
  return AddressSearchModel()
    ..Guid = json['Guid'] as String
    ..StoreCustomerGuid = json['StoreCustomerGuid'] as String
    ..AddressType = json['AddressType'] as int
    ..FullName = json['FullName'] as String
    ..AddressLine = json['AddressLine'] as String
    ..PostCode = json['PostCode'] as String
    ..City = json['City'] as String
    ..Province = json['Province'] as String
    ..PhoneNumber = json['PhoneNumber'] as String
    ..IDCardType = json['IDCardType'] as int
    ..IDCardNumber = json['IDCardNumber'] as String
    ..Country = json['Country'] as String
    ..PageIndex = json['PageIndex'] as int
    ..PageSize = json['PageSize'] as int;
}

Map<String, dynamic> _$AddressSearchModelToJson(AddressSearchModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'AddressType': instance.AddressType,
      'FullName': instance.FullName,
      'AddressLine': instance.AddressLine,
      'PostCode': instance.PostCode,
      'City': instance.City,
      'Province': instance.Province,
      'PhoneNumber': instance.PhoneNumber,
      'IDCardType': instance.IDCardType,
      'IDCardNumber': instance.IDCardNumber,
      'Country': instance.Country,
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
    };

PagedListStoreCustomerAddressModel _$PagedListStoreCustomerAddressModelFromJson(
    Map<String, dynamic> json) {
  return PagedListStoreCustomerAddressModel()
    ..PageIndex = json['PageIndex'] as int
    ..PageSize = json['PageSize'] as int
    ..TotalCount = json['TotalCount'] as int
    ..ListObjects = (json['ListObjects'] as List)
        ?.map((e) => e == null
            ? null
            : StoreCustomerAddressModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PagedListStoreCustomerAddressModelToJson(
        PagedListStoreCustomerAddressModel instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects,
    };

ImpersonationorInfoModel _$ImpersonationorInfoModelFromJson(
    Map<String, dynamic> json) {
  return ImpersonationorInfoModel()
    ..Guid = json['Guid'] as String
    ..StoreCustomerGuid = json['StoreCustomerGuid'] as String
    ..FirstName = json['FirstName'] as String
    ..LastName = json['LastName'] as String
    ..PhoneNumber = json['PhoneNumber'] as String
    ..Email = json['Email'] as String
    ..CustomerRoleGuid = json['CustomerRoleGuid'] as String
    ..CustomerRoleSystemName = json['CustomerRoleSystemName'] as String
    ..ProductGuid = json['ProductGuid'] as String;
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
      'ProductGuid': instance.ProductGuid,
    };

ImpersonationModel _$ImpersonationModelFromJson(Map<String, dynamic> json) {
  return ImpersonationModel()
    ..Guid = json['Guid'] as String
    ..ImpersonatorStoreCustomerGuid =
        json['ImpersonatorStoreCustomerGuid'] as String
    ..ImpersonateeStoreCustomerGuid =
        json['ImpersonateeStoreCustomerGuid'] as String
    ..CustomerRoleGuid = json['CustomerRoleGuid'] as String
    ..CustomerRoleSystemName = json['CustomerRoleSystemName'] as String
    ..ProductGuid = json['ProductGuid'] as String;
}

Map<String, dynamic> _$ImpersonationModelToJson(ImpersonationModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'ImpersonatorStoreCustomerGuid': instance.ImpersonatorStoreCustomerGuid,
      'ImpersonateeStoreCustomerGuid': instance.ImpersonateeStoreCustomerGuid,
      'CustomerRoleGuid': instance.CustomerRoleGuid,
      'CustomerRoleSystemName': instance.CustomerRoleSystemName,
      'ProductGuid': instance.ProductGuid,
    };

MyAccessStoresInfo _$MyAccessStoresInfoFromJson(Map<String, dynamic> json) {
  return MyAccessStoresInfo()
    ..StoreName = json['StoreName'] as String
    ..StoreGuid = json['StoreGuid'] as String
    ..StoreHost = json['StoreHost'] as String
    ..OwnerNickName = json['OwnerNickName'] as String
    ..StoreLogoUrl = json['StoreLogoUrl'] as String
    ..ShareQRCode = json['ShareQRCode'] as String
    ..OwnerGuid = json['OwnerGuid'] as bool
    ..IsPublished = json['IsPublished'] as bool
    ..IsOwner = json['IsOwner'] as bool;
}

Map<String, dynamic> _$MyAccessStoresInfoToJson(MyAccessStoresInfo instance) =>
    <String, dynamic>{
      'StoreName': instance.StoreName,
      'StoreGuid': instance.StoreGuid,
      'StoreHost': instance.StoreHost,
      'OwnerNickName': instance.OwnerNickName,
      'StoreLogoUrl': instance.StoreLogoUrl,
      'ShareQRCode': instance.ShareQRCode,
      'OwnerGuid': instance.OwnerGuid,
      'IsPublished': instance.IsPublished,
      'IsOwner': instance.IsOwner,
    };

UserRegisterInfo _$UserRegisterInfoFromJson(Map<String, dynamic> json) {
  return UserRegisterInfo()
    ..ReferredByCode = json['ReferredByCode'] as String
    ..Username = json['Username'] as String
    ..Email = json['Email'] as String
    ..LanguageId = json['LanguageId'] as int
    ..Password = json['Password'] as String
    ..PhoneNumber = json['PhoneNumber'] as String
    ..Newsletter = json['Newsletter'] as bool
    ..FirstName = json['FirstName'] as String
    ..LastName = json['LastName'] as String
    ..LinkWithWechat = json['LinkWithWechat'] as bool
    ..WechatAccessTokenJson = json['WechatAccessTokenJson'] as String
    ..PhoneVerificationCode = json['PhoneVerificationCode'] as String;
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
      'PhoneVerificationCode': instance.PhoneVerificationCode,
    };

MLSMemberUpgrade _$MLSMemberUpgradeFromJson(Map<String, dynamic> json) {
  return MLSMemberUpgrade()
    ..FirstName = json['FirstName'] as String
    ..LastName = json['LastName'] as String
    ..MLSLoginID = json['MLSLoginID'] as String
    ..MLSOfficeID = json['MLSOfficeID'] as String;
}

Map<String, dynamic> _$MLSMemberUpgradeToJson(MLSMemberUpgrade instance) =>
    <String, dynamic>{
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'MLSLoginID': instance.MLSLoginID,
      'MLSOfficeID': instance.MLSOfficeID,
    };

MLSMemberRegisterInfo _$MLSMemberRegisterInfoFromJson(
    Map<String, dynamic> json) {
  return MLSMemberRegisterInfo()
    ..FirstName = json['FirstName'] as String
    ..LastName = json['LastName'] as String
    ..MLSLoginID = json['MLSLoginID'] as String
    ..PhoneNumber = json['PhoneNumber'] as String
    ..Email = json['Email'] as String
    ..Password = json['Password'] as String
    ..MLSOfficeID = json['MLSOfficeID'] as String
    ..VerificationCode = json['VerificationCode'] as String;
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
      'VerificationCode': instance.VerificationCode,
    };

StoreCustomerAttributeModel _$StoreCustomerAttributeModelFromJson(
    Map<String, dynamic> json) {
  return StoreCustomerAttributeModel()
    ..Guid = json['Guid'] as String
    ..AttributeName = json['AttributeName'] as String
    ..AttributeValue = json['AttributeValue'] as String
    ..AttributeType = json['AttributeType'] as String
    ..ActionType = json['ActionType'] as int;
}

Map<String, dynamic> _$StoreCustomerAttributeModelToJson(
        StoreCustomerAttributeModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'AttributeName': instance.AttributeName,
      'AttributeValue': instance.AttributeValue,
      'AttributeType': instance.AttributeType,
      'ActionType': instance.ActionType,
    };

PermissionRecordModel _$PermissionRecordModelFromJson(
    Map<String, dynamic> json) {
  return PermissionRecordModel()
    ..Guid = json['Guid'] as String
    ..Name = json['Name'] as String
    ..SystemName = json['SystemName'] as String
    ..Category = json['Category'] as String;
}

Map<String, dynamic> _$PermissionRecordModelToJson(
        PermissionRecordModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'Name': instance.Name,
      'SystemName': instance.SystemName,
      'Category': instance.Category,
    };

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) {
  return LoginResponseModel()
    ..StoreGuid = json['StoreGuid'] as String
    ..StoreName = json['StoreName'] as String
    ..StoreCustomerGuid = json['StoreCustomerGuid'] as String
    ..Username = json['Username'] as String
    ..Email = json['Email'] as String
    ..CellPhone = json['CellPhone'] as String
    ..FirstName = json['FirstName'] as String
    ..LastName = json['LastName'] as String
    ..LastLoginDate = json['LastLoginDate'] as int
    ..LastActivityDate = json['LastActivityDate'] as int
    ..AcceptAgreement = json['AcceptAgreement'] as int
    ..DisableComment = json['DisableComment'] as int
    ..ErrorMessage = json['ErrorMessage'] as String
    ..IsActive = json['IsActive'] as bool
    ..LoginToken = json['LoginToken'] as String
    ..IsImpersonation = json['IsImpersonation'] as bool
    ..ImpersonatorUserName = json['ImpersonatorUserName'] as String
    ..ImpersonatorURL = json['ImpersonatorURL'] as String
    ..ImpersonatorToken = json['ImpersonatorToken'] as String
    ..CustomerUniqueCode = json['CustomerUniqueCode'] as String
    ..CurrentLanguageGuid = json['CurrentLanguageGuid'] as String
    ..IsSignedToday = json['IsSignedToday'] as bool
    ..ConsistantSignOnDays = json['ConsistantSignOnDays'] as int
    ..RewardPointsBalance = (json['RewardPointsBalance'] as num)?.toDouble()
    ..AccountBalance = (json['AccountBalance'] as num)?.toDouble()
    ..WechatNickName = json['WechatNickName'] as String
    ..WechatThumber = json['WechatThumber'] as String
    ..Permissions = (json['Permissions'] as List)
        ?.map((e) => e == null
            ? null
            : PermissionRecordModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..StoreApplication = json['StoreApplication'] as Map<String, dynamic>;
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
      'AcceptAgreement': instance.AcceptAgreement,
      'DisableComment': instance.DisableComment,
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
      'Permissions': instance.Permissions,
      'StoreApplication': instance.StoreApplication,
    };
