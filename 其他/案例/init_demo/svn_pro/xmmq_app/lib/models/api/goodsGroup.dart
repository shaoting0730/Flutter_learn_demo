import 'package:json_annotation/json_annotation.dart';
import 'package:xmmq_app/generated/i18n.dart';

/////flutter packages pub run build_runner build  --delete-conflicting-outputs
part 'goodsGroup.g.dart';

@JsonSerializable()
class GoodsGroupModel {
  int PageIndex;
  int PageSize;
  int TotalCount;
  List<ListObjectsModel> ListObjects;

  GoodsGroupModel();

  factory GoodsGroupModel.fromJson(Map<String, dynamic> json) =>
      _$GoodsGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsGroupModelToJson(this);
}

@JsonSerializable()
class ListObjectsModel {
  String Guid;
  String GroupName;
  String Description;
  int Status;
  int DisplayOrder;
  int UpdatedOn;
  int AtTheTop;
  int Likes;
  int HasLiked;
  String Advertisement;
  List<ProductListModel> ProductList;
  List<PictureListModel> PictureList;
  List<CommentsModel> Comments;

  ListObjectsModel();

  factory ListObjectsModel.fromJson(Map<String, dynamic> json) =>
      _$ListObjectsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListObjectsModelToJson(this);
}

@JsonSerializable()
class PictureListModel {
  String ImageUrl;
  String ProductGuid;
  bool IsVideo;
  PictureListModel();

  factory PictureListModel.fromJson(Map<String, dynamic> json) =>
      _$PictureListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PictureListModelToJson(this);
}

@JsonSerializable()
class ProductListModel {
  String Guid;
  String StoreGuid;
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
  ProductListModel();

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      _$ProductListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListModelToJson(this);
}

@JsonSerializable()
class CommentsModel {
  String Guid;
  String GroupGuid;
  String ReplyToGuid;
  String StoreCustomerGuid;
  String StoreCustomerHeaderImage;
  String StoreCustomerName;
  String Content;
  int AtTheTop;
  int Status;
  List Replies;
  int ReadFlag;
  int IsStoreOwner;
  int CreatedOn;
  String Thumbernail;
  String ReplyToStoreCustomerHeaderImage;
  String ReplyToStoreCustomerName;
  CommentsModel();

  factory CommentsModel.fromJson(Map<String, dynamic> json) =>
      _$CommentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsModelToJson(this);
}
