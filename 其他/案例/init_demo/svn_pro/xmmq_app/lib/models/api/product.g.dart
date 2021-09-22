// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DQProductImpageRemoveRequest _$DQProductImpageRemoveRequestFromJson(
    Map<String, dynamic> json) {
  return DQProductImpageRemoveRequest()
    ..ProductGuid = json['ProductGuid'] as String
    ..PictureUrl = json['PictureUrl'] as String;
}

Map<String, dynamic> _$DQProductImpageRemoveRequestToJson(
        DQProductImpageRemoveRequest instance) =>
    <String, dynamic>{
      'ProductGuid': instance.ProductGuid,
      'PictureUrl': instance.PictureUrl,
    };

DQProductTagMapping _$DQProductTagMappingFromJson(Map<String, dynamic> json) {
  return DQProductTagMapping()
    ..ProductGuid = json['ProductGuid'] as String
    ..ProductTagList =
        (json['ProductTagList'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$DQProductTagMappingToJson(
        DQProductTagMapping instance) =>
    <String, dynamic>{
      'ProductGuid': instance.ProductGuid,
      'ProductTagList': instance.ProductTagList,
    };

DQProductTagModel _$DQProductTagModelFromJson(Map<String, dynamic> json) {
  return DQProductTagModel()
    ..ProductTag = json['ProductTag'] as String
    ..UsedTimes = json['UsedTimes'] as int
    ..LastTimeUse = json['LastTimeUse'] as int;
}

Map<String, dynamic> _$DQProductTagModelToJson(DQProductTagModel instance) =>
    <String, dynamic>{
      'ProductTag': instance.ProductTag,
      'UsedTimes': instance.UsedTimes,
      'LastTimeUse': instance.LastTimeUse,
    };

DQProductModel _$DQProductModelFromJson(Map<String, dynamic> json) {
  return DQProductModel()
    ..Guid = json['Guid'] as String
    ..ProductName = json['ProductName'] as String
    ..Description = json['Description'] as String
    ..Price = (json['Price'] as num)?.toDouble()
    ..ConfirmPriceRequired = json['ConfirmPriceRequired'] as bool
    ..RangePriceRequired = json['RangePriceRequired'] as bool
    ..MinPrice = (json['MinPrice'] as num)?.toDouble()
    ..MaxPrice = (json['MaxPrice'] as num)?.toDouble()
    ..Status = json['Status'] as int
    ..DisplayOnHomePage = json['DisplayOnHomePage'] as bool
    ..DisplayOrder = json['DisplayOrder'] as int
    ..PictureList =
        (json['PictureList'] as List)?.map((e) => e as String)?.toList()
    ..TagList = (json['TagList'] as List)?.map((e) => e as String)?.toList()
    ..UpdatedOn = json['UpdatedOn'] as int;
}

Map<String, dynamic> _$DQProductModelToJson(DQProductModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'ProductName': instance.ProductName,
      'Description': instance.Description,
      'Price': instance.Price,
      'ConfirmPriceRequired': instance.ConfirmPriceRequired,
      'RangePriceRequired': instance.RangePriceRequired,
      'MinPrice': instance.MinPrice,
      'MaxPrice': instance.MaxPrice,
      'Status': instance.Status,
      'DisplayOnHomePage': instance.DisplayOnHomePage,
      'DisplayOrder': instance.DisplayOrder,
      'PictureList': instance.PictureList,
      'TagList': instance.TagList,
      'UpdatedOn': instance.UpdatedOn,
    };

AdvertisementModel _$AdvertisementModelFromJson(Map<String, dynamic> json) {
  return AdvertisementModel()
    ..Guid = json['Guid'] as String
    ..PublishStoreGuid = json['PublishStoreGuid'] as String
    ..PublishStoreHost = json['PublishStoreHost'] as String
    ..DisplayStoreGuid = json['DisplayStoreGuid'] as String
    ..DisplayItemGuid = json['DisplayItemGuid'] as String
    ..Description = json['Description'] as String
    ..DisplayType = json['DisplayType'] as int
    ..Status = json['Status'] as int
    ..BidPrice = (json['BidPrice'] as num)?.toDouble()
    ..CreatedOn = json['CreatedOn'] as int;
}

Map<String, dynamic> _$AdvertisementModelToJson(AdvertisementModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'PublishStoreGuid': instance.PublishStoreGuid,
      'PublishStoreHost': instance.PublishStoreHost,
      'DisplayStoreGuid': instance.DisplayStoreGuid,
      'DisplayItemGuid': instance.DisplayItemGuid,
      'Description': instance.Description,
      'DisplayType': instance.DisplayType,
      'Status': instance.Status,
      'BidPrice': instance.BidPrice,
      'CreatedOn': instance.CreatedOn,
    };

DQMomentTopicModel _$DQMomentTopicModelFromJson(Map<String, dynamic> json) {
  return DQMomentTopicModel()
    ..TopicName = json['TopicName'] as String
    ..UsedTimes = json['UsedTimes'] as int
    ..LastTimeUse = json['LastTimeUse'] as int;
}

Map<String, dynamic> _$DQMomentTopicModelToJson(DQMomentTopicModel instance) =>
    <String, dynamic>{
      'TopicName': instance.TopicName,
      'UsedTimes': instance.UsedTimes,
      'LastTimeUse': instance.LastTimeUse,
    };

DQProductGroupModel _$DQProductGroupModelFromJson(Map<String, dynamic> json) {
  return DQProductGroupModel()
    ..Guid = json['Guid'] as String
    ..GroupName = json['GroupName'] as String
    ..Description = json['Description'] as String
    ..Status = json['Status'] as int
    ..DisplayOrder = json['DisplayOrder'] as int
    ..UpdatedOn = json['UpdatedOn'] as int
    ..ProductList = (json['ProductList'] as List)
        ?.map((e) => e == null
            ? null
            : DQProductModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..Advertisement = json['Advertisement'] == null
        ? null
        : AdvertisementModel.fromJson(
            json['Advertisement'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DQProductGroupModelToJson(
        DQProductGroupModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'GroupName': instance.GroupName,
      'Description': instance.Description,
      'Status': instance.Status,
      'DisplayOrder': instance.DisplayOrder,
      'UpdatedOn': instance.UpdatedOn,
      'ProductList': instance.ProductList,
      'Advertisement': instance.Advertisement,
    };

DQShareRequest _$DQShareRequestFromJson(Map<String, dynamic> json) {
  return DQShareRequest()
    ..ShareComment = json['ShareComment'] as String
    ..ProductGuidList =
        (json['ProductGuidList'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$DQShareRequestToJson(DQShareRequest instance) =>
    <String, dynamic>{
      'ShareComment': instance.ShareComment,
      'ProductGuidList': instance.ProductGuidList,
    };

ADSearch _$ADSearchFromJson(Map<String, dynamic> json) {
  return ADSearch()
    ..PublishStoreGuid = json['PublishStoreGuid'] as String
    ..DisplayStoreGuid = json['DisplayStoreGuid'] as String
    ..ExcludeSearch = json['ExcludeSearch'] as bool
    ..PageIndex = json['PageIndex'] as int
    ..PageSize = json['PageSize'] as int;
}

Map<String, dynamic> _$ADSearchToJson(ADSearch instance) => <String, dynamic>{
      'PublishStoreGuid': instance.PublishStoreGuid,
      'DisplayStoreGuid': instance.DisplayStoreGuid,
      'ExcludeSearch': instance.ExcludeSearch,
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
    };

DQSearch _$DQSearchFromJson(Map<String, dynamic> json) {
  return DQSearch()
    ..ProductName =
        (json['ProductName'] as List)?.map((e) => e as String)?.toList()
    ..ProductGuid =
        (json['ProductGuid'] as List)?.map((e) => e as String)?.toList()
    ..TagList = (json['TagList'] as List)?.map((e) => e as String)?.toList()
    ..Keywords = json['Keywords'] as String
    ..ShareGroupKey = json['ShareGroupKey'] as String
    ..StartTime = json['StartTime'] as int
    ..EndTime = json['EndTime'] as int
    ..Status = json['Status'] as int
    ..PageIndex = json['PageIndex'] as int
    ..PageSize = json['PageSize'] as int;
}

Map<String, dynamic> _$DQSearchToJson(DQSearch instance) => <String, dynamic>{
      'ProductName': instance.ProductName,
      'ProductGuid': instance.ProductGuid,
      'TagList': instance.TagList,
      'Keywords': instance.Keywords,
      'ShareGroupKey': instance.ShareGroupKey,
      'StartTime': instance.StartTime,
      'EndTime': instance.EndTime,
      'Status': instance.Status,
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
    };

PagedListDQProductModel _$PagedListDQProductModelFromJson(
    Map<String, dynamic> json) {
  return PagedListDQProductModel()
    ..PageIndex = json['PageIndex'] as int
    ..PageSize = json['PageSize'] as int
    ..TotalCount = json['TotalCount'] as int
    ..ListObjects = (json['ListObjects'] as List)
        ?.map((e) => e == null
            ? null
            : DQProductModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PagedListDQProductModelToJson(
        PagedListDQProductModel instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects,
    };

PagedListDQProductGroupModel _$PagedListDQProductGroupModelFromJson(
    Map<String, dynamic> json) {
  return PagedListDQProductGroupModel()
    ..PageIndex = json['PageIndex'] as int
    ..PageSize = json['PageSize'] as int
    ..TotalCount = json['TotalCount'] as int
    ..ListObjects = (json['ListObjects'] as List)
        ?.map((e) => e == null
            ? null
            : DQProductGroupModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PagedListDQProductGroupModelToJson(
        PagedListDQProductGroupModel instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects,
    };
