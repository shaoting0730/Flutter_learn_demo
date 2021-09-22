import 'package:json_annotation/json_annotation.dart';
import 'iotdevice.dart';
import 'showing.dart';
import 'loginmodel.dart';
part 'houseproduct.g.dart';
/////flutter packages pub run build_runner build  --delete-conflicting-outputs

@JsonSerializable()
class MLSAgentOfficeModel
{
  String OfficeID;
  String OfficeName;
  String OfficePhone;
  String OfficeAddress;
  String OfficeCity;
  String OfficeProvince;
  String OfficePCode;

  factory MLSAgentOfficeModel.fromJson(Map<String, dynamic> json) => _$MLSAgentOfficeModelFromJson(json);
  Map<String, dynamic> toJson() => _$MLSAgentOfficeModelToJson(this);

  MLSAgentOfficeModel({
    this.OfficeID,
    this.OfficeName,
    this.OfficePhone,
    this.OfficeAddress,
    this.OfficeCity,
    this.OfficeProvince,
    this.OfficePCode,
  });

}
@JsonSerializable()
class UtilityIncludesModel
{
  String AllInclusive;
  String Balcony;
  String CACIncluded;
  String CableTVIncluded;
  String CertificationLevel;
  String CentralVac;
  String Freestanding;
  String FireplaceStove;
  String Furnished;
  String FamilyRoom;
  String ParkingIncluded;
  String WaterType;
  String WaterIncluded;
  String Locker;
  String LockerLevel;
  String LockerNumber;
  String LockerUnitNumber;
  String HeatIncluded;
  String UtilitiesTelephone;
  String UtilitiesHydro;
  String UtilitiesGas;
  String UtilitiesCable;
  String Utilities;
  String PrivateEntrance;
  String PetsPermitted;
  String HydroIncluded;
  String Elevator;
  factory UtilityIncludesModel.fromJson(Map<String, dynamic> json) => _$UtilityIncludesModelFromJson(json);
  Map<String, dynamic> toJson() => _$UtilityIncludesModelToJson(this);

  UtilityIncludesModel({
    this.AllInclusive,
    this.Balcony,
    this.CACIncluded,
    this.CableTVIncluded,
    this.CertificationLevel,
    this.CentralVac,
    this.Freestanding,
    this.FireplaceStove,
    this.Furnished,
    this.FamilyRoom,
    this.ParkingIncluded,
    this.WaterType,
    this.WaterIncluded,
    this.Locker,
    this.LockerLevel,
    this.LockerNumber,
    this.LockerUnitNumber,
    this.HeatIncluded,
    this.UtilitiesTelephone,
    this.UtilitiesHydro,
    this.UtilitiesGas,
    this.UtilitiesCable,
    this.Utilities,
    this.PrivateEntrance,
    this.PetsPermitted,
    this.HydroIncluded,
    this.Elevator,
  });
}
@JsonSerializable()
class HouseBookTimeModel
{
  String Guid;
  String StoreCustomerGuid;
  int ScheduledStartTime;
  int ScheduledEndTime;

  factory HouseBookTimeModel.fromJson(Map<String, dynamic> json) => _$HouseBookTimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HouseBookTimeModelToJson(this);

  HouseBookTimeModel({
    this.Guid,
    this.StoreCustomerGuid,
    this.ScheduledStartTime,
    this.ScheduledEndTime,
  });
}
@JsonSerializable()
class RoomDetailsModel
{
  String Level;
  String Room;
  double Width;
  double Length;
  String Description1;
  String Description2;
  String Description3;
  int DisplayOrder;

