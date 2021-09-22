import 'package:json_annotation/json_annotation.dart';

/////flutter packages pub run build_runner build  --delete-conflicting-outputs
part 'vendorCategoryList.g.dart';

@JsonSerializable()
class VendorCategoryListModel {
  String Message;
  bool Success;
  List<DataModel> Data;

  VendorCategoryListModel();

  factory VendorCategoryListModel.fromJson(Map<String, dynamic> json) =>
      _$VendorCategoryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$VendorCategoryListModelToJson(this);
}

@JsonSerializable()
class DataModel {
  String CategoryLogoUrl;
  String CategoryName;
  String Guid;
  String VendorName;
  int DisplayOrder;
  List Products;

  DataModel();

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
