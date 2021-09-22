// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'houseproduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLSAgentOfficeModel _$MLSAgentOfficeModelFromJson(Map<String, dynamic> json) {
  return MLSAgentOfficeModel(
      OfficeID: json['OfficeID'] as String,
      OfficeName: json['OfficeName'] as String,
      OfficePhone: json['OfficePhone'] as String,
      OfficeAddress: json['OfficeAddress'] as String,
      OfficeCity: json['OfficeCity'] as String,
      OfficeProvince: json['OfficeProvince'] as String,
      OfficePCode: json['OfficePCode'] as String);
}

Map<String, dynamic> _$MLSAgentOfficeModelToJson(
        MLSAgentOfficeModel instance) =>
    <String, dynamic>{
      'OfficeID': instance.OfficeID,
      'OfficeName': instance.OfficeName,
      'OfficePhone': instance.OfficePhone,
      'OfficeAddress': instance.OfficeAddress,
      'OfficeCity': instance.OfficeCity,
      'OfficeProvince': instance.OfficeProvince,
      'OfficePCode': instance.OfficePCode
    };

UtilityIncludesModel _$UtilityIncludesModelFromJson(Map<String, dynamic> json) {
  return UtilityIncludesModel(
      AllInclusive: json['AllInclusive'] as String,
      Balcony: json['Balcony'] as String,
      CACIncluded: json['CACIncluded'] as String,
      CableTVIncluded: json['CableTVIncluded'] as String,
      CertificationLevel: json['CertificationLevel'] as String,
      CentralVac: json['CentralVac'] as String,
      Freestanding: json['Freestanding'] as String,
      FireplaceStove: json['FireplaceStove'] as String,
      Furnished: json['Furnished'] as String,
      FamilyRoom: json['FamilyRoom'] as String,
      ParkingIncluded: json['ParkingIncluded'] as String,
      WaterType: json['WaterType'] as String,
      WaterIncluded: json['WaterIncluded'] as String,
      Locker: json['Locker'] as String,
      LockerLevel: json['LockerLevel'] as String,
      LockerNumber: json['LockerNumber'] as String,
      LockerUnitNumber: json['LockerUnitNumber'] as String,
      HeatIncluded: json['HeatIncluded'] as String,
      UtilitiesTelephone: json['UtilitiesTelephone'] as String,
      UtilitiesHydro: json['UtilitiesHydro'] as String,
      UtilitiesGas: json['UtilitiesGas'] as String,
      UtilitiesCable: json['UtilitiesCable'] as String,
      Utilities: json['Utilities'] as String,
      PrivateEntrance: json['PrivateEntrance'] as String,
      PetsPermitted: json['PetsPermitted'] as String,
      HydroIncluded: json['HydroIncluded'] as String,
      Elevator: json['Elevator'] as String);
}

Map<String, dynamic> _$UtilityIncludesModelToJson(
        UtilityIncludesModel instance) =>
    <String, dynamic>{
      'AllInclusive': instance.AllInclusive,
      'Balcony': instance.Balcony,
      'CACIncluded': instance.CACIncluded,
      'CableTVIncluded': instance.CableTVIncluded,
      'CertificationLevel': instance.CertificationLevel,
      'CentralVac': instance.CentralVac,
      'Freestanding': instance.Freestanding,
      'FireplaceStove': instance.FireplaceStove,
      'Furnished': instance.Furnished,
      'FamilyRoom': instance.FamilyRoom,
      'ParkingIncluded': instance.ParkingIncluded,
      'WaterType': instance.WaterType,
      'WaterIncluded': instance.WaterIncluded,
      'Locker': instance.Locker,
      'LockerLevel': instance.LockerLevel,
      'LockerNumber': instance.LockerNumber,
      'LockerUnitNumber': instance.LockerUnitNumber,
      'HeatIncluded': instance.HeatIncluded,
      'UtilitiesTelephone': instance.UtilitiesTelephone,
      'UtilitiesHydro': instance.UtilitiesHydro,
      'UtilitiesGas': instance.UtilitiesGas,
      'UtilitiesCable': instance.UtilitiesCable,
      'Utilities': instance.Utilities,
      'PrivateEntrance': instance.PrivateEntrance,
      'PetsPermitted': instance.PetsPermitted,
      'HydroIncluded': instance.HydroIncluded,
      'Elevator': instance.Elevator
    };

