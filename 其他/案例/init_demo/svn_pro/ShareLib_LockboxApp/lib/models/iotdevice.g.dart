// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iotdevice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LockBoxDeviceSharePasswordRequest _$LockBoxDeviceSharePasswordRequestFromJson(
    Map<String, dynamic> json) {
  return LockBoxDeviceSharePasswordRequest(
      IoTDeviceGuid: json['IoTDeviceGuid'] as String,
      SharedToPhoneNumber: json['SharedToPhoneNumber'] as String,
      StartDateTime: json['StartDateTime'] as int,
      EndDateTime: json['EndDateTime'] as int,
      LocalCode: json['LocalCode'] as String);
}

Map<String, dynamic> _$LockBoxDeviceSharePasswordRequestToJson(
        LockBoxDeviceSharePasswordRequest instance) =>
    <String, dynamic>{
      'IoTDeviceGuid': instance.IoTDeviceGuid,
      'SharedToPhoneNumber': instance.SharedToPhoneNumber,
      'StartDateTime': instance.StartDateTime,
      'EndDateTime': instance.EndDateTime,
      'LocalCode': instance.LocalCode
    };

LockBoxDeviceOpenRecordModel _$LockBoxDeviceOpenRecordModelFromJson(
    Map<String, dynamic> json) {
  return LockBoxDeviceOpenRecordModel(
      Guid: json['Guid'] as String,
      DeviceMACAddress: json['DeviceMACAddress'] as String,
      DeviceQRCode: json['DeviceQRCode'] as String,
      MLSNumber: json['MLSNumber'] as String,
      DoorStatus: json['DoorStatus'] as int,
      IsOpenHook: json['IsOpenHook'] as bool,
      Longitude: (json['Longitude'] as num)?.toDouble(),
      Latitude: (json['Latitude'] as num)?.toDouble(),
      PowerPercentage: (json['PowerPercentage'] as num)?.toDouble(),
      OpenedBy: json['OpenedBy'] as String,
      UpdatedBy: json['UpdatedBy'] as String,
      UpdatedOn: json['UpdatedOn'] as int);
}

Map<String, dynamic> _$LockBoxDeviceOpenRecordModelToJson(
        LockBoxDeviceOpenRecordModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'DeviceMACAddress': instance.DeviceMACAddress,
      'DeviceQRCode': instance.DeviceQRCode,
      'MLSNumber': instance.MLSNumber,
      'DoorStatus': instance.DoorStatus,
      'IsOpenHook': instance.IsOpenHook,
      'Longitude': instance.Longitude,
      'Latitude': instance.Latitude,
      'PowerPercentage': instance.PowerPercentage,
      'OpenedBy': instance.OpenedBy,
      'UpdatedBy': instance.UpdatedBy,
      'UpdatedOn': instance.UpdatedOn
    };

LockBoxDevicePermissionTimeModel _$LockBoxDevicePermissionTimeModelFromJson(
    Map<String, dynamic> json) {
  return LockBoxDevicePermissionTimeModel(
      Guid: json['Guid'] as String,
      DateType: json['DateType'] as int,
      WeekDay: json['WeekDay'] as String,
      SpecialStartDate: json['SpecialStartDate'] as int,
      SpecialEndDate: json['SpecialEndDate'] as int,
      StartTime: json['StartTime'] as int,
      EndTime: json['EndTime'] as int,
      EnableRule: json['EnableRule'] as bool);
}

Map<String, dynamic> _$LockBoxDevicePermissionTimeModelToJson(
        LockBoxDevicePermissionTimeModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'DateType': instance.DateType,
      'WeekDay': instance.WeekDay,
      'SpecialStartDate': instance.SpecialStartDate,
      'SpecialEndDate': instance.SpecialEndDate,
      'StartTime': instance.StartTime,
      'EndTime': instance.EndTime,
      'EnableRule': instance.EnableRule
    };

