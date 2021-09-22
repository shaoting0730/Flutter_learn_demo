// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      'ProductGuid': instance.ProductGuid
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
      'ProductGuid': instance.ProductGuid
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
      'PhoneVerificationCode': instance.PhoneVerificationCode
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
      'ActionType': instance.ActionType
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
      'Category': instance.Category
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
    ..MembershipLevel = json['MembershipLevel'] as String
    ..Permissions = (json['Permissions'] as List)
        ?.map((e) => e == null
            ? null
            : PermissionRecordModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
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
      'MembershipLevel': instance.MembershipLevel,
      'Permissions': instance.Permissions
    };

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) {
  return CustomerModel()
    ..StoreId = json['StoreId'] as int
    ..Username = json['Username'] as String
    ..Email = json['Email'] as String
    ..FullName = json['FullName'] as String
    ..FirstName = json['FirstName'] as String
    ..LastName = json['LastName'] as String
    ..PhoneNumber = json['PhoneNumber'] as String
    ..PhoneNumberValidated = json['PhoneNumberValidated'] as bool
    ..Newsletter = json['Newsletter'] as bool
    ..AccountBalance = (json['AccountBalance'] as num)?.toDouble()
    ..RewardPoints = (json['RewardPoints'] as num)?.toDouble()
    ..RemainingRedBonus = (json['RemainingRedBonus'] as num)?.toDouble()
    ..IsSystemAccount = json['IsSystemAccount'] as bool
    ..SystemName = json['SystemName'] as String
    ..CustomerUniqueCode = json['CustomerUniqueCode'] as String
    ..LastIpAddress = json['LastIpAddress'] as String
    ..LastLoginDateUtc = json['LastLoginDateUtc'] as int
    ..IsTurnOnRewardPoints = json['IsTurnOnRewardPoints'] as bool
    ..IsEligibleForPromotion = json['IsEligibleForPromotion'] as bool
    ..LastActivityDateUtc = json['LastActivityDateUtc'] as int
    ..RegisterOnUtc = json['RegisterOnUtc'] as int
    ..PaymentMethod = json['PaymentMethod'] as String
    ..Discounts4Dispay = json['Discounts4Dispay'] as String
    ..Company = json['Company'] as String
    ..CompanyWeb = json['CompanyWeb'] as String
    ..Country = json['Country'] as String
    ..SalesPerson = json['SalesPerson'] as String
    ..CustomerManager = json['CustomerManager'] as String
    ..Email4Orders = json['Email4Orders'] as String
    ..MinAmount4Deposit = (json['MinAmount4Deposit'] as num)?.toDouble()
    ..WechatNickName = json['WechatNickName'] as String
    ..AcquireFrom = json['AcquireFrom'] as String
    ..CompanyFollowUpStatus = json['CompanyFollowUpStatus'] as String
    ..Abbreviation = json['Abbreviation'] as String
    ..Wechat = json['Wechat'] as String
    ..QQ = json['QQ'] as String
    ..CompanyAddress = json['CompanyAddress'] as String
    ..SalesModel = json['SalesModel'] as String
    ..OperationCapability = json['OperationCapability'] as String
    ..CustomerComments = json['CustomerComments'] as String
    ..AutoFill = json['AutoFill'] as String
    ..MembershipId = json['MembershipId'] as int
    ..MembershipLevel = json['MembershipLevel'] as String
    ..ReferredByStoreCustomerId = json['ReferredByStoreCustomerId'] as int;
}

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'StoreId': instance.StoreId,
      'Username': instance.Username,
      'Email': instance.Email,
      'FullName': instance.FullName,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'PhoneNumber': instance.PhoneNumber,
      'PhoneNumberValidated': instance.PhoneNumberValidated,
      'Newsletter': instance.Newsletter,
      'AccountBalance': instance.AccountBalance,
      'RewardPoints': instance.RewardPoints,
      'RemainingRedBonus': instance.RemainingRedBonus,
      'IsSystemAccount': instance.IsSystemAccount,
      'SystemName': instance.SystemName,
      'CustomerUniqueCode': instance.CustomerUniqueCode,
      'LastIpAddress': instance.LastIpAddress,
      'LastLoginDateUtc': instance.LastLoginDateUtc,
      'IsTurnOnRewardPoints': instance.IsTurnOnRewardPoints,
      'IsEligibleForPromotion': instance.IsEligibleForPromotion,
      'LastActivityDateUtc': instance.LastActivityDateUtc,
      'RegisterOnUtc': instance.RegisterOnUtc,
      'PaymentMethod': instance.PaymentMethod,
      'Discounts4Dispay': instance.Discounts4Dispay,
      'Company': instance.Company,
      'CompanyWeb': instance.CompanyWeb,
      'Country': instance.Country,
      'SalesPerson': instance.SalesPerson,
      'CustomerManager': instance.CustomerManager,
      'Email4Orders': instance.Email4Orders,
      'MinAmount4Deposit': instance.MinAmount4Deposit,
      'WechatNickName': instance.WechatNickName,
      'AcquireFrom': instance.AcquireFrom,
      'CompanyFollowUpStatus': instance.CompanyFollowUpStatus,
      'Abbreviation': instance.Abbreviation,
      'Wechat': instance.Wechat,
      'QQ': instance.QQ,
      'CompanyAddress': instance.CompanyAddress,
      'SalesModel': instance.SalesModel,
      'OperationCapability': instance.OperationCapability,
      'CustomerComments': instance.CustomerComments,
      'AutoFill': instance.AutoFill,
      'MembershipId': instance.MembershipId,
      'MembershipLevel': instance.MembershipLevel,
      'ReferredByStoreCustomerId': instance.ReferredByStoreCustomerId
    };