HouseBookTimeModel _$HouseBookTimeModelFromJson(Map<String, dynamic> json) {
  return HouseBookTimeModel(
      Guid: json['Guid'] as String,
      StoreCustomerGuid: json['StoreCustomerGuid'] as String,
      ScheduledStartTime: json['ScheduledStartTime'] as int,
      ScheduledEndTime: json['ScheduledEndTime'] as int);
}

Map<String, dynamic> _$HouseBookTimeModelToJson(HouseBookTimeModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'ScheduledStartTime': instance.ScheduledStartTime,
      'ScheduledEndTime': instance.ScheduledEndTime
    };

RoomDetailsModel _$RoomDetailsModelFromJson(Map<String, dynamic> json) {
  return RoomDetailsModel(
      Level: json['Level'] as String,
      Room: json['Room'] as String,
      Width: (json['Width'] as num)?.toDouble(),
      Length: (json['Length'] as num)?.toDouble(),
      Description1: json['Description1'] as String,
      Description2: json['Description2'] as String,
      Description3: json['Description3'] as String,
      DisplayOrder: json['DisplayOrder'] as int);
}

Map<String, dynamic> _$RoomDetailsModelToJson(RoomDetailsModel instance) =>
    <String, dynamic>{
      'Level': instance.Level,
      'Room': instance.Room,
      'Width': instance.Width,
      'Length': instance.Length,
      'Description1': instance.Description1,
      'Description2': instance.Description2,
      'Description3': instance.Description3,
      'DisplayOrder': instance.DisplayOrder
    };

