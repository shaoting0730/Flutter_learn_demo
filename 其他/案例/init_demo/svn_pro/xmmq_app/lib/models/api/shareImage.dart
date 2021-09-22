class ShareImageModel {
  bool success;
  String errorCode;
  String errorDesc;
  String message;
  Data data;

  ShareImageModel(
      {this.success, this.errorCode, this.errorDesc, this.message, this.data});

  ShareImageModel.fromJson(Map<String, dynamic> json) {
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
  String imageUrl;
  String shareGuid;

  Data({this.imageUrl, this.shareGuid});

  Data.fromJson(Map<String, dynamic> json) {
    imageUrl = json['ImageUrl'];
    shareGuid = json['ShareGuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImageUrl'] = this.imageUrl;
    data['ShareGuid'] = this.shareGuid;
    return data;
  }
}
