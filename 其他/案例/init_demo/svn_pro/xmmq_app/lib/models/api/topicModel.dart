class TopicModel {
  bool success;
  String errorCode;
  String errorDesc;
  String message;
  List<Data> data;

  TopicModel(
      {this.success, this.errorCode, this.errorDesc, this.message, this.data});

  TopicModel.fromJson(Map<String, dynamic> json) {
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
  String topicName;
  int usedTimes;
  int lastTimeUse;

  Data({this.topicName, this.usedTimes, this.lastTimeUse});

  Data.fromJson(Map<String, dynamic> json) {
    topicName = json['TopicName'];
    usedTimes = json['UsedTimes'];
    lastTimeUse = json['LastTimeUse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TopicName'] = this.topicName;
    data['UsedTimes'] = this.usedTimes;
    data['LastTimeUse'] = this.lastTimeUse;
    return data;
  }
}
