import 'iotdevice.dart';
import 'houseproduct.dart';
import 'package:json_annotation/json_annotation.dart';
/////flutter packages pub run build_runner build  --delete-conflicting-outputs
part 'showing.g.dart';


@JsonSerializable()
class ShowingRequestSurveyQuestionOptionsModel
{
  int QuestionOptionId;
  String QuestionOption;
  bool IsSelected;

  factory ShowingRequestSurveyQuestionOptionsModel.fromJson(Map<String, dynamic> json) => _$ShowingRequestSurveyQuestionOptionsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShowingRequestSurveyQuestionOptionsModelToJson(this);

  ShowingRequestSurveyQuestionOptionsModel({
    this.QuestionOptionId,
    this.QuestionOption,
    this.IsSelected,
  });

}

@JsonSerializable()
class ShowingRequestSurveyQuestionsModel
{
  String Guid;
  String ShowingRequestSurveyGuid;
  int QuestionType;
  String SurveyQuestionGuid;
  String QuestionSubject;
  int QuestionId;
  List<ShowingRequestSurveyQuestionOptionsModel> OptionList;

  factory ShowingRequestSurveyQuestionsModel.fromJson(Map<String, dynamic> json) => _$ShowingRequestSurveyQuestionsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShowingRequestSurveyQuestionsModelToJson(this);

  ShowingRequestSurveyQuestionsModel({
    this.Guid,
    this.ShowingRequestSurveyGuid,
    this.QuestionType,
    this.SurveyQuestionGuid,
    this.QuestionSubject,
    this.QuestionId,
    this.OptionList,
  });

}
@JsonSerializable()
class ShowingRequestSurveyModel
{
  String Guid;
  String Description;
  String ShowingRequestGuid;
  int SurveyStatus = 0;
  List<ShowingRequestSurveyQuestionsModel> QuestionList;
  ShowingRequestModel ShowingRequest;

  factory ShowingRequestSurveyModel.fromJson(Map<String, dynamic> json) => _$ShowingRequestSurveyModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShowingRequestSurveyModelToJson(this);

  ShowingRequestSurveyModel({
    this.Guid,
    this.Description,
    this.ShowingRequestGuid,
    this.SurveyStatus,
    this.QuestionList,
    this.ShowingRequest,
  });

}

@JsonSerializable()
class ShowingRequestSurveyAnswerModel
{
  String ShowingRequestSurveyGuid;
  Map<String, List<String>> QuestionAnswers;

  factory ShowingRequestSurveyAnswerModel.fromJson(Map<String, dynamic> json) => _$ShowingRequestSurveyAnswerModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShowingRequestSurveyAnswerModelToJson(this);

  ShowingRequestSurveyAnswerModel({
    this.ShowingRequestSurveyGuid,
    this.QuestionAnswers,
  });

}


@JsonSerializable()
class ShowingAutoConfirmSettingModel
{
  String Guid;
  String HouseGuid;
  int DateType = 0;
  String WeekDay;
  int SpecialStartDate = 0;
  int SpecialEndDate = 0;
  int StartTime = 0;
  int EndTime = 0;
  bool EnableRule;

  factory ShowingAutoConfirmSettingModel.fromJson(Map<String, dynamic> json) => _$ShowingAutoConfirmSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShowingAutoConfirmSettingModelToJson(this);

  ShowingAutoConfirmSettingModel({
    this.Guid,
    this.HouseGuid,
    this.DateType,
    this.WeekDay,
    this.SpecialStartDate,
    this.SpecialEndDate,
    this.StartTime,
    this.EndTime,
    this.EnableRule,
  });

}

@JsonSerializable()
class HouseNewsLetterRequest
{
  String MLSNumber;
  String Title;
  String Content;
  int Method;

  factory HouseNewsLetterRequest.fromJson(Map<String, dynamic> json) => _$HouseNewsLetterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$HouseNewsLetterRequestToJson(this);

  HouseNewsLetterRequest({
    this.MLSNumber,
    this.Title,
    this.Content,
    this.Method,
  });

}

@JsonSerializable()
class ImpersonateBookingRequest
{
  String Email;
  String VerificationCode;
  String OfficePhone;
  String FirstName;
  String LastName;
  String MLSLoginID;
  String MLSOfficeID;
  ShowingProfileModel ShowingRequest;

  factory ImpersonateBookingRequest.fromJson(Map<String, dynamic> json) => _$ImpersonateBookingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ImpersonateBookingRequestToJson(this);

  ImpersonateBookingRequest({
    this.Email,
    this.VerificationCode,
    this.OfficePhone,
    this.FirstName,
    this.LastName,
    this.MLSLoginID,
    this.MLSOfficeID,
    this.ShowingRequest,
  });

}

@JsonSerializable()
class BadgeDisplayModel
{
  int UnreadMessage;
  int UnreadApprovalMessage;
  int UnreadRequestMessage;

  factory BadgeDisplayModel.fromJson(Map<String, dynamic> json) => _$BadgeDisplayModelFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeDisplayModelToJson(this);

  BadgeDisplayModel({
    this.UnreadMessage,
    this.UnreadApprovalMessage,
    this.UnreadRequestMessage,
  });

}

