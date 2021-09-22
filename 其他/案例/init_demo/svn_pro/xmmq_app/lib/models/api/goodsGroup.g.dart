// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodsGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsGroupModel _$GoodsGroupModelFromJson(Map<String, dynamic> json) {
  return GoodsGroupModel()
    ..PageIndex = json['PageIndex'] as int
    ..PageSize = json['PageSize'] as int
    ..TotalCount = json['TotalCount'] as int
    ..ListObjects = (json['ListObjects'] as List)
        ?.map((e) => e == null
            ? null
            : ListObjectsModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GoodsGroupModelToJson(GoodsGroupModel instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects,
    };

ListObjectsModel _$ListObjectsModelFromJson(Map<String, dynamic> json) {
  return ListObjectsModel()
    ..Guid = json['Guid'] as String
    ..GroupName = json['GroupName'] as String
    ..Description = json['Description'] as String
    ..Status = json['Status'] as int
    ..DisplayOrder = json['DisplayOrder'] as int
    ..UpdatedOn = json['UpdatedOn'] as int
    ..AtTheTop = json['AtTheTop'] as int
    ..Likes = json['Likes'] as int
    ..HasLiked = json['HasLiked'] as int
    ..Advertisement = json['Advertisement'] as String
    ..ProductList = (json['ProductList'] as List)
        ?.map((e) => e == null
            ? null
            : ProductListModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..PictureList = (json['PictureList'] as List)
        ?.map((e) => e == null
            ? null
            : PictureListModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..Comments = (json['Comments'] as List)
        ?.map((e) => e == null
            ? null
            : CommentsModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListObjectsModelToJson(ListObjectsModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'GroupName': instance.GroupName,
      'Description': instance.Description,
      'Status': instance.Status,
      'DisplayOrder': instance.DisplayOrder,
      'UpdatedOn': instance.UpdatedOn,
      'AtTheTop': instance.AtTheTop,
      'Likes': instance.Likes,
      'HasLiked': instance.HasLiked,
      'Advertisement': instance.Advertisement,
      'ProductList': instance.ProductList,
      'PictureList': instance.PictureList,
      'Comments': instance.Comments,
    };

PictureListModel _$PictureListModelFromJson(Map<String, dynamic> json) {
  return PictureListModel()
    ..ImageUrl = json['ImageUrl'] as String
    ..ProductGuid = json['ProductGuid'] as String
    ..IsVideo = json['IsVideo'] as bool;
}

Map<String, dynamic> _$PictureListModelToJson(PictureListModel instance) =>
    <String, dynamic>{
      'ImageUrl': instance.ImageUrl,
      'ProductGuid': instance.ProductGuid,
      'IsVideo': instance.IsVideo,
    };

ProductListModel _$ProductListModelFromJson(Map<String, dynamic> json) {
  return ProductListModel()
    ..Guid = json['Guid'] as String
    ..StoreGuid = json['StoreGuid'] as String
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

Map<String, dynamic> _$ProductListModelToJson(ProductListModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'StoreGuid': instance.StoreGuid,
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

CommentsModel _$CommentsModelFromJson(Map<String, dynamic> json) {
  return CommentsModel()
    ..Guid = json['Guid'] as String
    ..GroupGuid = json['GroupGuid'] as String
    ..ReplyToGuid = json['ReplyToGuid'] as String
    ..StoreCustomerGuid = json['StoreCustomerGuid'] as String
    ..StoreCustomerHeaderImage = json['StoreCustomerHeaderImage'] as String
    ..StoreCustomerName = json['StoreCustomerName'] as String
    ..Content = json['Content'] as String
    ..AtTheTop = json['AtTheTop'] as int
    ..Status = json['Status'] as int
    ..Replies = json['Replies'] as List
    ..ReadFlag = json['ReadFlag'] as int
    ..IsStoreOwner = json['IsStoreOwner'] as int
    ..CreatedOn = json['CreatedOn'] as int
    ..Thumbernail = json['Thumbernail'] as String
    ..ReplyToStoreCustomerHeaderImage =
        json['ReplyToStoreCustomerHeaderImage'] as String
    ..ReplyToStoreCustomerName = json['ReplyToStoreCustomerName'] as String;
}

Map<String, dynamic> _$CommentsModelToJson(CommentsModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'GroupGuid': instance.GroupGuid,
      'ReplyToGuid': instance.ReplyToGuid,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'StoreCustomerHeaderImage': instance.StoreCustomerHeaderImage,
      'StoreCustomerName': instance.StoreCustomerName,
      'Content': instance.Content,
      'AtTheTop': instance.AtTheTop,
      'Status': instance.Status,
      'Replies': instance.Replies,
      'ReadFlag': instance.ReadFlag,
      'IsStoreOwner': instance.IsStoreOwner,
      'CreatedOn': instance.CreatedOn,
      'Thumbernail': instance.Thumbernail,
      'ReplyToStoreCustomerHeaderImage':
          instance.ReplyToStoreCustomerHeaderImage,
      'ReplyToStoreCustomerName': instance.ReplyToStoreCustomerName,
    };
