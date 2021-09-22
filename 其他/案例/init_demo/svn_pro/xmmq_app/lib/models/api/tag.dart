class TagModel {
  bool success;
  String errorCode;
  String errorDesc;
  String message;
  List<Data> data;

  TagModel(
      {this.success, this.errorCode, this.errorDesc, this.message, this.data});

  TagModel.fromJson(Map<String, dynamic> json) {
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
  String productTag;
  int usedTimes;
  int lastTimeUse;

  Data({this.productTag, this.usedTimes, this.lastTimeUse});

  Data.fromJson(Map<String, dynamic> json) {
    productTag = json['ProductTag'];
    usedTimes = json['UsedTimes'];
    lastTimeUse = json['LastTimeUse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductTag'] = this.productTag;
    data['UsedTimes'] = this.usedTimes;
    data['LastTimeUse'] = this.lastTimeUse;
    return data;
  }
}
