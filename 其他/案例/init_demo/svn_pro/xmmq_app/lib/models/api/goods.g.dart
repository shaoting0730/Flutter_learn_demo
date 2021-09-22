// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsModel _$GoodsModelFromJson(Map<String, dynamic> json) {
  return GoodsModel()
    ..PageIndex = json['PageIndex'] as int
    ..PageSize = json['PageSize'] as int
    ..TotalCount = json['TotalCount'] as int
    ..ListObjects = (json['ListObjects'] as List)
        ?.map((e) => e == null
            ? null
            : ListObjectsGoodsModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GoodsModelToJson(GoodsModel instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects,
    };

ListObjectsGoodsModel _$ListObjectsGoodsModelFromJson(
    Map<String, dynamic> json) {
  return ListObjectsGoodsModel()
    ..Guid = json['Guid'] as String
    ..StoreGuid = json['StoreGuid'] as String
    ..VendorGuid = json['VendorGuid'] as String
    ..FactoryVendorGuid = json['FactoryVendorGuid'] as String
    ..ProductName = json['ProductName'] as String
    ..Description = json['Description'] as String
    ..VendorProductGuid = json['VendorProductGuid'] as String
    ..Price = (json['Price'] as num)?.toDouble()
    ..ConfirmPriceRequired = json['ConfirmPriceRequired'] as bool
    ..RangePriceRequired = json['RangePriceRequired'] as bool
    ..MinPrice = (json['MinPrice'] as num)?.toDouble()
    ..MaxPrice = (json['MaxPrice'] as num)?.toDouble()
    ..Status = json['Status'] as int
    ..DisplayOnHomePage = json['DisplayOnHomePage'] as bool
    ..DisplayOrder = json['DisplayOrder'] as int
    ..PictureList = json['PictureList'] as List
    ..VideoUrl = json['VideoUrl'] as String
    ..TagList = json['TagList'] as List
    ..UpdatedOn = json['UpdatedOn'] as int;
}

Map<String, dynamic> _$ListObjectsGoodsModelToJson(
        ListObjectsGoodsModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'StoreGuid': instance.StoreGuid,
      'VendorGuid': instance.VendorGuid,
      'FactoryVendorGuid': instance.FactoryVendorGuid,
      'ProductName': instance.ProductName,
      'Description': instance.Description,
      'VendorProductGuid': instance.VendorProductGuid,
      'Price': instance.Price,
      'ConfirmPriceRequired': instance.ConfirmPriceRequired,
      'RangePriceRequired': instance.RangePriceRequired,
      'MinPrice': instance.MinPrice,
      'MaxPrice': instance.MaxPrice,
      'Status': instance.Status,
      'DisplayOnHomePage': instance.DisplayOnHomePage,
      'DisplayOrder': instance.DisplayOrder,
      'PictureList': instance.PictureList,
      'VideoUrl': instance.VideoUrl,
      'TagList': instance.TagList,
      'UpdatedOn': instance.UpdatedOn,
    };
