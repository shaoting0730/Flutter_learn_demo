class SupplierProductModel {
  bool success;
  String errorCode;
  String errorDesc;
  String message;
  Data data;

  SupplierProductModel(
      {this.success, this.errorCode, this.errorDesc, this.message, this.data});

  SupplierProductModel.fromJson(Map<String, dynamic> json) {
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
  String vendorGuid;
  String vendorCategoryGuid;
  String productCode;
  String productName;
  double vendorPrice;
  String productDescription;
  List<String> pictureList;
  String videoUrl;

  ListObjects(
      {this.guid,
      this.vendorGuid,
      this.vendorCategoryGuid,
      this.productCode,
      this.productName,
      this.vendorPrice,
      this.productDescription,
      this.pictureList,
      this.videoUrl});

  ListObjects.fromJson(Map<String, dynamic> json) {
    guid = json['Guid'];
    vendorGuid = json['VendorGuid'];
    vendorCategoryGuid = json['VendorCategoryGuid'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    vendorPrice = json['VendorPrice'];
    productDescription = json['ProductDescription'];
    pictureList = json['PictureList'].cast<String>();
    videoUrl = json['VideoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Guid'] = this.guid;
    data['VendorGuid'] = this.vendorGuid;
    data['VendorCategoryGuid'] = this.vendorCategoryGuid;
    data['ProductCode'] = this.productCode;
    data['ProductName'] = this.productName;
    data['VendorPrice'] = this.vendorPrice;
    data['ProductDescription'] = this.productDescription;
    data['PictureList'] = this.pictureList;
    data['VideoUrl'] = this.videoUrl;
    return data;
  }
}
