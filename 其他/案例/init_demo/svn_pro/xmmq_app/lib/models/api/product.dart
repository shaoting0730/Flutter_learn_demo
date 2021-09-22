import 'package:json_annotation/json_annotation.dart';

/////flutter packages pub run build_runner build  --delete-conflicting-outputs
part 'product.g.dart';

@JsonSerializable()
class DQProductImpageRemoveRequest {
  String ProductGuid;
  String PictureUrl;

  DQProductImpageRemoveRequest();

  factory DQProductImpageRemoveRequest.fromJson(Map<String, dynamic> json) => _$DQProductImpageRemoveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DQProductImpageRemoveRequestToJson(this);
}

@JsonSerializable()
class DQProductTagMapping {
  String ProductGuid;
  List<String> ProductTagList;

  DQProductTagMapping();

  factory DQProductTagMapping.fromJson(Map<String, dynamic> json) => _$DQProductTagMappingFromJson(json);

  Map<String, dynamic> toJson() => _$DQProductTagMappingToJson(this);
}

@JsonSerializable()
class DQProductTagModel {
  String ProductTag;
  int UsedTimes;
  int LastTimeUse;

  DQProductTagModel();

  factory DQProductTagModel.fromJson(Map<String, dynamic> json) => _$DQProductTagModelFromJson(json);

  Map<String, dynamic> toJson() => _$DQProductTagModelToJson(this);
}

@JsonSerializable()
class DQProductModel {
  String Guid;
  String ProductName;
  String Description;
  double Price;
  bool ConfirmPriceRequired;
  bool RangePriceRequired;
  double MinPrice;
  double MaxPrice;
  int Status;
  bool DisplayOnHomePage;
  int DisplayOrder;
  List<String> PictureList;
  List<String> TagList;
  int UpdatedOn;

  DQProductModel();

  factory DQProductModel.fromJson(Map<String, dynamic> json) => _$DQProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$DQProductModelToJson(this);
}

@JsonSerializable()
class AdvertisementModel {
  String Guid;
  String PublishStoreGuid;
  String PublishStoreHost;
  String DisplayStoreGuid;
  String DisplayItemGuid;
  String Description;
  int DisplayType;
  int Status;
  double BidPrice;
  int CreatedOn;

  AdvertisementModel();

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) => _$AdvertisementModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertisementModelToJson(this);
}

@JsonSerializable()
class DQMomentTopicModel {
  String TopicName;
  int UsedTimes;
  int LastTimeUse;

  DQMomentTopicModel();

  factory DQMomentTopicModel.fromJson(Map<String, dynamic> json) => _$DQMomentTopicModelFromJson(json);

  Map<String, dynamic> toJson() => _$DQMomentTopicModelToJson(this);
}

@JsonSerializable()
class DQProductGroupModel {
  String Guid;
  String GroupName;
  String Description;
  int Status;
  int DisplayOrder;
  int UpdatedOn;
  List<DQProductModel> ProductList;
  AdvertisementModel Advertisement;

  DQProductGroupModel();

  factory DQProductGroupModel.fromJson(Map<String, dynamic> json) => _$DQProductGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$DQProductGroupModelToJson(this);
}

@JsonSerializable()
class DQShareRequest {
  String ShareComment;
  List<String> ProductGuidList;

  DQShareRequest();

  factory DQShareRequest.fromJson(Map<String, dynamic> json) => _$DQShareRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DQShareRequestToJson(this);
}

@JsonSerializable()
class ADSearch {
  String PublishStoreGuid;
  String DisplayStoreGuid;
  bool ExcludeSearch;
  int PageIndex;
  int PageSize;

  ADSearch();

  factory ADSearch.fromJson(Map<String, dynamic> json) => _$ADSearchFromJson(json);

  Map<String, dynamic> toJson() => _$ADSearchToJson(this);
}

@JsonSerializable()
class DQSearch {
  List<String> ProductName;
  List<String> ProductGuid;
  List<String> TagList;
  String Keywords;
  String ShareGroupKey;
  int StartTime;
  int EndTime;
  int Status;
  int PageIndex;
  int PageSize;

  DQSearch();

  factory DQSearch.fromJson(Map<String, dynamic> json) => _$DQSearchFromJson(json);

  Map<String, dynamic> toJson() => _$DQSearchToJson(this);
}

@JsonSerializable()
class PagedListDQProductModel {
  int PageIndex;
  int PageSize;
  int TotalCount;
  List<DQProductModel> ListObjects;

  PagedListDQProductModel();

  factory PagedListDQProductModel.fromJson(Map<String, dynamic> json) => _$PagedListDQProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$PagedListDQProductModelToJson(this);
}

@JsonSerializable()
class PagedListDQProductGroupModel {
  int PageIndex;
  int PageSize;
  int TotalCount;
  List<DQProductGroupModel> ListObjects;

  PagedListDQProductGroupModel();

  factory PagedListDQProductGroupModel.fromJson(Map<String, dynamic> json) => _$PagedListDQProductGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$PagedListDQProductGroupModelToJson(this);
}
