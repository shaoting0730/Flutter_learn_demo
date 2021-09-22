import 'package:json_annotation/json_annotation.dart';
/////flutter packages pub run build_runner build  --delete-conflicting-outputs

part 'loginmodel.g.dart';

// ignore_for_file: non_constant_identifier_names

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
  String MembershipLevel;
  List<PermissionRecordModel> Permissions;

  LoginResponseModel();

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class CustomerModel {
  CustomerModel();
  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  int StoreId;
  String Username;
  String Email;
  String FullName;
  String FirstName;
  String LastName;
  String PhoneNumber;
  bool PhoneNumberValidated;
  bool Newsletter;
  double AccountBalance;
  double RewardPoints;
  double RemainingRedBonus;
  bool IsSystemAccount;
  String SystemName;
  String CustomerUniqueCode;
  String LastIpAddress;
  int LastLoginDateUtc;
  bool IsTurnOnRewardPoints;
  bool IsEligibleForPromotion;
  int LastActivityDateUtc;
  int RegisterOnUtc;
  String PaymentMethod;
  String Discounts4Dispay;
  String Company;
  String CompanyWeb;
  String Country;
  String SalesPerson;
  String CustomerManager;
  String Email4Orders;
  double MinAmount4Deposit;
  String WechatNickName;
  String AcquireFrom;
  String CompanyFollowUpStatus;
  String Abbreviation;
  String Wechat; // 微信号
  String QQ; // qq号
  String CompanyAddress; // 公司地址
  String SalesModel; // 销售模式
  String OperationCapability; // 运营能力
  String CustomerComments; // 介绍
  String AutoFill;
  int MembershipId;
  String MembershipLevel;
  int ReferredByStoreCustomerId;
}

@JsonSerializable()
class AimRevenueModel {
  bool Success;
  double Today;
  double Month;
  double All;

  AimRevenueModel();

  factory AimRevenueModel.fromJson(Map<String, dynamic> json) =>
      _$AimRevenueModelFromJson(json);

  Map<String, dynamic> toJson() => _$AimRevenueModelToJson(this);
}

@JsonSerializable()
class NotifySummaryModel {
  int unread;

  NotifySummaryModel();

  factory NotifySummaryModel.fromJson(Map<String, dynamic> json) =>
      _$NotifySummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotifySummaryModelToJson(this);
}

@JsonSerializable()
class NotifyListItemModel {
  int StoreCustomerId;
  String Subject;
  String Body;
  DateTime CreatedOnUtc;
  int Status; // -1：删除，0：未读，1：已读

  NotifyListItemModel();

  factory NotifyListItemModel.fromJson(Map<String, dynamic> json) =>
      _$NotifyListItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyListItemModelToJson(this);
}

@JsonSerializable()
class AffiliateSummaryModel {
  int AffiliateStoreCustomerId;
  String AffiliateUsername;
  String AffiliateCompany;
  String AffiliateEmail;
  DateTime CreatedOnUtc;

  int AffiliateDate;
  double AffiliateAmount;
  String MembershipLevel;
  int AffiliatePoint;
  Map<String, int> MyAffiliates;

  AffiliateSummaryModel();

  factory AffiliateSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$AffiliateSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$AffiliateSummaryModelToJson(this);
}

@JsonSerializable()
class OrderResponse {
  OrderResponse();

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);

  int CurrentPageIndex;
  int PageSize;
  int TotalCount;
  double TotalAmount;
  double TotalPaidAmount;
  double AccountBalance;
  double PaidByRewardPoints;
  double TotalAvailableRewardPoints;
  double TotalRewardPointsAmount;

  List<OrderModel> Orders;
}