  factory RoomDetailsModel.fromJson(Map<String, dynamic> json) => _$RoomDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomDetailsModelToJson(this);
  RoomDetailsModel({
    this.Level,
    this.Room,
    this.Width,
    this.Length,
    this.Description1,
    this.Description2,
    this.Description3,
    this.DisplayOrder,
  });
}
@JsonSerializable()
class HouseProductModel
{
  String HouseGuid;
  String LockBoxNumber;
  String ListingBroker;
  String MLSNumber;
  int StatusId;
  int DaysOnMarket;
  String StatusText;
  String BuildingType;
  String PropertyType;
  String OwnershipType;
  String LandSizeTotal;
  String ParkingType;
  double ParkingSpaceTotal;
  double SquareFeet;
  String SquareFeetText;
  String AcresText;
  String PriceCode;
  String CrossStreet;
  String Address;
  String City;
  String State;
  String PostalCode;
  String AptUnit;
  String StreetNumber;
  String StreetName;
  String StreetDirection;
  String StreetAbbreviation;
  String FrontingOnNSEW;
  double Longitude;
  double Latitude;
  String PublicRemarks;
  String NeighborHoods;
  String DisplayStatus;
  String SaleOrLease;
  int Rooms;
  int RoomsPossible;
  int BathRooms;
  int BathRoomsPossible;
  int BedRooms;
  int BedRoomsPossible;
  int KitchensPossible;
  int Kitchens;
  String PossessionDate;
  String AirConditioning;
  String Basement;
  String AssessmentYear;
  double Assessment;
  int ContractDate;
  int SoldDate;
  double OrginalPrice;
  double ListingPrice;
  double SoldPrice;
  double Taxes;
  String TaxesYear;
  String Claimable;
  String CommissionCode;
  String BuildingTypeCode;
  String PrivateOutdoor;
  String PreWarYN;
  String UnitFurnishedYN;
  String PetsPolicyCode;
  int AvailableDate;
  int OpenHouseDate;
  String Pool;
  String HeatType;
  String HeatSource;
  String ApproxAge;
  List<RoomDetailsModel> RoomDetails;
  UtilityIncludesModel UtilityIncludes;
  String RoomDetailsJSon;
  String UtilityIncludesJSon;
  List<String> ImageURLs;
  String InstallLocation;
  String LockerPictureUrl;
  int LockBoxType;
  List<HouseBookTimeModel> BookedShowingList;
  int TotalMyBookedShowing;
  bool IsFavorite;

  factory HouseProductModel.fromJson(Map<String, dynamic> json) => _$HouseProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$HouseProductModelToJson(this);

  HouseProductModel({
    this.HouseGuid,
    this.LockBoxNumber,
    this.ListingBroker,
    this.MLSNumber,
    this.StatusId,
    this.DaysOnMarket,
    this.StatusText,
    this.BuildingType,
    this.PropertyType,
    this.OwnershipType,
    this.LandSizeTotal,
    this.ParkingType,
    this.ParkingSpaceTotal,
    this.SquareFeet,
    this.SquareFeetText,
    this.AcresText,
    this.PriceCode,
    this.CrossStreet,
    this.Address,
    this.City,
    this.State,
    this.PostalCode,
    this.AptUnit,
    this.StreetNumber,
    this.StreetName,
    this.StreetDirection,
    this.StreetAbbreviation,
    this.FrontingOnNSEW,
    this.Longitude,
    this.Latitude,
    this.PublicRemarks,
    this.NeighborHoods,
    this.DisplayStatus,
    this.SaleOrLease,
    this.Rooms,
    this.RoomsPossible,
    this.BathRooms,
    this.BathRoomsPossible,
    this.BedRooms,
    this.BedRoomsPossible,
    this.KitchensPossible,
    this.Kitchens,
    this.PossessionDate,
    this.AirConditioning,
    this.Basement,
    this.AssessmentYear,
    this.Assessment,
    this.ContractDate,
    this.SoldDate,
    this.OrginalPrice,
    this.ListingPrice,
    this.SoldPrice,
    this.Taxes,
    this.TaxesYear,
    this.Claimable,
    this.CommissionCode,
    this.BuildingTypeCode,
    this.PrivateOutdoor,
    this.PreWarYN,
    this.UnitFurnishedYN,
    this.PetsPolicyCode,
    this.AvailableDate,
    this.OpenHouseDate,
    this.Pool,
    this.HeatType,
    this.HeatSource,
    this.ApproxAge,
    this.RoomDetails,
    this.UtilityIncludes,
    this.RoomDetailsJSon,
    this.UtilityIncludesJSon,
    this.ImageURLs,
    this.InstallLocation,
    this.LockBoxType,
    this.LockerPictureUrl,
    this.BookedShowingList,
    this.TotalMyBookedShowing,
    this.IsFavorite,
  });

}