@JsonSerializable()
class PagedListShowingProfileModel
{
  int PageIndex;
  int PageSize;
  int TotalCount;
  List<ShowingProfileModel> ListObjects;

  factory PagedListShowingProfileModel.fromJson(Map<String, dynamic> json) => _$PagedListShowingProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$PagedListShowingProfileModelToJson(this);

  PagedListShowingProfileModel({
    this.PageIndex,
    this.PageSize,
    this.TotalCount,
    this.ListObjects
  });

}
@JsonSerializable()
class PagedListShowingRequestModel
{
  int PageIndex;
  int PageSize;
  int TotalCount;
  List<ShowingRequestModel> ListObjects;

  factory PagedListShowingRequestModel.fromJson(Map<String, dynamic> json) => _$PagedListShowingRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$PagedListShowingRequestModelToJson(this);

  PagedListShowingRequestModel({
    this.PageIndex,
    this.PageSize,
    this.TotalCount,
    this.ListObjects
  });

}
@JsonSerializable()
class ShowingProfileSearch
{
  String Guid;
  String StoreCustomerGuid;
  String CustomerName;
  String ProfileName;
  String PhoneNumber;
  String Email;
  int StartUpdateTime;
  int EndUpdateTime;
  int PageIndex;
  int PageSize;
  bool WithDetails;

  factory ShowingProfileSearch.fromJson(Map<String, dynamic> json) => _$ShowingProfileSearchFromJson(json);
  Map<String, dynamic> toJson() => _$ShowingProfileSearchToJson(this);

  ShowingProfileSearch({
    this.Guid,
    this.StoreCustomerGuid,
    this.CustomerName ,
    this.ProfileName,
    this.PhoneNumber,
    this.Email,
    this.StartUpdateTime = 0,
    this.EndUpdateTime = 0,
    this.PageIndex = 0,
    this.PageSize = 100,
    this.WithDetails = false,
  });

}
@JsonSerializable()
class ShowingProfileModel
{
  String Guid;
  String CustomerName;
  String ProfileName;
  String PhoneNumber;
  String Email;
  String SearchCriteria;
  int CreatedOn;
  int UpdatedOn;
  List<ShowingRequestModel> ShowingDetails;
  int TotalShowingRequests;

  factory ShowingProfileModel.fromJson(Map<String, dynamic> json) => _$ShowingProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShowingProfileModelToJson(this);

  ShowingProfileModel({
    this.Guid,
    this.CustomerName,
    this.ProfileName,
    this.PhoneNumber,
    this.Email,
    this.SearchCriteria,
    this.CreatedOn = 0,
    this.UpdatedOn = 0,
    this.ShowingDetails,
    this.TotalShowingRequests = 0
  });

}
@JsonSerializable()
class ShowingScheduleSearch
{
  String Guid;
  String StoreCustomerGuid;
  String MLSNumber;
  String HouseProductGuid;
  String DeviceQRCode;
  String DeviceMACAddress;
  int RequestStatus;
  String ShowingProfileGuid;
  int StartCreateTime;
  int EndCreateTime;
  String OrderBy;
  String SortBy;
  int PageIndex;
  int PageSize;

  factory ShowingScheduleSearch.fromJson(Map<String, dynamic> json) => _$ShowingScheduleSearchFromJson(json);
  Map<String, dynamic> toJson() => _$ShowingScheduleSearchToJson(this);

  ShowingScheduleSearch({
    this.Guid,
    this.StoreCustomerGuid,
    this.MLSNumber,
    this.HouseProductGuid,
    this.DeviceQRCode,
    this.DeviceMACAddress,
    this.RequestStatus,
    this.ShowingProfileGuid,
    this.StartCreateTime,
    this.EndCreateTime,
    this.OrderBy = 'startcreatetime',
    this.SortBy = 'desc',
    this.PageIndex,
    this.PageSize
  });

}
@JsonSerializable()
class ShowingRequestModel
{
  String Guid;
  String ProductGuid;
  String MLSNumber;
  String DeviceMACAddress;
  int RequestStatus;
  int ScheduledStartTime;
  int ScheduledEndTime;
  int OpenBoxTime1;
  int CloseBoxTime1;
  int OpenBoxTime2;
  int CloseBoxTime2;
  String FeedBack;
  String ChangeReason;
  double PriceEstimation;
  String AddressText;
  String ClientName;
  String BuyerAgentName;
  IoTDeviceTokenModel DeviceToken;
  HouseProductModel HouseInfo;

  factory ShowingRequestModel.fromJson(Map<String, dynamic> json) => _$ShowingRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShowingRequestModelToJson(this);

  ShowingRequestModel({
    this.Guid,
    this.ProductGuid,
    this.MLSNumber,
    this.DeviceMACAddress,
    this.RequestStatus,
    this.ScheduledStartTime = 0,
    this.ScheduledEndTime = 0,
    this.OpenBoxTime1 = 0,
    this.CloseBoxTime1 = 0,
    this.OpenBoxTime2 = 0,
    this.CloseBoxTime2 = 0,
    this.FeedBack = "",
    this.ChangeReason = "",
    this.PriceEstimation = 0,
    this.AddressText,
    this.ClientName,
    this.BuyerAgentName,
    this.DeviceToken = null,
    this.HouseInfo  = null
  });

}