LockBoxDevicePermissionModel _$LockBoxDevicePermissionModelFromJson(
    Map<String, dynamic> json) {
  return LockBoxDevicePermissionModel(
      IoTDeviceGuid: json['IoTDeviceGuid'] as String,
      DeviceName: json['DeviceName'] as String,
      DeviceInfo: json['DeviceInfo'] as String,
      SharedToPhoneNumber: json['SharedToPhoneNumber'] as String,
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      AvatorLogoUrl: json['AvatorLogoUrl'] as String,
      PermissionTimeList: (json['PermissionTimeList'] as List)
          ?.map((e) => e == null
              ? null
              : LockBoxDevicePermissionTimeModel.fromJson(
                  e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LockBoxDevicePermissionModelToJson(
        LockBoxDevicePermissionModel instance) =>
    <String, dynamic>{
      'IoTDeviceGuid': instance.IoTDeviceGuid,
      'DeviceName': instance.DeviceName,
      'DeviceInfo': instance.DeviceInfo,
      'SharedToPhoneNumber': instance.SharedToPhoneNumber,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'AvatorLogoUrl': instance.AvatorLogoUrl,
      'PermissionTimeList': instance.PermissionTimeList
    };

PagedListIOTDeviceRequestModel _$PagedListIOTDeviceRequestModelFromJson(
    Map<String, dynamic> json) {
  return PagedListIOTDeviceRequestModel(
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int,
      TotalCount: json['TotalCount'] as int,
      ListObjects: (json['ListObjects'] as List)
          ?.map((e) => e == null
              ? null
              : IOTDeviceRequestModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PagedListIOTDeviceRequestModelToJson(
        PagedListIOTDeviceRequestModel instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects
    };

IOTDeviceRealTimeInfoModel _$IOTDeviceRealTimeInfoModelFromJson(
    Map<String, dynamic> json) {
  return IOTDeviceRealTimeInfoModel(
      DeviceMACAddress: json['DeviceMACAddress'] as String,
      DeviceUniqueId: json['DeviceUniqueId'] as String,
      DeviceLongitude: (json['DeviceLongitude'] as num)?.toDouble(),
      DeviceLatitude: (json['DeviceLatitude'] as num)?.toDouble(),
      DoorStatus: json['DoorStatus'] as int,
      PowerPercentage: (json['PowerPercentage'] as num)?.toDouble(),
      IsOpenHook: json['IsOpenHook'] as bool);
}

Map<String, dynamic> _$IOTDeviceRealTimeInfoModelToJson(
        IOTDeviceRealTimeInfoModel instance) =>
    <String, dynamic>{
      'DeviceMACAddress': instance.DeviceMACAddress,
      'DeviceUniqueId': instance.DeviceUniqueId,
      'DeviceLongitude': instance.DeviceLongitude,
      'DeviceLatitude': instance.DeviceLatitude,
      'DoorStatus': instance.DoorStatus,
      'PowerPercentage': instance.PowerPercentage,
      'IsOpenHook': instance.IsOpenHook
    };

IoTDeviceTokenModel _$IoTDeviceTokenModelFromJson(Map<String, dynamic> json) {
  return IoTDeviceTokenModel(
      EncryptDeviceUniqueId: json['EncryptDeviceUniqueId'] as String,
      Password: json['Password'] as String,
      ScheduledStartTime: json['ScheduledStartTime'] as int,
      ScheduledEndTime: json['ScheduledEndTime'] as int);
}

Map<String, dynamic> _$IoTDeviceTokenModelToJson(
        IoTDeviceTokenModel instance) =>
    <String, dynamic>{
      'EncryptDeviceUniqueId': instance.EncryptDeviceUniqueId,
      'Password': instance.Password,
      'ScheduledStartTime': instance.ScheduledStartTime,
      'ScheduledEndTime': instance.ScheduledEndTime
    };

IOTDeviceRequestModel _$IOTDeviceRequestModelFromJson(
    Map<String, dynamic> json) {
  return IOTDeviceRequestModel(
      Guid: json['Guid'] as String,
      DeviceMACAddress: json['DeviceMACAddress'] as String,
      StoreCustomerGuid: json['StoreCustomerGuid'] as String,
      ContactName: json['ContactName'] as String,
      MLSNumber: json['MLSNumber'] as String,
      LockboxType: json['LockboxType'] as int,
      Password: json['Password'] as String,
      AgentCode: json['AgentCode'] as String,
      AgentStoreCustomerGuid: json['AgentStoreCustomerGuid'] as String,
      RequestType: json['RequestType'] as int,
      PreferInstallDate: json['PreferInstallDate'] as int,
      InstalledLocation: json['InstalledLocation'] as String,
      Longitude: (json['Longitude'] as num)?.toDouble(),
      Latitude: (json['Latitude'] as num)?.toDouble(),
      WorkPicture: json['WorkPicture'] as String,
      JobStatus: json['JobStatus'] as int,
      InstallerName: json['InstallerName'] as String,
      InstallerCode: json['InstallerCode'] as String,
      DeviceToken: json['DeviceToken'] == null
          ? null
          : IoTDeviceTokenModel.fromJson(
              json['DeviceToken'] as Map<String, dynamic>),
      DeviceQRCode: json['DeviceQRCode'] as String);
}

Map<String, dynamic> _$IOTDeviceRequestModelToJson(
        IOTDeviceRequestModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'DeviceMACAddress': instance.DeviceMACAddress,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'ContactName': instance.ContactName,
      'MLSNumber': instance.MLSNumber,
      'LockboxType': instance.LockboxType,
      'Password': instance.Password,
      'AgentCode': instance.AgentCode,
      'AgentStoreCustomerGuid': instance.AgentStoreCustomerGuid,
      'RequestType': instance.RequestType,
      'PreferInstallDate': instance.PreferInstallDate,
      'InstalledLocation': instance.InstalledLocation,
      'Longitude': instance.Longitude,
      'Latitude': instance.Latitude,
      'WorkPicture': instance.WorkPicture,
      'JobStatus': instance.JobStatus,
      'InstallerName': instance.InstallerName,
      'InstallerCode': instance.InstallerCode,
      'DeviceToken': instance.DeviceToken,
      'DeviceQRCode': instance.DeviceQRCode
    };

IOTDeviceRequestSearch _$IOTDeviceRequestSearchFromJson(
    Map<String, dynamic> json) {
  return IOTDeviceRequestSearch(
      Guid: json['Guid'] as String,
      DeviceMACAddress: json['DeviceMACAddress'] as String,
      StoreCustomerGuid: json['StoreCustomerGuid'] as String,
      DeviceQRCode: json['DeviceQRCode'] as String,
      ContactName: json['ContactName'] as String,
      MLSNumber: json['MLSNumber'] as String,
      AgentCode: json['AgentCode'] as String,
      AgentStoreCustomerGuid: json['AgentStoreCustomerGuid'] as String,
      RequestType: json['RequestType'] as int,
      Longitude: (json['Longitude'] as num)?.toDouble(),
      Latitude: (json['Latitude'] as num)?.toDouble(),
      JobStatus: json['JobStatus'] as int,
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int);
}

Map<String, dynamic> _$IOTDeviceRequestSearchToJson(
        IOTDeviceRequestSearch instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'DeviceMACAddress': instance.DeviceMACAddress,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'DeviceQRCode': instance.DeviceQRCode,
      'ContactName': instance.ContactName,
      'MLSNumber': instance.MLSNumber,
      'AgentCode': instance.AgentCode,
      'AgentStoreCustomerGuid': instance.AgentStoreCustomerGuid,
      'RequestType': instance.RequestType,
      'Longitude': instance.Longitude,
      'Latitude': instance.Latitude,
      'JobStatus': instance.JobStatus,
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize
    };

IOTDeviceInfoModel _$IOTDeviceInfoModelFromJson(Map<String, dynamic> json) {
  return IOTDeviceInfoModel(
      Guid: json['Guid'] as String,
      MasterUserGuid: json['MasterUserGuid'] as String,
      MasterUserEmail: json['MasterUserEmail'] as String,
      MasterUserName: json['MasterUserName'] as String,
      DeviceQRCode: json['DeviceQRCode'] as String,
      DeviceMACAddress: json['DeviceMACAddress'] as String,
      DeviceUniqueId: json['DeviceUniqueId'] as String,
      DeviceName: json['DeviceName'] as String,
      DeviceType: json['DeviceType'] as String,
      DeviceTypeId: json['DeviceTypeId'] as int,
      Barcode: json['Barcode'] as String,
      Description: json['Description'] as String,
      LinkProductGuid: json['LinkProductGuid'] as String,
      TimeZoneMinutes: json['TimeZoneMinutes'] as int,
      DeviceRequesterGuid: json['DeviceRequesterGuid'] as String,
      AccessInstruction: json['AccessInstruction'] as String,
      CreatedOn: json['CreatedOn'] as int,
      UpdatedOn: json['UpdatedOn'] as int);
}

Map<String, dynamic> _$IOTDeviceInfoModelToJson(IOTDeviceInfoModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'MasterUserGuid': instance.MasterUserGuid,
      'MasterUserEmail': instance.MasterUserEmail,
      'MasterUserName': instance.MasterUserName,
      'DeviceQRCode': instance.DeviceQRCode,
      'DeviceMACAddress': instance.DeviceMACAddress,
      'DeviceUniqueId': instance.DeviceUniqueId,
      'DeviceName': instance.DeviceName,
      'DeviceType': instance.DeviceType,
      'DeviceTypeId': instance.DeviceTypeId,
      'Barcode': instance.Barcode,
      'Description': instance.Description,
      'LinkProductGuid': instance.LinkProductGuid,
      'DeviceRequesterGuid': instance.DeviceRequesterGuid,
      'AccessInstruction': instance.AccessInstruction,
      'TimeZoneMinutes': instance.TimeZoneMinutes,
      'CreatedOn': instance.CreatedOn,
      'UpdatedOn': instance.UpdatedOn
    };

IOTDeviceInfoSearch _$IOTDeviceInfoSearchFromJson(Map<String, dynamic> json) {
  return IOTDeviceInfoSearch(
      Guid: json['Guid'] as String,
      DeviceMACAddress: json['DeviceMACAddress'] as String,
      DeviceQRCode: json['DeviceQRCode'] as String,
      DeviceName: json['DeviceName'] as String,
      DeviceType: json['DeviceType'] as String,
      DeviceTypeId: json['DeviceTypeId'] as int,
      Barcode: json['Barcode'] as String,
      Description: json['Description'] as String,
      LinkProductGuid: json['LinkProductGuid'] as String,
      MasterUserGuid: json['MasterUserGuid'] as String,
      SearchType: json['SearchType'] as int,
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int);
}

Map<String, dynamic> _$IOTDeviceInfoSearchToJson(
        IOTDeviceInfoSearch instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'DeviceMACAddress': instance.DeviceMACAddress,
      'DeviceQRCode': instance.DeviceQRCode,
      'DeviceName': instance.DeviceName,
      'DeviceType': instance.DeviceType,
      'DeviceTypeId': instance.DeviceTypeId,
      'Barcode': instance.Barcode,
      'Description': instance.Description,
      'LinkProductGuid': instance.LinkProductGuid,
      'MasterUserGuid': instance.MasterUserGuid,
      'SearchType': instance.SearchType,
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize
    };

PagedListIOTDeviceInfoModel _$PagedListIOTDeviceInfoModelFromJson(
    Map<String, dynamic> json) {
  return PagedListIOTDeviceInfoModel(
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int,
      TotalCount: json['TotalCount'] as int,
      ListObjects: (json['ListObjects'] as List)
          ?.map((e) => e == null
              ? null
              : IOTDeviceInfoModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PagedListIOTDeviceInfoModelToJson(
        PagedListIOTDeviceInfoModel instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects
    };
