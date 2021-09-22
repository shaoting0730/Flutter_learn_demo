class VendorsModel {
  bool success;
  String errorCode;
  String errorDesc;
  String message;
  List<Data> data;

  VendorsModel(
      {this.success, this.errorCode, this.errorDesc, this.message, this.data});

  VendorsModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    errorCode = json['ErrorCode'];
    errorDesc = json['ErrorDesc'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['ErrorCode'] = this.errorCode;
    data['ErrorDesc'] = this.errorDesc;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String guid;
  String vendorCode;
  String vendorName;
  int vendorType;
  String aPIToken;
  String description;
  String vendorLogoUrl;

  Data(
      {this.guid,
      this.vendorCode,
      this.vendorName,
      this.vendorType,
      this.aPIToken,
      this.description,
      this.vendorLogoUrl});

  Data.fromJson(Map<String, dynamic> json) {
    guid = json['Guid'];
    vendorCode = json['VendorCode'];
    vendorName = json['VendorName'];
    vendorType = json['VendorType'];
    aPIToken = json['APIToken'];
    description = json['Description'];
    vendorLogoUrl = json['VendorLogoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Guid'] = this.guid;
    data['VendorCode'] = this.vendorCode;
    data['VendorName'] = this.vendorName;
    data['VendorType'] = this.vendorType;
    data['APIToken'] = this.aPIToken;
    data['Description'] = this.description;
    data['VendorLogoUrl'] = this.vendorLogoUrl;
    return data;
  }
}
