import 'package:json_annotation/json_annotation.dart';

/////flutter packages pub run build_runner build  --delete-conflicting-outputs
part 'goods.g.dart';

@JsonSerializable()
class GoodsModel {
  int PageIndex;
  int PageSize;
  int TotalCount;
  List<ListObjectsGoodsModel> ListObjects;

  GoodsModel();

  factory GoodsModel.fromJson(Map<String, dynamic> json) =>
      _$GoodsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsModelToJson(this);
}

@JsonSerializable()
class ListObjectsGoodsModel {
  String Guid;
  String StoreGuid;
  String VendorGuid;
  String FactoryVendorGuid;
  String ProductName;
  String Description;
  String VendorProductGuid;
  double Price;
  bool ConfirmPriceRequired;
  bool RangePriceRequired;
  double MinPrice;
  double MaxPrice;
  int Status;
  bool DisplayOnHomePage;
  int DisplayOrder;
  List PictureList;
  String VideoUrl;
  List TagList;
  int UpdatedOn;

  ListObjectsGoodsModel();

  factory ListObjectsGoodsModel.fromJson(Map<String, dynamic> json) =>
      _$ListObjectsGoodsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListObjectsGoodsModelToJson(this);
}