@JsonSerializable()
class RealtorOpenAPISearchModel
{
  double LongitudeMin;
  double LongitudeMax;
  double LatitudeMin;
  double LatitudeMax;
  double PriceMin;
  double PriceMax;
  String PostalCode;
  String ReferenceNumber;
  String Area;
  int PropertySearchTypeId;
  int TransactionTypeId;
  int StoreyRangeMin;
  int StoreyRangeMax;
  int BedRangeMin;
  int BedRangeMax;
  int BathRangeMin;
  int BathRangeMax;
  int OwnershipTypeGroupId;
  int ViewTypeGroupId;
  List<int> BuildingTypeId;
  int ConstructionStyleId;
  bool HasAirCondition = false;
  bool HasPool = false;
  bool HasFireplace = false;
  bool HasGarage = false;
  bool HasWaterfront = false;
  bool Acreage = false;
  String Keywords;
  int CurrentPage = 0;
  int RecordsPerPage = 0;
  int MaximumResults = 0;
  String SortBy = "";
  String SortOrder = "";

  RealtorOpenAPISearchModel({
    this.LongitudeMin = 0,
    this.LongitudeMax = 0,
    this.LatitudeMin = 0,
    this.LatitudeMax = 0,
    this.PriceMax = 0,
    this.PriceMin = 0,
    this.BedRangeMin = 0,
    this.BedRangeMax = 0,
    this.BathRangeMax = 0,
    this.BathRangeMin = 0,
    this.PropertySearchTypeId = 0,
    this.TransactionTypeId = 0,
    this.StoreyRangeMax = 0,
    this.StoreyRangeMin = 0,
    this.OwnershipTypeGroupId = 0,
    this.ViewTypeGroupId = 0,
    this.BuildingTypeId,
    this.ConstructionStyleId = 0,
    this.ReferenceNumber,
    this.Keywords ,
    this.SortBy = "",
    this.SortOrder = ""
  });

  factory RealtorOpenAPISearchModel.fromJson(Map<String, dynamic> json) => _$RealtorOpenAPISearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$RealtorOpenAPISearchModelToJson(this);
}

@JsonSerializable()
class IOTDeviceHouseSearch
{
  int SearchType;
  String MACAddress;
  double centerlongitude;
  double centerlatitude;
  int PageIndex;
  int PageSize;
  RealtorOpenAPISearchModel SearchCriteria;

  factory IOTDeviceHouseSearch.fromJson(Map<String, dynamic> json) => _$IOTDeviceHouseSearchFromJson(json);
  Map<String, dynamic> toJson() => _$IOTDeviceHouseSearchToJson(this);

  IOTDeviceHouseSearch({
    this.SearchType,
    this.centerlongitude,
    this.centerlatitude,
    this.MACAddress,
    this.PageIndex,
    this.PageSize,
    this.SearchCriteria = null
  });

}

@JsonSerializable()
class PagedListIOTDeviceHouseInfo
{
  int PageIndex;
  int PageSize;
  int TotalCount;
  List<IOTDeviceHouseInfoModel> ListObjects;

  factory PagedListIOTDeviceHouseInfo.fromJson(Map<String, dynamic> json) => _$PagedListIOTDeviceHouseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PagedListIOTDeviceHouseInfoToJson(this);

  PagedListIOTDeviceHouseInfo({
    this.PageIndex,
    this.PageSize,
    this.TotalCount,
    this.ListObjects
  });

}

@JsonSerializable()
class IOTDeviceHouseInfoModel
{
  IOTDeviceInfoModel DeviceInfo;
  HouseProductModel HouseInfo;
  IoTDeviceTokenModel DeviceToken;
  List<ShowingRequestModel> ScheduledShowingRequestList;
  List<ShowingRequestModel> ShowingMessageList;
  List<LockBoxDeviceOpenRecordModel> OpenRecordList;
  List<ShowingAutoConfirmSettingModel> ShowingAutoConfirmSettingList;
  ImpersonationorInfoModel HouseOwner;

  factory IOTDeviceHouseInfoModel.fromJson(Map<String, dynamic> json) => _$IOTDeviceHouseInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$IOTDeviceHouseInfoModelToJson(this);

  IOTDeviceHouseInfoModel({
    this.DeviceInfo,
    this.HouseInfo,
    this.DeviceToken,
    this.ScheduledShowingRequestList,
    this.ShowingMessageList,
    this.OpenRecordList,
    this.ShowingAutoConfirmSettingList,
    this.HouseOwner,
  });

}
