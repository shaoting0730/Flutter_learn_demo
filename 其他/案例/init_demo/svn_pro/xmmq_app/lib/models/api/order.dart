class OrderModel {
  bool success;
  String errorCode;
  String errorDesc;
  String message;
  Data data;

  OrderModel(
      {this.success, this.errorCode, this.errorDesc, this.message, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    errorCode = json['ErrorCode'];
    errorDesc = json['ErrorDesc'];
    message = json['Message'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['ErrorCode'] = this.errorCode;
    data['ErrorDesc'] = this.errorDesc;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int pageIndex;
  int pageSize;
  int totalCount;
  List<ListObjects> listObjects;

  Data({this.pageIndex, this.pageSize, this.totalCount, this.listObjects});

  Data.fromJson(Map<String, dynamic> json) {
    pageIndex = json['PageIndex'];
    pageSize = json['PageSize'];
    totalCount = json['TotalCount'];
    if (json['ListObjects'] != null) {
      listObjects = new List<ListObjects>();
      json['ListObjects'].forEach((v) {
        listObjects.add(new ListObjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PageIndex'] = this.pageIndex;
    data['PageSize'] = this.pageSize;
    data['TotalCount'] = this.totalCount;
    if (this.listObjects != null) {
      data['ListObjects'] = this.listObjects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListObjects {
  OrderInfo orderInfo;
  List<OrderItems> orderItems;
  List<OrderAttributes> orderAttributes;
  Null orderServiceCharges;

  ListObjects(
      {this.orderInfo,
      this.orderItems,
      this.orderAttributes,
      this.orderServiceCharges});

  ListObjects.fromJson(Map<String, dynamic> json) {
    orderInfo = json['OrderInfo'] != null
        ? new OrderInfo.fromJson(json['OrderInfo'])
        : null;
    if (json['OrderItems'] != null) {
      orderItems = new List<OrderItems>();
      json['OrderItems'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v));
      });
    }
    if (json['OrderAttributes'] != null) {
      orderAttributes = new List<OrderAttributes>();
      json['OrderAttributes'].forEach((v) {
        orderAttributes.add(new OrderAttributes.fromJson(v));
      });
    }
    orderServiceCharges = json['OrderServiceCharges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderInfo != null) {
      data['OrderInfo'] = this.orderInfo.toJson();
    }
    if (this.orderItems != null) {
      data['OrderItems'] = this.orderItems.map((v) => v.toJson()).toList();
    }
    if (this.orderAttributes != null) {
      data['OrderAttributes'] =
          this.orderAttributes.map((v) => v.toJson()).toList();
    }
    data['OrderServiceCharges'] = this.orderServiceCharges;
    return data;
  }
}

class OrderInfo {
  String guid;
  String referenceOrderGuid;
  String orderType;
  String trackingNumber;
  String storeGuid;
  String storeName;
  String warehouse;
  String storeCustomerGuid;
  String billingName;
  String billingCompany;
  String billingAddressLine;
  String billingCity;
  String billingPostcode;
  String billingPhoneNumber;
  String billingProvince;
  String billingCountry;
  String shipFromName;
  String shipFromEmail;
  String shipFromPhone;
  String shipFromAddress;
  String shipFromCity;
  String shipFromProvince;
  String shipFromPostalCode;
  String shipFromCountry;
  String shipToName;
  String shipToAddress;
  String shipToCity;
  String shipToProvince;
  String shipToPostalCode;
  String shipToAreaCode;
  String shipToCountry;
  String shipToIDCardType;
  String shipToIDCardNumber;
  String shipToEmail;
  String shipToPhone;
  int orderStatusId;
  String orderStatus;
  String paymentMethod;
  double currencyRate;
  double orderSubtotal;
  double orderSubTotalDiscount;
  double orderDiscount;
  double orderCouponDiscount;
  String orderCouponCode;
  double orderShipping;
  double orderTotal;
  double refundedAmount;
  double paidByBonus;
  double paidByRewardPoints;
  double rewardPointRedeemRate;
  double orderReceivable;
  String purchaseOrderNumber;
  String packageName;
  int paidDate;
  String paymentGuid;
  bool deleted;
  String notes;
  String subStoreName;
  String platform;
  int createdOn;
  String orderStatusCategory;
  Null orderShippingLabel;
  String virtualVendorGuid;
  String vendorName;
  Null vendorUserName;
  String wechatNickName;
  String wechatThumberUrl;

  OrderInfo(
      {this.guid,
      this.referenceOrderGuid,
      this.orderType,
      this.trackingNumber,
      this.storeGuid,
      this.storeName,
      this.warehouse,
      this.storeCustomerGuid,
      this.billingName,
      this.billingCompany,
      this.billingAddressLine,
      this.billingCity,
      this.billingPostcode,
      this.billingPhoneNumber,
      this.billingProvince,
      this.billingCountry,
      this.shipFromName,
      this.shipFromEmail,
      this.shipFromPhone,
      this.shipFromAddress,
      this.shipFromCity,
      this.shipFromProvince,
      this.shipFromPostalCode,
      this.shipFromCountry,
      this.shipToName,
      this.shipToAddress,
      this.shipToCity,
      this.shipToProvince,
      this.shipToPostalCode,
      this.shipToAreaCode,
      this.shipToCountry,
      this.shipToIDCardType,
      this.shipToIDCardNumber,
      this.shipToEmail,
      this.shipToPhone,
      this.orderStatusId,
      this.orderStatus,
      this.paymentMethod,
      this.currencyRate,
      this.orderSubtotal,
      this.orderSubTotalDiscount,
      this.orderDiscount,
      this.orderCouponDiscount,
      this.orderCouponCode,
      this.orderShipping,
      this.orderTotal,
      this.refundedAmount,
      this.paidByBonus,
      this.paidByRewardPoints,
      this.rewardPointRedeemRate,
      this.orderReceivable,
      this.purchaseOrderNumber,
      this.packageName,
      this.paidDate,
      this.paymentGuid,
      this.deleted,
      this.notes,
      this.subStoreName,
      this.platform,
      this.createdOn,
      this.orderStatusCategory,
      this.orderShippingLabel,
      this.virtualVendorGuid,
      this.vendorName,
      this.vendorUserName,
      this.wechatNickName,
      this.wechatThumberUrl});

  OrderInfo.fromJson(Map<String, dynamic> json) {
    guid = json['Guid'];
    referenceOrderGuid = json['ReferenceOrderGuid'];
    orderType = json['OrderType'];
    trackingNumber = json['TrackingNumber'];
    storeGuid = json['StoreGuid'];
    storeName = json['StoreName'];
    warehouse = json['Warehouse'];
    storeCustomerGuid = json['StoreCustomerGuid'];
    billingName = json['BillingName'];
    billingCompany = json['BillingCompany'];
    billingAddressLine = json['BillingAddressLine'];
    billingCity = json['BillingCity'];
    billingPostcode = json['BillingPostcode'];
    billingPhoneNumber = json['BillingPhoneNumber'];
    billingProvince = json['BillingProvince'];
    billingCountry = json['BillingCountry'];
    shipFromName = json['ShipFromName'];
    shipFromEmail = json['ShipFromEmail'];
    shipFromPhone = json['ShipFromPhone'];
    shipFromAddress = json['ShipFromAddress'];
    shipFromCity = json['ShipFromCity'];
    shipFromProvince = json['ShipFromProvince'];
    shipFromPostalCode = json['ShipFromPostalCode'];
    shipFromCountry = json['ShipFromCountry'];
    shipToName = json['ShipToName'];
    shipToAddress = json['ShipToAddress'];
    shipToCity = json['ShipToCity'];
    shipToProvince = json['ShipToProvince'];
    shipToPostalCode = json['ShipToPostalCode'];
    shipToAreaCode = json['ShipToAreaCode'];
    shipToCountry = json['ShipToCountry'];
    shipToIDCardType = json['ShipToIDCardType'];
    shipToIDCardNumber = json['ShipToIDCardNumber'];
    shipToEmail = json['ShipToEmail'];
    shipToPhone = json['ShipToPhone'];
    orderStatusId = json['OrderStatusId'];
    orderStatus = json['OrderStatus'];
    paymentMethod = json['PaymentMethod'];
    currencyRate = json['CurrencyRate'];
    orderSubtotal = json['OrderSubtotal'];
    orderSubTotalDiscount = json['OrderSubTotalDiscount'];
    orderDiscount = json['OrderDiscount'];
    orderCouponDiscount = json['OrderCouponDiscount'];
    orderCouponCode = json['OrderCouponCode'];
    orderShipping = json['OrderShipping'];
    orderTotal = json['OrderTotal'];
    refundedAmount = json['RefundedAmount'];
    paidByBonus = json['PaidByBonus'];
    paidByRewardPoints = json['PaidByRewardPoints'];
    rewardPointRedeemRate = json['RewardPointRedeemRate'];
    orderReceivable = json['OrderReceivable'];
    purchaseOrderNumber = json['PurchaseOrderNumber'];
    packageName = json['PackageName'];
    paidDate = json['PaidDate'];
    paymentGuid = json['PaymentGuid'];
    deleted = json['Deleted'];
    notes = json['Notes'];
    subStoreName = json['SubStoreName'];
    platform = json['Platform'];
    createdOn = json['CreatedOn'];
    orderStatusCategory = json['OrderStatusCategory'];
    orderShippingLabel = json['OrderShippingLabel'];
    virtualVendorGuid = json['VirtualVendorGuid'];
    vendorName = json['VendorName'];
    vendorUserName = json['VendorUserName'];
    wechatNickName = json['WechatNickName'];
    wechatThumberUrl = json['WechatThumberUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Guid'] = this.guid;
    data['ReferenceOrderGuid'] = this.referenceOrderGuid;
    data['OrderType'] = this.orderType;
    data['TrackingNumber'] = this.trackingNumber;
    data['StoreGuid'] = this.storeGuid;
    data['StoreName'] = this.storeName;
    data['Warehouse'] = this.warehouse;
    data['StoreCustomerGuid'] = this.storeCustomerGuid;
    data['BillingName'] = this.billingName;
    data['BillingCompany'] = this.billingCompany;
    data['BillingAddressLine'] = this.billingAddressLine;
    data['BillingCity'] = this.billingCity;
    data['BillingPostcode'] = this.billingPostcode;
    data['BillingPhoneNumber'] = this.billingPhoneNumber;
    data['BillingProvince'] = this.billingProvince;
    data['BillingCountry'] = this.billingCountry;
    data['ShipFromName'] = this.shipFromName;
    data['ShipFromEmail'] = this.shipFromEmail;
    data['ShipFromPhone'] = this.shipFromPhone;
    data['ShipFromAddress'] = this.shipFromAddress;
    data['ShipFromCity'] = this.shipFromCity;
    data['ShipFromProvince'] = this.shipFromProvince;
    data['ShipFromPostalCode'] = this.shipFromPostalCode;
    data['ShipFromCountry'] = this.shipFromCountry;
    data['ShipToName'] = this.shipToName;
    data['ShipToAddress'] = this.shipToAddress;
    data['ShipToCity'] = this.shipToCity;
    data['ShipToProvince'] = this.shipToProvince;
    data['ShipToPostalCode'] = this.shipToPostalCode;
    data['ShipToAreaCode'] = this.shipToAreaCode;
    data['ShipToCountry'] = this.shipToCountry;
    data['ShipToIDCardType'] = this.shipToIDCardType;
    data['ShipToIDCardNumber'] = this.shipToIDCardNumber;
    data['ShipToEmail'] = this.shipToEmail;
    data['ShipToPhone'] = this.shipToPhone;
    data['OrderStatusId'] = this.orderStatusId;
    data['OrderStatus'] = this.orderStatus;
    data['PaymentMethod'] = this.paymentMethod;
    data['CurrencyRate'] = this.currencyRate;
    data['OrderSubtotal'] = this.orderSubtotal;
    data['OrderSubTotalDiscount'] = this.orderSubTotalDiscount;
    data['OrderDiscount'] = this.orderDiscount;
    data['OrderCouponDiscount'] = this.orderCouponDiscount;
    data['OrderCouponCode'] = this.orderCouponCode;
    data['OrderShipping'] = this.orderShipping;
    data['OrderTotal'] = this.orderTotal;
    data['RefundedAmount'] = this.refundedAmount;
    data['PaidByBonus'] = this.paidByBonus;
    data['PaidByRewardPoints'] = this.paidByRewardPoints;
    data['RewardPointRedeemRate'] = this.rewardPointRedeemRate;
    data['OrderReceivable'] = this.orderReceivable;
    data['PurchaseOrderNumber'] = this.purchaseOrderNumber;
    data['PackageName'] = this.packageName;
    data['PaidDate'] = this.paidDate;
    data['PaymentGuid'] = this.paymentGuid;
    data['Deleted'] = this.deleted;
    data['Notes'] = this.notes;
    data['SubStoreName'] = this.subStoreName;
    data['Platform'] = this.platform;
    data['CreatedOn'] = this.createdOn;
    data['OrderStatusCategory'] = this.orderStatusCategory;
    data['OrderShippingLabel'] = this.orderShippingLabel;
    data['VirtualVendorGuid'] = this.virtualVendorGuid;
    data['VendorName'] = this.vendorName;
    data['VendorUserName'] = this.vendorUserName;
    data['WechatNickName'] = this.wechatNickName;
    data['WechatThumberUrl'] = this.wechatThumberUrl;
    return data;
  }
}

class OrderItems {
  String guid;
  String orderGuid;
  String vendorOrderNumber;
  String productCode;
  String productVariantGuid;
  String productVariantName;
  String productImageUrl;
  int statusId;
  double unitPrice;
  double productCost;
  double productUnitTax;
  double productAddon;
  int quantity;
  double discountAmount;
  double subTotal;
  double itemWeight;
  String userComment;
  String shoppingWebsite;
  String vendorProductGuid;

  OrderItems(
      {this.guid,
      this.orderGuid,
      this.vendorOrderNumber,
      this.productCode,
      this.productVariantGuid,
      this.productVariantName,
      this.productImageUrl,
      this.statusId,
      this.unitPrice,
      this.productCost,
      this.productUnitTax,
      this.productAddon,
      this.quantity,
      this.discountAmount,
      this.subTotal,
      this.itemWeight,
      this.userComment,
      this.shoppingWebsite,
      this.vendorProductGuid});

  OrderItems.fromJson(Map<String, dynamic> json) {
    guid = json['Guid'];
    orderGuid = json['OrderGuid'];
    vendorOrderNumber = json['VendorOrderNumber'];
    productCode = json['ProductCode'];
    productVariantGuid = json['ProductVariantGuid'];
    productVariantName = json['ProductVariantName'];
    productImageUrl = json['ProductImageUrl'];
    statusId = json['StatusId'];
    unitPrice = json['UnitPrice'];
    productCost = json['ProductCost'];
    productUnitTax = json['ProductUnitTax'];
    productAddon = json['ProductAddon'];
    quantity = json['Quantity'];
    discountAmount = json['DiscountAmount'];
    subTotal = json['SubTotal'];
    itemWeight = json['ItemWeight'];
    userComment = json['UserComment'];
    shoppingWebsite = json['ShoppingWebsite'];
    vendorProductGuid = json['VendorProductGuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Guid'] = this.guid;
    data['OrderGuid'] = this.orderGuid;
    data['VendorOrderNumber'] = this.vendorOrderNumber;
    data['ProductCode'] = this.productCode;
    data['ProductVariantGuid'] = this.productVariantGuid;
    data['ProductVariantName'] = this.productVariantName;
    data['ProductImageUrl'] = this.productImageUrl;
    data['StatusId'] = this.statusId;
    data['UnitPrice'] = this.unitPrice;
    data['ProductCost'] = this.productCost;
    data['ProductUnitTax'] = this.productUnitTax;
    data['ProductAddon'] = this.productAddon;
    data['Quantity'] = this.quantity;
    data['DiscountAmount'] = this.discountAmount;
    data['SubTotal'] = this.subTotal;
    data['ItemWeight'] = this.itemWeight;
    data['UserComment'] = this.userComment;
    data['ShoppingWebsite'] = this.shoppingWebsite;
    data['VendorProductGuid'] = this.vendorProductGuid;
    return data;
  }
}

class OrderAttributes {
  String guid;
  String orderGuid;
  String noteName;
  String noteValue;
  bool displayToCustomer;
  String memo;

  OrderAttributes(
      {this.guid,
      this.orderGuid,
      this.noteName,
      this.noteValue,
      this.displayToCustomer,
      this.memo});

  OrderAttributes.fromJson(Map<String, dynamic> json) {
    guid = json['Guid'];
    orderGuid = json['OrderGuid'];
    noteName = json['NoteName'];
    noteValue = json['NoteValue'];
    displayToCustomer = json['DisplayToCustomer'];
    memo = json['Memo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Guid'] = this.guid;
    data['OrderGuid'] = this.orderGuid;
    data['NoteName'] = this.noteName;
    data['NoteValue'] = this.noteValue;
    data['DisplayToCustomer'] = this.displayToCustomer;
    data['Memo'] = this.memo;
    return data;
  }
}