HouseProductModel _$HouseProductModelFromJson(Map<String, dynamic> json) {
  return HouseProductModel(
      HouseGuid: json['HouseGuid'] as String,
      LockBoxNumber: json['LockBoxNumber'] as String,
      ListingBroker: json['ListingBroker'] as String,
      MLSNumber: json['MLSNumber'] as String,
      StatusId: json['StatusId'] as int,
      DaysOnMarket: json['DaysOnMarket'] as int,
      StatusText: json['StatusText'] as String,
      BuildingType: json['BuildingType'] as String,
      PropertyType: json['PropertyType'] as String,
      OwnershipType: json['OwnershipType'] as String,
      LandSizeTotal: json['LandSizeTotal'] as String,
      ParkingType: json['ParkingType'] as String,
      ParkingSpaceTotal: (json['ParkingSpaceTotal'] as num)?.toDouble(),
      SquareFeet: (json['SquareFeet'] as num)?.toDouble(),
      SquareFeetText: json['SquareFeetText'] as String,
      AcresText: json['AcresText'] as String,
      PriceCode: json['PriceCode'] as String,
      CrossStreet: json['CrossStreet'] as String,
      Address: json['Address'] as String,
      City: json['City'] as String,
      State: json['State'] as String,
      PostalCode: json['PostalCode'] as String,
      AptUnit: json['AptUnit'] as String,
      StreetNumber: json['StreetNumber'] as String,
      StreetName: json['StreetName'] as String,
      StreetDirection: json['StreetDirection'] as String,
      StreetAbbreviation: json['StreetAbbreviation'] as String,
      FrontingOnNSEW: json['FrontingOnNSEW'] as String,
      Longitude: (json['Longitude'] as num)?.toDouble(),
      Latitude: (json['Latitude'] as num)?.toDouble(),
      PublicRemarks: json['PublicRemarks'] as String,
      NeighborHoods: json['NeighborHoods'] as String,
      DisplayStatus: json['DisplayStatus'] as String,
      SaleOrLease: json['SaleOrLease'] as String,
      Rooms: json['Rooms'] as int,
      RoomsPossible: json['RoomsPossible'] as int,
      BathRooms: json['BathRooms'] as int,
      BathRoomsPossible: json['BathRoomsPossible'] as int,
      BedRooms: json['BedRooms'] as int,
      BedRoomsPossible: json['BedRoomsPossible'] as int,
      KitchensPossible: json['KitchensPossible'] as int,
      Kitchens: json['Kitchens'] as int,
      PossessionDate: json['PossessionDate'] as String,
      AirConditioning: json['AirConditioning'] as String,
      Basement: json['Basement'] as String,
      AssessmentYear: json['AssessmentYear'] as String,
      Assessment: (json['Assessment'] as num)?.toDouble(),
      ContractDate: json['ContractDate'] as int,
      SoldDate: json['SoldDate'] as int,
      OrginalPrice: (json['OrginalPrice'] as num)?.toDouble(),
      ListingPrice: (json['ListingPrice'] as num)?.toDouble(),
      SoldPrice: (json['SoldPrice'] as num)?.toDouble(),
      Taxes: (json['Taxes'] as num)?.toDouble(),
      TaxesYear: json['TaxesYear'] as String,
      Claimable: json['Claimable'] as String,
      CommissionCode: json['CommissionCode'] as String,
      BuildingTypeCode: json['BuildingTypeCode'] as String,
      PrivateOutdoor: json['PrivateOutdoor'] as String,
      PreWarYN: json['PreWarYN'] as String,
      UnitFurnishedYN: json['UnitFurnishedYN'] as String,
      PetsPolicyCode: json['PetsPolicyCode'] as String,
      AvailableDate: json['AvailableDate'] as int,
      OpenHouseDate: json['OpenHouseDate'] as int,
      Pool: json['Pool'] as String,
      HeatType: json['HeatType'] as String,
      HeatSource: json['HeatSource'] as String,
      ApproxAge: json['ApproxAge'] as String,
      RoomDetails: (json['RoomDetails'] as List)
          ?.map((e) => e == null
              ? null
              : RoomDetailsModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      UtilityIncludes: json['UtilityIncludes'] == null
          ? null
          : UtilityIncludesModel.fromJson(
              json['UtilityIncludes'] as Map<String, dynamic>),
      RoomDetailsJSon: json['RoomDetailsJSon'] as String,
      UtilityIncludesJSon: json['UtilityIncludesJSon'] as String,
      ImageURLs: (json['ImageURLs'] as List)?.map((e) => e as String)?.toList(),
      InstallLocation: json['InstallLocation'] as String,
      LockBoxType: json['LockBoxType'] as int,
      LockerPictureUrl: json['LockerPictureUrl'] as String,
      BookedShowingList: (json['BookedShowingList'] as List)
          ?.map((e) => e == null
              ? null
              : HouseBookTimeModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      TotalMyBookedShowing: json['TotalMyBookedShowing'] as int,
      IsFavorite: json['IsFavorite'] as bool);
}

Map<String, dynamic> _$HouseProductModelToJson(HouseProductModel instance) =>
    <String, dynamic>{
      'HouseGuid': instance.HouseGuid,
      'LockBoxNumber': instance.LockBoxNumber,
      'ListingBroker': instance.ListingBroker,
      'MLSNumber': instance.MLSNumber,
      'StatusId': instance.StatusId,
      'DaysOnMarket': instance.DaysOnMarket,
      'StatusText': instance.StatusText,
      'BuildingType': instance.BuildingType,
      'PropertyType': instance.PropertyType,
      'OwnershipType': instance.OwnershipType,
      'LandSizeTotal': instance.LandSizeTotal,
      'ParkingType': instance.ParkingType,
      'ParkingSpaceTotal': instance.ParkingSpaceTotal,
      'SquareFeet': instance.SquareFeet,
      'SquareFeetText': instance.SquareFeetText,
      'AcresText': instance.AcresText,
      'PriceCode': instance.PriceCode,
      'CrossStreet': instance.CrossStreet,
      'Address': instance.Address,
      'City': instance.City,
      'State': instance.State,
      'PostalCode': instance.PostalCode,
      'AptUnit': instance.AptUnit,
      'StreetNumber': instance.StreetNumber,
      'StreetName': instance.StreetName,
      'StreetDirection': instance.StreetDirection,
      'StreetAbbreviation': instance.StreetAbbreviation,
      'FrontingOnNSEW': instance.FrontingOnNSEW,
      'Longitude': instance.Longitude,
      'Latitude': instance.Latitude,
      'PublicRemarks': instance.PublicRemarks,
      'NeighborHoods': instance.NeighborHoods,
      'DisplayStatus': instance.DisplayStatus,
      'SaleOrLease': instance.SaleOrLease,
      'Rooms': instance.Rooms,
      'RoomsPossible': instance.RoomsPossible,
      'BathRooms': instance.BathRooms,
      'BathRoomsPossible': instance.BathRoomsPossible,
      'BedRooms': instance.BedRooms,
      'BedRoomsPossible': instance.BedRoomsPossible,
      'KitchensPossible': instance.KitchensPossible,
      'Kitchens': instance.Kitchens,
      'PossessionDate': instance.PossessionDate,
      'AirConditioning': instance.AirConditioning,
      'Basement': instance.Basement,
      'AssessmentYear': instance.AssessmentYear,
      'Assessment': instance.Assessment,
      'ContractDate': instance.ContractDate,
      'SoldDate': instance.SoldDate,
      'OrginalPrice': instance.OrginalPrice,
      'ListingPrice': instance.ListingPrice,
      'SoldPrice': instance.SoldPrice,
      'Taxes': instance.Taxes,
      'TaxesYear': instance.TaxesYear,
      'Claimable': instance.Claimable,
      'CommissionCode': instance.CommissionCode,
      'BuildingTypeCode': instance.BuildingTypeCode,
      'PrivateOutdoor': instance.PrivateOutdoor,
      'PreWarYN': instance.PreWarYN,
      'UnitFurnishedYN': instance.UnitFurnishedYN,
      'PetsPolicyCode': instance.PetsPolicyCode,
      'AvailableDate': instance.AvailableDate,
      'OpenHouseDate': instance.OpenHouseDate,
      'Pool': instance.Pool,
      'HeatType': instance.HeatType,
      'HeatSource': instance.HeatSource,
      'ApproxAge': instance.ApproxAge,
      'RoomDetails': instance.RoomDetails,
      'UtilityIncludes': instance.UtilityIncludes,
      'RoomDetailsJSon': instance.RoomDetailsJSon,
      'UtilityIncludesJSon': instance.UtilityIncludesJSon,
      'ImageURLs': instance.ImageURLs,
      'InstallLocation': instance.InstallLocation,
      'LockerPictureUrl': instance.LockerPictureUrl,
      'LockBoxType': instance.LockBoxType,
      'BookedShowingList': instance.BookedShowingList,
      'TotalMyBookedShowing': instance.TotalMyBookedShowing,
      'IsFavorite': instance.IsFavorite
    };

RealtorOpenAPISearchModel _$RealtorOpenAPISearchModelFromJson(
    Map<String, dynamic> json) {
  return RealtorOpenAPISearchModel(
      LongitudeMin: (json['LongitudeMin'] as num)?.toDouble(),
      LongitudeMax: (json['LongitudeMax'] as num)?.toDouble(),
      LatitudeMin: (json['LatitudeMin'] as num)?.toDouble(),
      LatitudeMax: (json['LatitudeMax'] as num)?.toDouble(),
      PriceMax: (json['PriceMax'] as num)?.toDouble(),
      PriceMin: (json['PriceMin'] as num)?.toDouble(),
      BedRangeMin: json['BedRangeMin'] as int,
      BedRangeMax: json['BedRangeMax'] as int,
      BathRangeMax: json['BathRangeMax'] as int,
      BathRangeMin: json['BathRangeMin'] as int,
      PropertySearchTypeId: json['PropertySearchTypeId'] as int,
      TransactionTypeId: json['TransactionTypeId'] as int,
      StoreyRangeMax: json['StoreyRangeMax'] as int,
      StoreyRangeMin: json['StoreyRangeMin'] as int,
      OwnershipTypeGroupId: json['OwnershipTypeGroupId'] as int,
      ViewTypeGroupId: json['ViewTypeGroupId'] as int,
      BuildingTypeId:
          (json['BuildingTypeId'] as List)?.map((e) => e as int)?.toList(),
      ConstructionStyleId: json['ConstructionStyleId'] as int,
      ReferenceNumber: json['ReferenceNumber'] as String,
      Keywords: json['Keywords'] as String,
      SortBy: json['SortBy'] as String,
      SortOrder: json['SortOrder'] as String)
    ..PostalCode = json['PostalCode'] as String
    ..Area = json['Area'] as String
    ..HasAirCondition = json['HasAirCondition'] as bool
    ..HasPool = json['HasPool'] as bool
    ..HasFireplace = json['HasFireplace'] as bool
    ..HasGarage = json['HasGarage'] as bool
    ..HasWaterfront = json['HasWaterfront'] as bool
    ..Acreage = json['Acreage'] as bool
    ..CurrentPage = json['CurrentPage'] as int
    ..RecordsPerPage = json['RecordsPerPage'] as int
    ..MaximumResults = json['MaximumResults'] as int;
}

Map<String, dynamic> _$RealtorOpenAPISearchModelToJson(
        RealtorOpenAPISearchModel instance) =>
    <String, dynamic>{
      'LongitudeMin': instance.LongitudeMin,
      'LongitudeMax': instance.LongitudeMax,
      'LatitudeMin': instance.LatitudeMin,
      'LatitudeMax': instance.LatitudeMax,
      'PriceMin': instance.PriceMin,
      'PriceMax': instance.PriceMax,
      'PostalCode': instance.PostalCode,
      'ReferenceNumber': instance.ReferenceNumber,
      'Area': instance.Area,
      'PropertySearchTypeId': instance.PropertySearchTypeId,
      'TransactionTypeId': instance.TransactionTypeId,
      'StoreyRangeMin': instance.StoreyRangeMin,
      'StoreyRangeMax': instance.StoreyRangeMax,
      'BedRangeMin': instance.BedRangeMin,
      'BedRangeMax': instance.BedRangeMax,
      'BathRangeMin': instance.BathRangeMin,
      'BathRangeMax': instance.BathRangeMax,
      'OwnershipTypeGroupId': instance.OwnershipTypeGroupId,
      'ViewTypeGroupId': instance.ViewTypeGroupId,
      'BuildingTypeId': instance.BuildingTypeId,
      'ConstructionStyleId': instance.ConstructionStyleId,
      'HasAirCondition': instance.HasAirCondition,
      'HasPool': instance.HasPool,
      'HasFireplace': instance.HasFireplace,
      'HasGarage': instance.HasGarage,
      'HasWaterfront': instance.HasWaterfront,
      'Acreage': instance.Acreage,
      'Keywords': instance.Keywords,
      'CurrentPage': instance.CurrentPage,
      'RecordsPerPage': instance.RecordsPerPage,
      'MaximumResults': instance.MaximumResults,
      'SortBy': instance.SortBy,
      'SortOrder': instance.SortOrder
    };

IOTDeviceHouseSearch _$IOTDeviceHouseSearchFromJson(Map<String, dynamic> json) {
  return IOTDeviceHouseSearch(
      SearchType: json['SearchType'] as int,
      centerlongitude: (json['centerlongitude'] as num)?.toDouble(),
      centerlatitude: (json['centerlatitude'] as num)?.toDouble(),
      MACAddress: json['MACAddress'] as String,
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int,
      SearchCriteria: json['SearchCriteria'] == null
          ? null
          : RealtorOpenAPISearchModel.fromJson(
              json['SearchCriteria'] as Map<String, dynamic>));
}

Map<String, dynamic> _$IOTDeviceHouseSearchToJson(
        IOTDeviceHouseSearch instance) =>
    <String, dynamic>{
      'SearchType': instance.SearchType,
      'MACAddress': instance.MACAddress,
      'centerlongitude': instance.centerlongitude,
      'centerlatitude': instance.centerlatitude,
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'SearchCriteria': instance.SearchCriteria
    };

PagedListIOTDeviceHouseInfo _$PagedListIOTDeviceHouseInfoFromJson(
    Map<String, dynamic> json) {
  return PagedListIOTDeviceHouseInfo(
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int,
      TotalCount: json['TotalCount'] as int,
      ListObjects: (json['ListObjects'] as List)
          ?.map((e) => e == null
              ? null
              : IOTDeviceHouseInfoModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PagedListIOTDeviceHouseInfoToJson(
        PagedListIOTDeviceHouseInfo instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects
    };

IOTDeviceHouseInfoModel _$IOTDeviceHouseInfoModelFromJson(
    Map<String, dynamic> json) {
  return IOTDeviceHouseInfoModel(
      DeviceInfo: json['DeviceInfo'] == null
          ? null
          : IOTDeviceInfoModel.fromJson(
              json['DeviceInfo'] as Map<String, dynamic>),
      HouseInfo: json['HouseInfo'] == null
          ? null
          : HouseProductModel.fromJson(
              json['HouseInfo'] as Map<String, dynamic>),
      DeviceToken: json['DeviceToken'] == null
          ? null
          : IoTDeviceTokenModel.fromJson(
              json['DeviceToken'] as Map<String, dynamic>),
      ScheduledShowingRequestList: (json['ScheduledShowingRequestList'] as List)
          ?.map((e) => e == null
              ? null
              : ShowingRequestModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      ShowingMessageList: (json['ShowingMessageList'] as List)
          ?.map((e) => e == null
              ? null
              : ShowingRequestModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      OpenRecordList: (json['OpenRecordList'] as List)
          ?.map((e) => e == null
              ? null
              : LockBoxDeviceOpenRecordModel.fromJson(
                  e as Map<String, dynamic>))
          ?.toList(),
      ShowingAutoConfirmSettingList:
          (json['ShowingAutoConfirmSettingList'] as List)
              ?.map((e) => e == null
                  ? null
                  : ShowingAutoConfirmSettingModel.fromJson(
                      e as Map<String, dynamic>))
              ?.toList(),
      HouseOwner: json['HouseOwner'] == null
          ? null
          : ImpersonationorInfoModel.fromJson(
              json['HouseOwner'] as Map<String, dynamic>));
}

Map<String, dynamic> _$IOTDeviceHouseInfoModelToJson(
        IOTDeviceHouseInfoModel instance) =>
    <String, dynamic>{
      'DeviceInfo': instance.DeviceInfo,
      'HouseInfo': instance.HouseInfo,
      'DeviceToken': instance.DeviceToken,
      'ScheduledShowingRequestList': instance.ScheduledShowingRequestList,
      'ShowingMessageList': instance.ShowingMessageList,
      'OpenRecordList': instance.OpenRecordList,
      'ShowingAutoConfirmSettingList': instance.ShowingAutoConfirmSettingList,
      'HouseOwner': instance.HouseOwner
    };