AimRevenueModel _$AimRevenueModelFromJson(Map<String, dynamic> json) {
  return AimRevenueModel()
    ..Success = json['Success'] as bool
    ..Today = (json['Today'] as num)?.toDouble()
    ..Month = (json['Month'] as num)?.toDouble()
    ..All = (json['All'] as num)?.toDouble();
}

Map<String, dynamic> _$AimRevenueModelToJson(AimRevenueModel instance) =>
    <String, dynamic>{
      'Success': instance.Success,
      'Today': instance.Today,
      'Month': instance.Month,
      'All': instance.All
    };

NotifySummaryModel _$NotifySummaryModelFromJson(Map<String, dynamic> json) {
  return NotifySummaryModel()..unread = json['unread'] as int;
}

Map<String, dynamic> _$NotifySummaryModelToJson(NotifySummaryModel instance) =>
    <String, dynamic>{'unread': instance.unread};

NotifyListItemModel _$NotifyListItemModelFromJson(Map<String, dynamic> json) {
  return NotifyListItemModel()
    ..StoreCustomerId = json['StoreCustomerId'] as int
    ..Subject = json['Subject'] as String
    ..Body = json['Body'] as String
    ..CreatedOnUtc = json['CreatedOnUtc'] == null
        ? null
        : DateTime.parse(json['CreatedOnUtc'] as String)
    ..Status = json['Status'] as int;
}

Map<String, dynamic> _$NotifyListItemModelToJson(
        NotifyListItemModel instance) =>
    <String, dynamic>{
      'StoreCustomerId': instance.StoreCustomerId,
      'Subject': instance.Subject,
      'Body': instance.Body,
      'CreatedOnUtc': instance.CreatedOnUtc?.toIso8601String(),
      'Status': instance.Status
    };

