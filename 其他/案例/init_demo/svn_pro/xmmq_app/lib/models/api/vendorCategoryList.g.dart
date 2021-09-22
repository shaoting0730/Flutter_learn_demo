// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendorCategoryList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorCategoryListModel _$VendorCategoryListModelFromJson(
    Map<String, dynamic> json) {
  return VendorCategoryListModel()
    ..Message = json['Message'] as String
    ..Success = json['Success'] as bool
    ..Data = (json['Data'] as List)
        ?.map((e) =>
            e == null ? null : DataModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$VendorCategoryListModelToJson(
        VendorCategoryListModel instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'Success': instance.Success,
      'Data': instance.Data,
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel()
    ..CategoryLogoUrl = json['CategoryLogoUrl'] as String
    ..CategoryName = json['CategoryName'] as String
    ..Guid = json['Guid'] as String
    ..VendorName = json['VendorName'] as String
    ..DisplayOrder = json['DisplayOrder'] as int
    ..Products = json['Products'] as List;
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'CategoryLogoUrl': instance.CategoryLogoUrl,
      'CategoryName': instance.CategoryName,
      'Guid': instance.Guid,
      'VendorName': instance.VendorName,
      'DisplayOrder': instance.DisplayOrder,
      'Products': instance.Products,
    };
