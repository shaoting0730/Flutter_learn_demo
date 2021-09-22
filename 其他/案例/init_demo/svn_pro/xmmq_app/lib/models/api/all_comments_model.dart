class AllCommentModel {
  bool success;
  String errorCode;
  String errorDesc;
  String message;
  Data data;

  AllCommentModel(
      {this.success, this.errorCode, this.errorDesc, this.message, this.data});

  AllCommentModel.fromJson(Map<String, dynamic> json) {
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
  String groupGuid;
  String replyToGuid;
  String storeCustomerGuid;
  String storeCustomerHeaderImage;
  String storeCustomerName;
  String content;
  int atTheTop;
  int status;
  Null replies;
  int readFlag;
  int isStoreOwner;
  int createdOn;
  String thumbernail;
  Null replyToStoreCustomerHeaderImage;
  Null replyToStoreCustomerName;

  ListObjects(
      {this.guid,
      this.groupGuid,
      this.replyToGuid,
      this.storeCustomerGuid,
      this.storeCustomerHeaderImage,
      this.storeCustomerName,
      this.content,
      this.atTheTop,
      this.status,
      this.replies,
      this.readFlag,
      this.isStoreOwner,
      this.createdOn,
      this.thumbernail,
      this.replyToStoreCustomerHeaderImage,
      this.replyToStoreCustomerName});

  ListObjects.fromJson(Map<String, dynamic> json) {
    guid = json['Guid'];
    groupGuid = json['GroupGuid'];
    replyToGuid = json['ReplyToGuid'];
    storeCustomerGuid = json['StoreCustomerGuid'];
    storeCustomerHeaderImage = json['StoreCustomerHeaderImage'];
    storeCustomerName = json['StoreCustomerName'];
    content = json['Content'];
    atTheTop = json['AtTheTop'];
    status = json['Status'];
    replies = json['Replies'];
    readFlag = json['ReadFlag'];
    isStoreOwner = json['IsStoreOwner'];
    createdOn = json['CreatedOn'];
    thumbernail = json['Thumbernail'];
    replyToStoreCustomerHeaderImage = json['ReplyToStoreCustomerHeaderImage'];
    replyToStoreCustomerName = json['ReplyToStoreCustomerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Guid'] = this.guid;
    data['GroupGuid'] = this.groupGuid;
    data['ReplyToGuid'] = this.replyToGuid;
    data['StoreCustomerGuid'] = this.storeCustomerGuid;
    data['StoreCustomerHeaderImage'] = this.storeCustomerHeaderImage;
    data['StoreCustomerName'] = this.storeCustomerName;
    data['Content'] = this.content;
    data['AtTheTop'] = this.atTheTop;
    data['Status'] = this.status;
    data['Replies'] = this.replies;
    data['ReadFlag'] = this.readFlag;
    data['IsStoreOwner'] = this.isStoreOwner;
    data['CreatedOn'] = this.createdOn;
    data['Thumbernail'] = this.thumbernail;
    data['ReplyToStoreCustomerHeaderImage'] =
        this.replyToStoreCustomerHeaderImage;
    data['ReplyToStoreCustomerName'] = this.replyToStoreCustomerName;
    return data;
  }
}