@JsonSerializable()
class OrderModel {
  OrderModel();

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  List<OrderNoteModel> OrderNotes;
  List<OrderItemModel> OrderProduct;

//List<ShipmentDetailsModel> Shipments ;
//Map<String, List<OrderShipmentProductModel>> ShipmentProducts ;
//List<OrderServiceChargeModel> ServiceChargeList ;
//List<OrderShipmentStatusModel> AvailableOrderStatus ;
  List<String> OrderPhotos;
  List<String> OrderOperations;
  int PhotoTakeTime;
  String ReferenceOrderId;
  int OrderTypeId;
  String TrackingNumber;
  int StoreId;
  int StoreCustomerId;
  String CustomerUserName;
  String MembershipLevel;
  String CustomerUniqueId;
  String BillingName;
  String BillingCompany;
  String BillingAddressLine;
  String BillingCity;
  String BillingPostcode;
  String BillingPhoneNumber;
  String BillingProvince;
  String BillingCountry;
  String ShipFromName;
  String ShipFromEmail;
  String ShipFromPhone;
  String ShipFromCellPhone;
  String ShipFromAddress;
  String ShipFromAddress2;
  String ShipFromAddress3;
  String ShipFromCity;
  String ShipFromProvince;
  String ShipFromPostalCode;
  String ShipFromCountry;
  String ShipToName;
  String ShipToAddress;

//String ShipToAddress2 ;
//String ShipToAddress3 ;
  String ShipToCity;
  String ShipToProvince;
  String ShipToPostalCode;
  String ShipToAreaCode;
  String ShipToTownReadonly;
  int ShipToProvinceId;
  String ShipToCountry;
  int ShipToIDCardType;
  String ShipToIDCardNumber;
  String ShipToQQ;
  String ShipToWechat;
  String ShipToEmail;
  String ShipToPhone;
  String ShipToCellPhone;
  int OrderStatusId;
  int ShippingStatusId;
  String PaymentMethodSystemName;
  String CustomerCurrencyCode;
  double CurrencyRate;
  double OrderTotalTax;
  double OrderSubtotal;
  double AimOrderWithdraw;
  double AimOrderCommission;
  double OrderSubTotalDiscount;
  double OrderDiscount;
  double OrderCouponDiscount;
  String OrderCouponCode;
  double OrderShipping;
  double OrderShippingDiscount;
  double PaymentMethodAdditionalFeeInclTax;
  double OrderChargableWeight;
  double OrderTotal;
  double PaidByBonus;
  double PaidByRewardPoints;
  double UsedRewardPoints;
  double RewardPointRedeemRate;
  double OrderReceivable;
  double RefundedAmount;
  int RewardPoints;
  bool RewardPointsWereAdded;
  int CustomerLanguageId;
  String CustomerIp;
  String PurchaseOrderNumber;
  String PackageName;
  int PaidDateUtc;
  int ServiceProviderId;
  String ServiceProvider;
  String WarehouseLocation;
  String ShippingRateComputationMethodSystemName;
  int CreatedOnUtc;
  String Notes;
  String Message;
  String PackageLocation;
  String PackingInstruction;
  String SunBlogId;
  String EncryptedAddress;
  String EncryptedPostCode;
  String EncryptedPhoneNumber;
  String EncryptedIDCardNumber;
  String EncryptedEmail;
  String Platform;
  String SubStoreName;
  bool DisableHKESelection;
  bool DisableOrderMerge;
  double ProductTaxTotal;
  String GiftCard;

// =========== 从PaymentHistory里面来的数据 ===========
  double PaidAmount;
  String PaymentCurrency;
  String PaymentResponse;
// ===================================================
//bonded 保税字段
//ProductOrderBondedInfo BondedInfo ; //是否保税
}

@JsonSerializable()
class OrderItemModel {
  OrderItemModel();

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  String OrderItemGuid;
  String ProductGuid;
  int OrderId;
  int CategoryId;
  int SubCategoryId;
  int ProductId;
  int AttributeComboId;
  int Quantity;
  int StatusId;
  double UnitPrice;
  double OldPrice;
  double SubTotal;
  double DiscountAmount;
  double ItemWeight;
  String UserComment;
  String ProductName;
  String ProductImageUrl;
  String VendorOrderNumber;
  bool Received;
  String ShoppingWebsite;
  String OverseaLogistic;
  String OverseaTrackingNumber;
  int ClaimedQuantity;
  int ProcessedQuantity;
  String ItemType;
  String CategoryName;
  double ShippingWeight;
  String ProductBarcode;
  String ProductNumber;
  String ProductSKU;
  String ProductEnglishName;
  double ProductTax;
  bool IsSingleShipment;
  int BrandId;
  int LimitPerOrder;
  int MinimumPerOrder;
  bool ProductRegistered;
  double ProductUnitTax;
  bool Published;
  bool DisableBuyButton;
  String VendorCode;
  double ProductCost;
  bool IsInWarehouse;
  bool IsOutOfStore;
  int GiftCardTypeId;

//to map SOOrderItemModel
  double ProductPurchaseCost;
  double WholesalePrice1;
  int WholesaleLimit1;
  double WholesalePrice2;
  int WholesaleLimit2;
  double WholesalePrice3;
  int WholesaleLimit3;
  int WarehouseType;
  double CustomUnitPrice; //商家商品RMB销售单价
  int CustomUnitPriceType; //实际销售单价的类型:1:包邮包税,2:包邮不包税,3:不包邮包税,4:不包邮不包税,
//POOrderItemModel POOrderItem ;
}

