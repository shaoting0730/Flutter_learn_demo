import 'package:json_annotation/json_annotation.dart';
part 'iotdevice.g.dart';
/////flutter packages pub run build_runner build  --delete-conflicting-outputs

@JsonSerializable()
class LockBoxDeviceSharePasswordRequest
{
    String IoTDeviceGuid;
    String SharedToPhoneNumber;
    int StartDateTime;
    int EndDateTime;
    String LocalCode;
    factory LockBoxDeviceSharePasswordRequest.fromJson(Map<String, dynamic> json) => _$LockBoxDeviceSharePasswordRequestFromJson(json);
    Map<String, dynamic> toJson() => _$LockBoxDeviceSharePasswordRequestToJson(this);
    LockBoxDeviceSharePasswordRequest({
        this.IoTDeviceGuid,
        this.SharedToPhoneNumber,
        this.StartDateTime,
        this.EndDateTime,
        this.LocalCode,
    });
}

@JsonSerializable()
class LockBoxDeviceOpenRecordModel
{
    String Guid;
    String DeviceMACAddress;
    String DeviceQRCode;
    String MLSNumber;
    int DoorStatus;
    bool IsOpenHook;
    double Longitude;
    double Latitude;
    double PowerPercentage;
    String OpenedBy;
    String UpdatedBy;
    int UpdatedOn;
    factory LockBoxDeviceOpenRecordModel.fromJson(Map<String, dynamic> json) => _$LockBoxDeviceOpenRecordModelFromJson(json);
    Map<String, dynamic> toJson() => _$LockBoxDeviceOpenRecordModelToJson(this);

    LockBoxDeviceOpenRecordModel({
        this.Guid,
        this.DeviceMACAddress,
        this.DeviceQRCode,
        this.MLSNumber,
        this.DoorStatus,
        this.IsOpenHook,
        this.Longitude,
        this.Latitude,
        this.PowerPercentage,
        this.OpenedBy,
        this.UpdatedBy,
        this.UpdatedOn
    });
}
@JsonSerializable()
class LockBoxDevicePermissionTimeModel
{
    String Guid;
    int DateType;
    String WeekDay;
    int SpecialStartDate;
    int SpecialEndDate;
    int StartTime;
    int EndTime;
    bool EnableRule;

    factory LockBoxDevicePermissionTimeModel.fromJson(Map<String, dynamic> json) => _$LockBoxDevicePermissionTimeModelFromJson(json);
    Map<String, dynamic> toJson() => _$LockBoxDevicePermissionTimeModelToJson(this);

    LockBoxDevicePermissionTimeModel({
        this.Guid,
        this.DateType = 0,
        this.WeekDay = "0000000",
        this.SpecialStartDate = 0,
        this.SpecialEndDate = 0,
        this.StartTime = 0,
        this.EndTime = 0,
        this.EnableRule = true,
    });
}

@JsonSerializable()
class LockBoxDevicePermissionModel
{
    String IoTDeviceGuid;
    String DeviceName;
    String DeviceInfo;
    String SharedToPhoneNumber;
    String FirstName;
    String LastName;
    String AvatorLogoUrl;
    List<LockBoxDevicePermissionTimeModel> PermissionTimeList;

    factory LockBoxDevicePermissionModel.fromJson(Map<String, dynamic> json) => _$LockBoxDevicePermissionModelFromJson(json);
    Map<String, dynamic> toJson() => _$LockBoxDevicePermissionModelToJson(this);

    LockBoxDevicePermissionModel({
        this.IoTDeviceGuid,
        this.DeviceName="",
        this.DeviceInfo="",
        this.SharedToPhoneNumber,
        this.FirstName = "",
        this.LastName = "",
        this.AvatorLogoUrl = "",
        this.PermissionTimeList,
    });
}

@JsonSerializable()
class PagedListIOTDeviceRequestModel
{
    int PageIndex;
    int PageSize;
    int TotalCount;
    List<IOTDeviceRequestModel> ListObjects;

    factory PagedListIOTDeviceRequestModel.fromJson(Map<String, dynamic> json) => _$PagedListIOTDeviceRequestModelFromJson(json);
    Map<String, dynamic> toJson() => _$PagedListIOTDeviceRequestModelToJson(this);

    PagedListIOTDeviceRequestModel({
        this.PageIndex,
        this.PageSize,
        this.TotalCount,
        this.ListObjects
    });

}
@JsonSerializable()
class IOTDeviceRealTimeInfoModel
{
    String DeviceMACAddress;
    String DeviceUniqueId;
    double DeviceLongitude;
    double DeviceLatitude;
    int DoorStatus;
    double PowerPercentage;
    bool IsOpenHook;
    factory IOTDeviceRealTimeInfoModel.fromJson(Map<String, dynamic> json) => _$IOTDeviceRealTimeInfoModelFromJson(json);
    Map<String, dynamic> toJson() => _$IOTDeviceRealTimeInfoModelToJson(this);

    IOTDeviceRealTimeInfoModel({
        this.DeviceMACAddress,
        this.DeviceUniqueId,
        this.DeviceLongitude=0,
        this.DeviceLatitude=0,
        this.DoorStatus=0,
        this.PowerPercentage=0,
        this.IsOpenHook=false
    });

}
@JsonSerializable()
class IoTDeviceTokenModel
{
    String EncryptDeviceUniqueId;
    String Password;
    int ScheduledStartTime;
    int ScheduledEndTime;

    factory IoTDeviceTokenModel.fromJson(Map<String, dynamic> json) => _$IoTDeviceTokenModelFromJson(json);
    Map<String, dynamic> toJson() => _$IoTDeviceTokenModelToJson(this);