AffiliateSummaryModel _$AffiliateSummaryModelFromJson(
    Map<String, dynamic> json) {
  return AffiliateSummaryModel()
    ..AffiliateStoreCustomerId = json['AffiliateStoreCustomerId'] as int
    ..AffiliateUsername = json['AffiliateUsername'] as String
    ..AffiliateCompany = json['AffiliateCompany'] as String
    ..AffiliateEmail = json['AffiliateEmail'] as String
    ..CreatedOnUtc = json['CreatedOnUtc'] == null
        ? null
        : DateTime.parse(json['CreatedOnUtc'] as String)
    ..AffiliateDate = json['AffiliateDate'] as int
    ..AffiliateAmount = (json['AffiliateAmount'] as num)?.toDouble()
    ..MembershipLevel = json['MembershipLevel'] as String
    ..AffiliatePoint = json['AffiliatePoint'] as int
    ..MyAffiliates = (json['MyAffiliates'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    );
}

Map<String, dynamic> _$AffiliateSummaryModelToJson(
        AffiliateSummaryModel instance) =>
    <String, dynamic>{
      'AffiliateStoreCustomerId': instance.AffiliateStoreCustomerId,
      'AffiliateUsername': instance.AffiliateUsername,
      'AffiliateCompany': instance.AffiliateCompany,
      'AffiliateEmail': instance.AffiliateEmail,
      'CreatedOnUtc': instance.CreatedOnUtc?.toIso8601String(),
      'AffiliateDate': instance.AffiliateDate,
      'AffiliateAmount': instance.AffiliateAmount,
      'MembershipLevel': instance.MembershipLevel,
      'AffiliatePoint': instance.AffiliatePoint,
      'MyAffiliates': instance.MyAffiliates
    };

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) {
  return OrderResponse()
    ..CurrentPageIndex = json['CurrentPageIndex'] as int
    ..PageSize = json['PageSize'] as int
    ..TotalCount = json['TotalCount'] as int
    ..TotalAmount = (json['TotalAmount'] as num)?.toDouble()
    ..TotalPaidAmount = (json['TotalPaidAmount'] as num)?.toDouble()
    ..AccountBalance = (json['AccountBalance'] as num)?.toDouble()
    ..PaidByRewardPoints = (json['PaidByRewardPoints'] as num)?.toDouble()
    ..TotalAvailableRewardPoints =
        (json['TotalAvailableRewardPoints'] as num)?.toDouble()
    ..TotalRewardPointsAmount =
        (json['TotalRewardPointsAmount'] as num)?.toDouble()
    ..Orders = (json['Orders'] as List)
        ?.map((e) =>
            e == null ? null : OrderModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'CurrentPageIndex': instance.CurrentPageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'TotalAmount': instance.TotalAmount,
      'TotalPaidAmount': instance.TotalPaidAmount,
      'AccountBalance': instance.AccountBalance,
      'PaidByRewardPoints': instance.PaidByRewardPoints,
      'TotalAvailableRewardPoints': instance.TotalAvailableRewardPoints,
      'TotalRewardPointsAmount': instance.TotalRewardPointsAmount,
      'Orders': instance.Orders
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel()
    ..OrderNotes = (json['OrderNotes'] as List)
        ?.map((e) => e == null
            ? null
            : OrderNoteModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..OrderProduct = (json['OrderProduct'] as List)
        ?.map((e) => e == null
            ? null
            : OrderItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..OrderPhotos =
        (json['OrderPhotos'] as List)?.map((e) => e as String)?.toList()
    ..OrderOperations =
        (json['OrderOperations'] as List)?.map((e) => e as String)?.toList()
    ..PhotoTakeTime = json['PhotoTakeTime'] as int
    ..ReferenceOrderId = json['ReferenceOrderId'] as String
    ..OrderTypeId = json['OrderTypeId'] as int
    ..TrackingNumber = json['TrackingNumber'] as String
    ..StoreId = json['StoreId'] as int
    ..StoreCustomerId = json['StoreCustomerId'] as int
    ..CustomerUserName = json['CustomerUserName'] as String
    ..MembershipLevel = json['MembershipLevel'] as String
    ..CustomerUniqueId = json['CustomerUniqueId'] as String
    ..BillingName = json['BillingName'] as String
    ..BillingCompany = json['BillingCompany'] as String
    ..BillingAddressLine = json['BillingAddressLine'] as String
    ..BillingCity = json['BillingCity'] as String
    ..BillingPostcode = json['BillingPostcode'] as String
    ..BillingPhoneNumber = json['BillingPhoneNumber'] as String
    ..BillingProvince = json['BillingProvince'] as String
    ..BillingCountry = json['BillingCountry'] as String
    ..ShipFromName = json['ShipFromName'] as String
    ..ShipFromEmail = json['ShipFromEmail'] as String
    ..ShipFromPhone = json['ShipFromPhone'] as String
    ..ShipFromCellPhone = json['ShipFromCellPhone'] as String
    ..ShipFromAddress = json['ShipFromAddress'] as String
    ..ShipFromAddress2 = json['ShipFromAddress2'] as String
    ..ShipFromAddress3 = json['ShipFromAddress3'] as String
    ..ShipFromCity = json['ShipFromCity'] as String
    ..ShipFromProvince = json['ShipFromProvince'] as String
    ..ShipFromPostalCode = json['ShipFromPostalCode'] as String
    ..ShipFromCountry = json['ShipFromCountry'] as String
    ..ShipToName = json['ShipToName'] as String
    ..ShipToAddress = json['ShipToAddress'] as String
    ..ShipToCity = json['ShipToCity'] as String
    ..ShipToProvince = json['ShipToProvince'] as String
    ..ShipToPostalCode = json['ShipToPostalCode'] as String
    ..ShipToAreaCode = json['ShipToAreaCode'] as String
    ..ShipToTownReadonly = json['ShipToTownReadonly'] as String
    ..ShipToProvinceId = json['ShipToProvinceId'] as int
    ..ShipToCountry = json['ShipToCountry'] as String
    ..ShipToIDCardType = json['ShipToIDCardType'] as int
    ..ShipToIDCardNumber = json['ShipToIDCardNumber'] as String
    ..ShipToQQ = json['ShipToQQ'] as String
    ..ShipToWechat = json['ShipToWechat'] as String
    ..ShipToEmail = json['ShipToEmail'] as String
    ..ShipToPhone = json['ShipToPhone'] as String
    ..ShipToCellPhone = json['ShipToCellPhone'] as String
    ..OrderStatusId = json['OrderStatusId'] as int
    ..ShippingStatusId = json['ShippingStatusId'] as int
    ..PaymentMethodSystemName = json['PaymentMethodSystemName'] as String
    ..CustomerCurrencyCode = json['CustomerCurrencyCode'] as String
    ..CurrencyRate = (json['CurrencyRate'] as num)?.toDouble()
    ..OrderTotalTax = (json['OrderTotalTax'] as num)?.toDouble()
    ..OrderSubtotal = (json['OrderSubtotal'] as num)?.toDouble()
    ..OrderSubTotalDiscount = (json['OrderSubTotalDiscount'] as num)?.toDouble()
    ..OrderDiscount = (json['OrderDiscount'] as num)?.toDouble()
    ..OrderCouponDiscount = (json['OrderCouponDiscount'] as num)?.toDouble()
    ..OrderCouponCode = json['OrderCouponCode'] as String
    ..OrderShipping = (json['OrderShipping'] as num)?.toDouble()
    ..OrderShippingDiscount = (json['OrderShippingDiscount'] as num)?.toDouble()
    ..PaymentMethodAdditionalFeeInclTax =
        (json['PaymentMethodAdditionalFeeInclTax'] as num)?.toDouble()
    ..OrderChargableWeight = (json['OrderChargableWeight'] as num)?.toDouble()
    ..OrderTotal = (json['OrderTotal'] as num)?.toDouble()
    ..PaidByBonus = (json['PaidByBonus'] as num)?.toDouble()
    ..PaidByRewardPoints = (json['PaidByRewardPoints'] as num)?.toDouble()
    ..UsedRewardPoints = (json['UsedRewardPoints'] as num)?.toDouble()
    ..RewardPointRedeemRate = (json['RewardPointRedeemRate'] as num)?.toDouble()
    ..OrderReceivable = (json['OrderReceivable'] as num)?.toDouble()
    ..RefundedAmount = (json['RefundedAmount'] as num)?.toDouble()
    ..RewardPoints = json['RewardPoints'] as int
    ..RewardPointsWereAdded = json['RewardPointsWereAdded'] as bool
    ..CustomerLanguageId = json['CustomerLanguageId'] as int
    ..CustomerIp = json['CustomerIp'] as String
    ..PurchaseOrderNumber = json['PurchaseOrderNumber'] as String
    ..PackageName = json['PackageName'] as String
    ..PaidDateUtc = json['PaidDateUtc'] as int
    ..ServiceProviderId = json['ServiceProviderId'] as int
    ..ServiceProvider = json['ServiceProvider'] as String
    ..WarehouseLocation = json['WarehouseLocation'] as String
    ..ShippingRateComputationMethodSystemName =
        json['ShippingRateComputationMethodSystemName'] as String
    ..CreatedOnUtc = json['CreatedOnUtc'] as int
    ..Notes = json['Notes'] as String
    ..Message = json['Message'] as String
    ..PackageLocation = json['PackageLocation'] as String
    ..PackingInstruction = json['PackingInstruction'] as String
    ..SunBlogId = json['SunBlogId'] as String
    ..EncryptedAddress = json['EncryptedAddress'] as String
    ..EncryptedPostCode = json['EncryptedPostCode'] as String
    ..EncryptedPhoneNumber = json['EncryptedPhoneNumber'] as String
    ..EncryptedIDCardNumber = json['EncryptedIDCardNumber'] as String
    ..EncryptedEmail = json['EncryptedEmail'] as String
    ..Platform = json['Platform'] as String
    ..SubStoreName = json['SubStoreName'] as String
    ..DisableHKESelection = json['DisableHKESelection'] as bool
    ..AimOrderWithdraw = (json['AimOrderWithdraw'] as num)?.toDouble()
    ..AimOrderCommission = (json['AimOrderCommission'] as num)?.toDouble()
    ..DisableOrderMerge = json['DisableOrderMerge'] as bool
    ..ProductTaxTotal = (json['ProductTaxTotal'] as num)?.toDouble()
    ..GiftCard = json['GiftCard'] as String
    ..PaidAmount = (json['PaidAmount'] as num)?.toDouble()
    ..PaymentCurrency = json['PaymentCurrency'] as String
    ..PaymentResponse = json['PaymentResponse'] as String;
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'OrderNotes': instance.OrderNotes,
      'OrderProduct': instance.OrderProduct,
      'OrderPhotos': instance.OrderPhotos,
      'OrderOperations': instance.OrderOperations,
      'PhotoTakeTime': instance.PhotoTakeTime,
      'ReferenceOrderId': instance.ReferenceOrderId,
      'OrderTypeId': instance.OrderTypeId,
      'TrackingNumber': instance.TrackingNumber,
      'StoreId': instance.StoreId,
      'StoreCustomerId': instance.StoreCustomerId,
      'CustomerUserName': instance.CustomerUserName,
      'MembershipLevel': instance.MembershipLevel,
      'CustomerUniqueId': instance.CustomerUniqueId,
      'BillingName': instance.BillingName,
      'BillingCompany': instance.BillingCompany,
      'BillingAddressLine': instance.BillingAddressLine,
      'BillingCity': instance.BillingCity,
      'BillingPostcode': instance.BillingPostcode,
      'BillingPhoneNumber': instance.BillingPhoneNumber,
      'BillingProvince': instance.BillingProvince,
      'BillingCountry': instance.BillingCountry,
      'ShipFromName': instance.ShipFromName,
      'ShipFromEmail': instance.ShipFromEmail,
      'ShipFromPhone': instance.ShipFromPhone,
      'ShipFromCellPhone': instance.ShipFromCellPhone,
      'ShipFromAddress': instance.ShipFromAddress,
      'ShipFromAddress2': instance.ShipFromAddress2,
      'ShipFromAddress3': instance.ShipFromAddress3,
      'ShipFromCity': instance.ShipFromCity,
      'ShipFromProvince': instance.ShipFromProvince,
      'ShipFromPostalCode': instance.ShipFromPostalCode,
      'ShipFromCountry': instance.ShipFromCountry,
      'ShipToName': instance.ShipToName,
      'ShipToAddress': instance.ShipToAddress,
      'ShipToCity': instance.ShipToCity,
      'ShipToProvince': instance.ShipToProvince,
      'ShipToPostalCode': instance.ShipToPostalCode,
      'ShipToAreaCode': instance.ShipToAreaCode,
      'ShipToTownReadonly': instance.ShipToTownReadonly,
      'ShipToProvinceId': instance.ShipToProvinceId,
      'ShipToCountry': instance.ShipToCountry,
      'ShipToIDCardType': instance.ShipToIDCardType,
      'ShipToIDCardNumber': instance.ShipToIDCardNumber,
      'ShipToQQ': instance.ShipToQQ,
      'ShipToWechat': instance.ShipToWechat,
      'ShipToEmail': instance.ShipToEmail,
      'ShipToPhone': instance.ShipToPhone,
      'ShipToCellPhone': instance.ShipToCellPhone,
      'OrderStatusId': instance.OrderStatusId,
      'ShippingStatusId': instance.ShippingStatusId,
      'PaymentMethodSystemName': instance.PaymentMethodSystemName,
      'CustomerCurrencyCode': instance.CustomerCurrencyCode,
      'CurrencyRate': instance.CurrencyRate,
      'OrderTotalTax': instance.OrderTotalTax,
      'OrderSubtotal': instance.OrderSubtotal,
      'OrderSubTotalDiscount': instance.OrderSubTotalDiscount,
      'OrderDiscount': instance.OrderDiscount,
      'OrderCouponDiscount': instance.OrderCouponDiscount,
      'OrderCouponCode': instance.OrderCouponCode,
      'OrderShipping': instance.OrderShipping,
      'OrderShippingDiscount': instance.OrderShippingDiscount,
      'PaymentMethodAdditionalFeeInclTax':
          instance.PaymentMethodAdditionalFeeInclTax,
      'OrderChargableWeight': instance.OrderChargableWeight,
      'OrderTotal': instance.OrderTotal,
      'PaidByBonus': instance.PaidByBonus,
      'PaidByRewardPoints': instance.PaidByRewardPoints,
      'UsedRewardPoints': instance.UsedRewardPoints,
      'RewardPointRedeemRate': instance.RewardPointRedeemRate,
      'OrderReceivable': instance.OrderReceivable,
      'RefundedAmount': instance.RefundedAmount,
      'RewardPoints': instance.RewardPoints,
      'RewardPointsWereAdded': instance.RewardPointsWereAdded,
      'CustomerLanguageId': instance.CustomerLanguageId,
      'CustomerIp': instance.CustomerIp,
      'PurchaseOrderNumber': instance.PurchaseOrderNumber,
      'PackageName': instance.PackageName,
      'PaidDateUtc': instance.PaidDateUtc,
      'ServiceProviderId': instance.ServiceProviderId,
      'ServiceProvider': instance.ServiceProvider,
      'WarehouseLocation': instance.WarehouseLocation,
      'ShippingRateComputationMethodSystemName':
          instance.ShippingRateComputationMethodSystemName,
      'CreatedOnUtc': instance.CreatedOnUtc,
      'Notes': instance.Notes,
      'Message': instance.Message,
      'PackageLocation': instance.PackageLocation,
      'PackingInstruction': instance.PackingInstruction,
      'SunBlogId': instance.SunBlogId,
      'EncryptedAddress': instance.EncryptedAddress,
      'EncryptedPostCode': instance.EncryptedPostCode,
      'EncryptedPhoneNumber': instance.EncryptedPhoneNumber,
      'EncryptedIDCardNumber': instance.EncryptedIDCardNumber,
      'EncryptedEmail': instance.EncryptedEmail,
      'Platform': instance.Platform,
      'SubStoreName': instance.SubStoreName,
      'DisableHKESelection': instance.DisableHKESelection,
      'DisableOrderMerge': instance.DisableOrderMerge,
      'ProductTaxTotal': instance.ProductTaxTotal,
      'GiftCard': instance.GiftCard,
      'PaidAmount': instance.PaidAmount,
      'PaymentCurrency': instance.PaymentCurrency,
      'PaymentResponse': instance.PaymentResponse
    };

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) {
  return OrderItemModel()
    ..OrderItemGuid = json['OrderItemGuid'] as String
    ..ProductGuid = json['ProductGuid'] as String
    ..OrderId = json['OrderId'] as int
    ..CategoryId = json['CategoryId'] as int
    ..SubCategoryId = json['SubCategoryId'] as int
    ..ProductId = json['ProductId'] as int
    ..AttributeComboId = json['AttributeComboId'] as int
    ..Quantity = json['Quantity'] as int
    ..StatusId = json['StatusId'] as int
    ..UnitPrice = (json['UnitPrice'] as num)?.toDouble()
    ..OldPrice = (json['OldPrice'] as num)?.toDouble()
    ..SubTotal = (json['SubTotal'] as num)?.toDouble()
    ..DiscountAmount = (json['DiscountAmount'] as num)?.toDouble()
    ..ItemWeight = (json['ItemWeight'] as num)?.toDouble()
    ..UserComment = json['UserComment'] as String
    ..ProductName = json['ProductName'] as String
    ..ProductImageUrl = json['ProductImageUrl'] as String
    ..VendorOrderNumber = json['VendorOrderNumber'] as String
    ..Received = json['Received'] as bool
    ..ShoppingWebsite = json['ShoppingWebsite'] as String
    ..OverseaLogistic = json['OverseaLogistic'] as String
    ..OverseaTrackingNumber = json['OverseaTrackingNumber'] as String
    ..ClaimedQuantity = json['ClaimedQuantity'] as int
    ..ProcessedQuantity = json['ProcessedQuantity'] as int
    ..ItemType = json['ItemType'] as String
    ..CategoryName = json['CategoryName'] as String
    ..ShippingWeight = (json['ShippingWeight'] as num)?.toDouble()
    ..ProductBarcode = json['ProductBarcode'] as String
    ..ProductNumber = json['ProductNumber'] as String
    ..ProductSKU = json['ProductSKU'] as String
    ..ProductEnglishName = json['ProductEnglishName'] as String
    ..ProductTax = (json['ProductTax'] as num)?.toDouble()
    ..IsSingleShipment = json['IsSingleShipment'] as bool
    ..BrandId = json['BrandId'] as int
    ..LimitPerOrder = json['LimitPerOrder'] as int
    ..MinimumPerOrder = json['MinimumPerOrder'] as int
    ..ProductRegistered = json['ProductRegistered'] as bool
    ..ProductUnitTax = (json['ProductUnitTax'] as num)?.toDouble()
    ..Published = json['Published'] as bool
    ..DisableBuyButton = json['DisableBuyButton'] as bool
    ..VendorCode = json['VendorCode'] as String
    ..ProductCost = (json['ProductCost'] as num)?.toDouble()
    ..IsInWarehouse = json['IsInWarehouse'] as bool
    ..IsOutOfStore = json['IsOutOfStore'] as bool
    ..GiftCardTypeId = json['GiftCardTypeId'] as int
    ..ProductPurchaseCost = (json['ProductPurchaseCost'] as num)?.toDouble()
    ..WholesalePrice1 = (json['WholesalePrice1'] as num)?.toDouble()
    ..WholesaleLimit1 = json['WholesaleLimit1'] as int
    ..WholesalePrice2 = (json['WholesalePrice2'] as num)?.toDouble()
    ..WholesaleLimit2 = json['WholesaleLimit2'] as int
    ..WholesalePrice3 = (json['WholesalePrice3'] as num)?.toDouble()
    ..WholesaleLimit3 = json['WholesaleLimit3'] as int
    ..WarehouseType = json['WarehouseType'] as int
    ..CustomUnitPrice = (json['CustomUnitPrice'] as num)?.toDouble()
    ..CustomUnitPriceType = json['CustomUnitPriceType'] as int;
}

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'OrderItemGuid': instance.OrderItemGuid,
      'ProductGuid': instance.ProductGuid,
      'OrderId': instance.OrderId,
      'CategoryId': instance.CategoryId,
      'SubCategoryId': instance.SubCategoryId,
      'ProductId': instance.ProductId,
      'AttributeComboId': instance.AttributeComboId,
      'Quantity': instance.Quantity,
      'StatusId': instance.StatusId,
      'UnitPrice': instance.UnitPrice,
      'OldPrice': instance.OldPrice,
      'SubTotal': instance.SubTotal,
      'DiscountAmount': instance.DiscountAmount,
      'ItemWeight': instance.ItemWeight,
      'UserComment': instance.UserComment,
      'ProductName': instance.ProductName,
      'ProductImageUrl': instance.ProductImageUrl,
      'VendorOrderNumber': instance.VendorOrderNumber,
      'Received': instance.Received,
      'ShoppingWebsite': instance.ShoppingWebsite,
      'OverseaLogistic': instance.OverseaLogistic,
      'OverseaTrackingNumber': instance.OverseaTrackingNumber,
      'ClaimedQuantity': instance.ClaimedQuantity,
      'ProcessedQuantity': instance.ProcessedQuantity,
      'ItemType': instance.ItemType,
      'CategoryName': instance.CategoryName,
      'ShippingWeight': instance.ShippingWeight,
      'ProductBarcode': instance.ProductBarcode,
      'ProductNumber': instance.ProductNumber,
      'ProductSKU': instance.ProductSKU,
      'ProductEnglishName': instance.ProductEnglishName,
      'ProductTax': instance.ProductTax,
      'IsSingleShipment': instance.IsSingleShipment,
      'BrandId': instance.BrandId,
      'LimitPerOrder': instance.LimitPerOrder,
      'MinimumPerOrder': instance.MinimumPerOrder,
      'ProductRegistered': instance.ProductRegistered,
      'ProductUnitTax': instance.ProductUnitTax,
      'Published': instance.Published,
      'DisableBuyButton': instance.DisableBuyButton,
      'VendorCode': instance.VendorCode,
      'ProductCost': instance.ProductCost,
      'IsInWarehouse': instance.IsInWarehouse,
      'IsOutOfStore': instance.IsOutOfStore,
      'GiftCardTypeId': instance.GiftCardTypeId,
      'ProductPurchaseCost': instance.ProductPurchaseCost,
      'WholesalePrice1': instance.WholesalePrice1,
      'WholesaleLimit1': instance.WholesaleLimit1,
      'WholesalePrice2': instance.WholesalePrice2,
      'WholesaleLimit2': instance.WholesaleLimit2,
      'WholesalePrice3': instance.WholesalePrice3,
      'WholesaleLimit3': instance.WholesaleLimit3,
      'WarehouseType': instance.WarehouseType,
      'CustomUnitPrice': instance.CustomUnitPrice,
      'CustomUnitPriceType': instance.CustomUnitPriceType
    };

OrderNoteModel _$OrderNoteModelFromJson(Map<String, dynamic> json) {
  return OrderNoteModel()
    ..OrderId = json['OrderId'] as int
    ..NoteName = json['NoteName'] as String
    ..NoteValue = json['NoteValue'] as String
    ..OrderStatusId = json['OrderStatusId'] as int
    ..DisplayToCustomer = json['DisplayToCustomer'] as bool
    ..CreatedOnUtc = json['CreatedOnUtc'] as int
    ..CreatedBy = json['CreatedBy'] as String;
}

Map<String, dynamic> _$OrderNoteModelToJson(OrderNoteModel instance) =>
    <String, dynamic>{
      'OrderId': instance.OrderId,
      'NoteName': instance.NoteName,
      'NoteValue': instance.NoteValue,
      'OrderStatusId': instance.OrderStatusId,
      'DisplayToCustomer': instance.DisplayToCustomer,
      'CreatedOnUtc': instance.CreatedOnUtc,
      'CreatedBy': instance.CreatedBy
    };

CustomerPrepayAccountHistoryList _$CustomerPrepayAccountHistoryListFromJson(
    Map<String, dynamic> json) {
  return CustomerPrepayAccountHistoryList()
    ..AccountBalance = (json['AccountBalance'] as num)?.toDouble()
    ..WithdrawalBalance = (json['WithdrawalBalance'] as num)?.toDouble()
    ..AccountHistory = json['AccountHistory'] == null
        ? null
        : PageListResponse.fromJson(
            json['AccountHistory'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CustomerPrepayAccountHistoryListToJson(
        CustomerPrepayAccountHistoryList instance) =>
    <String, dynamic>{
      'AccountBalance': instance.AccountBalance,
      'WithdrawalBalance': instance.WithdrawalBalance,
      'AccountHistory': instance.AccountHistory
    };

PageListResponse<T> _$PageListResponseFromJson<T>(Map<String, dynamic> json) {
  return PageListResponse<T>()
    ..CurrentPageIndex = json['CurrentPageIndex'] as int
    ..PageSize = json['PageSize'] as int
    ..TotalCount = json['TotalCount'] as int
    ..ListObjects = json['ListObjects'] == null
        ? null
        : _dataFromJsonCustomerPrepayAccountHistoryModel(
            json['ListObjects'] as List);
}

Map<String, dynamic> _$PageListResponseToJson<T>(
        PageListResponse<T> instance) =>
    <String, dynamic>{
      'CurrentPageIndex': instance.CurrentPageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects == null
          ? null
          : _dataToJson(instance.ListObjects)
    };

CustomerPrepayAccountHistoryModel _$CustomerPrepayAccountHistoryModelFromJson(
    Map<String, dynamic> json) {
  return CustomerPrepayAccountHistoryModel(
      Amount: (json['Amount'] as num)?.toDouble(),
      Summary: json['Summary'] as String)
    ..UsedType = json['UsedType'] as int
    ..Balance = (json['Balance'] as num)?.toDouble()
    ..Message = json['Message'] as String
    ..CreatedOnUtc = json['CreatedOnUtc'] as int
    ..ApprovedStoreCustomerId = json['ApprovedStoreCustomerId'] as int
    ..ApprovedOnUtc = json['ApprovedOnUtc'] as int
    ..ValueAccountUsedType = json['ValueAccountUsedType'] as String
    ..ReferenceOrderId = json['ReferenceOrderId'] as String
    ..OrderShipmentStatus = json['OrderShipmentStatus'] as String
    ..ApprovedBy = json['ApprovedBy'] as String
    ..ExchangeRate = (json['ExchangeRate'] as num)?.toDouble()
    ..OrderAmount = (json['OrderAmount'] as num)?.toDouble();
}

Map<String, dynamic> _$CustomerPrepayAccountHistoryModelToJson(
        CustomerPrepayAccountHistoryModel instance) =>
    <String, dynamic>{
      'Summary': instance.Summary,
      'UsedType': instance.UsedType,
      'Amount': instance.Amount,
      'Balance': instance.Balance,
      'Message': instance.Message,
      'CreatedOnUtc': instance.CreatedOnUtc,
      'ApprovedStoreCustomerId': instance.ApprovedStoreCustomerId,
      'ApprovedOnUtc': instance.ApprovedOnUtc,
      'ValueAccountUsedType': instance.ValueAccountUsedType,
      'ReferenceOrderId': instance.ReferenceOrderId,
      'OrderShipmentStatus': instance.OrderShipmentStatus,
      'ApprovedBy': instance.ApprovedBy,
      'ExchangeRate': instance.ExchangeRate,
      'OrderAmount': instance.OrderAmount
    };

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) {
  return TopicModel()
    ..SystemName = json['SystemName'] as String
    ..TopicTypeId = json['TopicTypeId'] as int
    ..TopicType = json['TopicType'] as String
    ..Title = json['Title'] as String
    ..Body = json['Body'] as String
    ..MetaTitle = json['MetaTitle'] as String
    ..MetaKeywords = json['MetaKeywords'] as String
    ..MetaDescription = json['MetaDescription'] as String
    ..StoreId = json['StoreId'] as int
    ..IncludeInSitemap = json['IncludeInSitemap'] as bool
    ..IsInHotList = json['IsInHotList'] as bool
    ..TopicAreaId = json['TopicAreaId'] as int;
}

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'SystemName': instance.SystemName,
      'TopicTypeId': instance.TopicTypeId,
      'TopicType': instance.TopicType,
      'Title': instance.Title,
      'Body': instance.Body,
      'MetaTitle': instance.MetaTitle,
      'MetaKeywords': instance.MetaKeywords,
      'MetaDescription': instance.MetaDescription,
      'StoreId': instance.StoreId,
      'IncludeInSitemap': instance.IncludeInSitemap,
      'IsInHotList': instance.IsInHotList,
      'TopicAreaId': instance.TopicAreaId
    };

CustomerRewardPointsResponse _$CustomerRewardPointsResponseFromJson(
    Map<String, dynamic> json) {
  return CustomerRewardPointsResponse()
    ..TotalRedeemablePoints = (json['TotalRedeemablePoints'] as num)?.toDouble()
    ..TotalRedeemablePointsValue =
        (json['TotalRedeemablePointsValue'] as num)?.toDouble()
    ..CurrentPageIndex = json['CurrentPageIndex'] as int
    ..PageSize = json['PageSize'] as int
    ..TotalCount = json['TotalCount'] as int
    ..CustomerRewardPoints = (json['CustomerRewardPoints'] as List)
        ?.map((e) => e == null
            ? null
            : RewardPointsHistoryModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CustomerRewardPointsResponseToJson(
        CustomerRewardPointsResponse instance) =>
    <String, dynamic>{
      'TotalRedeemablePoints': instance.TotalRedeemablePoints,
      'TotalRedeemablePointsValue': instance.TotalRedeemablePointsValue,
      'CurrentPageIndex': instance.CurrentPageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'CustomerRewardPoints': instance.CustomerRewardPoints
    };

RewardPointsHistoryModel _$RewardPointsHistoryModelFromJson(
    Map<String, dynamic> json) {
  return RewardPointsHistoryModel(
      Points: (json['Points'] as num)?.toDouble(),
      Message: json['Message'] as String,
      IsSummary: json['IsSummary'] as bool)
    ..PointsBalance = (json['PointsBalance'] as num)?.toDouble()
    ..UsedAmount = (json['UsedAmount'] as num)?.toDouble()
    ..CreatedOnUtc = json['CreatedOnUtc'] as int;
}

Map<String, dynamic> _$RewardPointsHistoryModelToJson(
        RewardPointsHistoryModel instance) =>
    <String, dynamic>{
      'IsSummary': instance.IsSummary,
      'Points': instance.Points,
      'PointsBalance': instance.PointsBalance,
      'UsedAmount': instance.UsedAmount,
      'Message': instance.Message,
      'CreatedOnUtc': instance.CreatedOnUtc
    };