@JsonSerializable()
class OrderNoteModel {
  OrderNoteModel();

  factory OrderNoteModel.fromJson(Map<String, dynamic> json) =>
      _$OrderNoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderNoteModelToJson(this);

  int OrderId;
  String NoteName;
  String NoteValue;
  int OrderStatusId;
  bool DisplayToCustomer;
  int CreatedOnUtc;
  String CreatedBy;
}

@JsonSerializable()
class CustomerPrepayAccountHistoryList {
  CustomerPrepayAccountHistoryList();

  factory CustomerPrepayAccountHistoryList.fromJson(
          Map<String, dynamic> json) =>
      _$CustomerPrepayAccountHistoryListFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CustomerPrepayAccountHistoryListToJson(this);

  double AccountBalance;
  double WithdrawalBalance;
  PageListResponse<CustomerPrepayAccountHistoryModel> AccountHistory;
}

T _dataFromJsonCustomerPrepayAccountHistoryModel<T, S, U>(List input,
        [S other1, U other2]) =>
    input.map((o) => CustomerPrepayAccountHistoryModel.fromJson(o)).toList()
        as T;

List<T> _dataToJson<T, S, U>(List<dynamic> input, [S other1, U other2]) =>
    input as List<T>;

@JsonSerializable()
class PageListResponse<T> {
  PageListResponse();

  factory PageListResponse.fromJson(Map<String, dynamic> json) =>
      _$PageListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageListResponseToJson(this);

  int CurrentPageIndex;
  int PageSize;
  int TotalCount;

  @JsonKey(
      fromJson: _dataFromJsonCustomerPrepayAccountHistoryModel,
      toJson: _dataToJson)
  List<T> ListObjects;
}

@JsonSerializable()
class CustomerPrepayAccountHistoryModel {
  CustomerPrepayAccountHistoryModel({this.Amount, this.Summary});

  factory CustomerPrepayAccountHistoryModel.fromJson(
          Map<String, dynamic> json) =>
      _$CustomerPrepayAccountHistoryModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CustomerPrepayAccountHistoryModelToJson(this);

  String Summary;
  int UsedType;
  double Amount;
  double Balance;
  String Message;
  int CreatedOnUtc;
  int ApprovedStoreCustomerId;
  int ApprovedOnUtc;
  String ValueAccountUsedType;
  String ReferenceOrderId;
  String OrderShipmentStatus;
  String ApprovedBy;
  double ExchangeRate;
  double OrderAmount;
}

@JsonSerializable()
class TopicModel {
  TopicModel();
  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicModelToJson(this);

  String SystemName;
  int TopicTypeId;
  String TopicType;
  String Title;
  String Body;
  String MetaTitle;
  String MetaKeywords;
  String MetaDescription;
  int StoreId;

  bool IncludeInSitemap;
  bool IsInHotList;
  int TopicAreaId;
}

@JsonSerializable()
class CustomerRewardPointsResponse {
  CustomerRewardPointsResponse();

  factory CustomerRewardPointsResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerRewardPointsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRewardPointsResponseToJson(this);

  double TotalRedeemablePoints;
  double TotalRedeemablePointsValue;
  int CurrentPageIndex;
  int PageSize;
  int TotalCount;
  List<RewardPointsHistoryModel> CustomerRewardPoints;
}

@JsonSerializable()
class RewardPointsHistoryModel {
  RewardPointsHistoryModel({this.Points, this.Message, this.IsSummary = false});

  factory RewardPointsHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$RewardPointsHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$RewardPointsHistoryModelToJson(this);

  bool IsSummary;
  double Points;
  double PointsBalance;
  double UsedAmount;
  String Message;
  int CreatedOnUtc;
}