    IoTDeviceTokenModel({
        this.EncryptDeviceUniqueId,
        this.Password,
        this.ScheduledStartTime,
        this.ScheduledEndTime
    });

}
@JsonSerializable()
class IOTDeviceRequestModel
{
    String Guid;
    String DeviceMACAddress;
    String StoreCustomerGuid;
    String ContactName;
    String MLSNumber;
    int LockboxType;
    String Password;
    String AgentCode;
    String AgentStoreCustomerGuid;
    int RequestType;
    int PreferInstallDate;
    String InstalledLocation;
    double Longitude;
    double Latitude;
    String WorkPicture;
    int JobStatus;
    String InstallerName;
    String InstallerCode;
    IoTDeviceTokenModel DeviceToken;
    String DeviceQRCode;

    factory IOTDeviceRequestModel.fromJson(Map<String, dynamic> json) => _$IOTDeviceRequestModelFromJson(json);
    Map<String, dynamic> toJson() => _$IOTDeviceRequestModelToJson(this);

    IOTDeviceRequestModel({
        this.Guid,
        this.DeviceMACAddress,
        this.StoreCustomerGuid,
        this.ContactName,
        this.MLSNumber,
        this.LockboxType,
        this.Password,
        this.AgentCode,
        this.AgentStoreCustomerGuid,
        this.RequestType,
        this.PreferInstallDate,
        this.InstalledLocation,
        this.Longitude = 0,
        this.Latitude = 0,
        this.WorkPicture = "",
        this.JobStatus = 0,
        this.InstallerName = "",
        this.InstallerCode = "",
        this.DeviceToken,
        this.DeviceQRCode,
    });

}
@JsonSerializable()
class IOTDeviceRequestSearch
{
    String Guid;
    String DeviceMACAddress;
    String StoreCustomerGuid;
    String DeviceQRCode;
    String ContactName;
    String MLSNumber;
    String AgentCode;
    String AgentStoreCustomerGuid;
    int RequestType;
    double Longitude;
    double Latitude;
    int JobStatus;
    int PageIndex;
    int PageSize;

    factory IOTDeviceRequestSearch.fromJson(Map<String, dynamic> json) => _$IOTDeviceRequestSearchFromJson(json);
    Map<String, dynamic> toJson() => _$IOTDeviceRequestSearchToJson(this);

    IOTDeviceRequestSearch({
        this.Guid,
        this.DeviceMACAddress,
        this.StoreCustomerGuid,
        this.DeviceQRCode,
        this.ContactName,
        this.MLSNumber,
        this.AgentCode,
        this.AgentStoreCustomerGuid,
        this.RequestType = 0,
        this.Longitude = 0,
        this.Latitude = 0,
        this.JobStatus = 0,
        this.PageIndex = 0,
        this.PageSize = 100
    });
}

@JsonSerializable()
class IOTDeviceInfoModel
{
    String Guid;
    String MasterUserGuid;
    String MasterUserEmail;
    String MasterUserName;
    String DeviceQRCode;
    String DeviceMACAddress;
    String DeviceUniqueId;
    String DeviceName;
    String DeviceType;
    int DeviceTypeId;
    String Barcode;
    String Description;
    String LinkProductGuid;
    String DeviceRequesterGuid;
    String AccessInstruction;
    int TimeZoneMinutes;
    int CreatedOn;
    int UpdatedOn;

    factory IOTDeviceInfoModel.fromJson(Map<String, dynamic> json) => _$IOTDeviceInfoModelFromJson(json);
    Map<String, dynamic> toJson() => _$IOTDeviceInfoModelToJson(this);

    IOTDeviceInfoModel({
        this.Guid,
        this.MasterUserGuid,
        this.MasterUserEmail,
        this.MasterUserName,
        this.DeviceQRCode,
        this.DeviceMACAddress,
        this.DeviceUniqueId,
        this.DeviceName,
        this.DeviceType,
        this.DeviceTypeId,
        this.Barcode,
        this.Description,
        this.LinkProductGuid,
        this.TimeZoneMinutes,
        this.DeviceRequesterGuid,
        this.AccessInstruction = "",
        this.CreatedOn,
        this.UpdatedOn
    });

}
@JsonSerializable()
class IOTDeviceInfoSearch
{
    String Guid;
    String DeviceMACAddress;
    String DeviceQRCode;
    String DeviceName;
    String DeviceType;
    int DeviceTypeId;
    String Barcode;
    String Description;
    String LinkProductGuid;
    String MasterUserGuid;
    int SearchType;
    int PageIndex;
    int PageSize;

    factory IOTDeviceInfoSearch.fromJson(Map<String, dynamic> json) => _$IOTDeviceInfoSearchFromJson(json);
    Map<String, dynamic> toJson() => _$IOTDeviceInfoSearchToJson(this);

    IOTDeviceInfoSearch({
        this.Guid,
        this.DeviceMACAddress,
        this.DeviceQRCode,
        this.DeviceName,
        this.DeviceType,
        this.DeviceTypeId = 0,
        this.Barcode,
        this.Description,
        this.LinkProductGuid,
        this.MasterUserGuid,
        this.SearchType = 0,
        this.PageIndex,
        this.PageSize,
    });

}

@JsonSerializable()
class PagedListIOTDeviceInfoModel
{
    int PageIndex;
    int PageSize;
    int TotalCount;
    List<IOTDeviceInfoModel> ListObjects;

    factory PagedListIOTDeviceInfoModel.fromJson(Map<String, dynamic> json) => _$PagedListIOTDeviceInfoModelFromJson(json);
    Map<String, dynamic> toJson() => _$PagedListIOTDeviceInfoModelToJson(this);

    PagedListIOTDeviceInfoModel({
        this.PageIndex,
        this.PageSize,
        this.TotalCount,
        this.ListObjects,
    });

}