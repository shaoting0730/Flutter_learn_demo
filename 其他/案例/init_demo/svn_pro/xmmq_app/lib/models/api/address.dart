class AddressModel {
  bool success;
  String errorCode;
  String errorDesc;
  String message;
  Data data;

  AddressModel(
      {this.success, this.errorCode, this.errorDesc, this.message, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
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
  String guid;
  String storeCustomerGuid;
  int addressType;
  String fullName;
  String addressLine;
  String postCode;
  String town;
  String city;
  String province;
  String phoneNumber;
  int iDCardType;
  String iDCardNumber;
  String country;
  int displayOrder;

  ListObjects(
      {this.guid,
      this.storeCustomerGuid,
      this.addressType,
      this.fullName,
      this.addressLine,
      this.postCode,
      this.town,
      this.city,
      this.province,
      this.phoneNumber,
      this.iDCardType,
      this.iDCardNumber,
      this.country,
      this.displayOrder});

  ListObjects.fromJson(Map<String, dynamic> json) {
    guid = json['Guid'];
    storeCustomerGuid = json['StoreCustomerGuid'];
    addressType = json['AddressType'];
    fullName = json['FullName'];
    addressLine = json['AddressLine'];
    postCode = json['PostCode'];
    town = json['Town'];
    city = json['City'];
    province = json['Province'];
    phoneNumber = json['PhoneNumber'];
    iDCardType = json['IDCardType'];
    iDCardNumber = json['IDCardNumber'];
    country = json['Country'];
    displayOrder = json['DisplayOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Guid'] = this.guid;
    data['StoreCustomerGuid'] = this.storeCustomerGuid;
    data['AddressType'] = this.addressType;
    data['FullName'] = this.fullName;
    data['AddressLine'] = this.addressLine;
    data['PostCode'] = this.postCode;
    data['Town'] = this.town;
    data['City'] = this.city;
    data['Province'] = this.province;
    data['PhoneNumber'] = this.phoneNumber;
    data['IDCardType'] = this.iDCardType;
    data['IDCardNumber'] = this.iDCardNumber;
    data['Country'] = this.country;
    data['DisplayOrder'] = this.displayOrder;
    return data;
  }
}
