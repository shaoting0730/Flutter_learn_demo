// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowingRequestSurveyQuestionOptionsModel
    _$ShowingRequestSurveyQuestionOptionsModelFromJson(
        Map<String, dynamic> json) {
  return ShowingRequestSurveyQuestionOptionsModel(
      QuestionOptionId: json['QuestionOptionId'] as int,
      QuestionOption: json['QuestionOption'] as String,
      IsSelected: json['IsSelected'] as bool);
}

Map<String, dynamic> _$ShowingRequestSurveyQuestionOptionsModelToJson(
        ShowingRequestSurveyQuestionOptionsModel instance) =>
    <String, dynamic>{
      'QuestionOptionId': instance.QuestionOptionId,
      'QuestionOption': instance.QuestionOption,
      'IsSelected': instance.IsSelected
    };

ShowingRequestSurveyQuestionsModel _$ShowingRequestSurveyQuestionsModelFromJson(
    Map<String, dynamic> json) {
  return ShowingRequestSurveyQuestionsModel(
      Guid: json['Guid'] as String,
      ShowingRequestSurveyGuid: json['ShowingRequestSurveyGuid'] as String,
      QuestionType: json['QuestionType'] as int,
      SurveyQuestionGuid: json['SurveyQuestionGuid'] as String,
      QuestionSubject: json['QuestionSubject'] as String,
      QuestionId: json['QuestionId'] as int,
      OptionList: (json['OptionList'] as List)
          ?.map((e) => e == null
              ? null
              : ShowingRequestSurveyQuestionOptionsModel.fromJson(
                  e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ShowingRequestSurveyQuestionsModelToJson(
        ShowingRequestSurveyQuestionsModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'ShowingRequestSurveyGuid': instance.ShowingRequestSurveyGuid,
      'QuestionType': instance.QuestionType,
      'SurveyQuestionGuid': instance.SurveyQuestionGuid,
      'QuestionSubject': instance.QuestionSubject,
      'QuestionId': instance.QuestionId,
      'OptionList': instance.OptionList
    };

ShowingRequestSurveyModel _$ShowingRequestSurveyModelFromJson(
    Map<String, dynamic> json) {
  return ShowingRequestSurveyModel(
      Guid: json['Guid'] as String,
      Description: json['Description'] as String,
      ShowingRequestGuid: json['ShowingRequestGuid'] as String,
      SurveyStatus: json['SurveyStatus'] as int,
      QuestionList: (json['QuestionList'] as List)
          ?.map((e) => e == null
              ? null
              : ShowingRequestSurveyQuestionsModel.fromJson(
                  e as Map<String, dynamic>))
          ?.toList(),
      ShowingRequest: json['ShowingRequest'] == null
          ? null
          : ShowingRequestModel.fromJson(
              json['ShowingRequest'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ShowingRequestSurveyModelToJson(
        ShowingRequestSurveyModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'Description': instance.Description,
      'ShowingRequestGuid': instance.ShowingRequestGuid,
      'SurveyStatus': instance.SurveyStatus,
      'QuestionList': instance.QuestionList,
      'ShowingRequest': instance.ShowingRequest
    };

ShowingRequestSurveyAnswerModel _$ShowingRequestSurveyAnswerModelFromJson(
    Map<String, dynamic> json) {
  return ShowingRequestSurveyAnswerModel(
      ShowingRequestSurveyGuid: json['ShowingRequestSurveyGuid'] as String,
      QuestionAnswers: (json['QuestionAnswers'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, (e as List)?.map((e) => e as String)?.toList()),
      ));
}

Map<String, dynamic> _$ShowingRequestSurveyAnswerModelToJson(
        ShowingRequestSurveyAnswerModel instance) =>
    <String, dynamic>{
      'ShowingRequestSurveyGuid': instance.ShowingRequestSurveyGuid,
      'QuestionAnswers': instance.QuestionAnswers
    };

ShowingAutoConfirmSettingModel _$ShowingAutoConfirmSettingModelFromJson(
    Map<String, dynamic> json) {
  return ShowingAutoConfirmSettingModel(
      Guid: json['Guid'] as String,
      HouseGuid: json['HouseGuid'] as String,
      DateType: json['DateType'] as int,
      WeekDay: json['WeekDay'] as String,
      SpecialStartDate: json['SpecialStartDate'] as int,
      SpecialEndDate: json['SpecialEndDate'] as int,
      StartTime: json['StartTime'] as int,
      EndTime: json['EndTime'] as int,
      EnableRule: json['EnableRule'] as bool);
}

Map<String, dynamic> _$ShowingAutoConfirmSettingModelToJson(
        ShowingAutoConfirmSettingModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'HouseGuid': instance.HouseGuid,
      'DateType': instance.DateType,
      'WeekDay': instance.WeekDay,
      'SpecialStartDate': instance.SpecialStartDate,
      'SpecialEndDate': instance.SpecialEndDate,
      'StartTime': instance.StartTime,
      'EndTime': instance.EndTime,
      'EnableRule': instance.EnableRule
    };

HouseNewsLetterRequest _$HouseNewsLetterRequestFromJson(
    Map<String, dynamic> json) {
  return HouseNewsLetterRequest(
      MLSNumber: json['MLSNumber'] as String,
      Title: json['Title'] as String,
      Content: json['Content'] as String,
      Method: json['Method'] as int);
}

Map<String, dynamic> _$HouseNewsLetterRequestToJson(
        HouseNewsLetterRequest instance) =>
    <String, dynamic>{
      'MLSNumber': instance.MLSNumber,
      'Title': instance.Title,
      'Content': instance.Content,
      'Method': instance.Method
    };

ImpersonateBookingRequest _$ImpersonateBookingRequestFromJson(
    Map<String, dynamic> json) {
  return ImpersonateBookingRequest(
      Email: json['Email'] as String,
      VerificationCode: json['VerificationCode'] as String,
      OfficePhone: json['OfficePhone'] as String,
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      MLSLoginID: json['MLSLoginID'] as String,
      MLSOfficeID: json['MLSOfficeID'] as String,
      ShowingRequest: json['ShowingRequest'] == null
          ? null
          : ShowingProfileModel.fromJson(
              json['ShowingRequest'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ImpersonateBookingRequestToJson(
        ImpersonateBookingRequest instance) =>
    <String, dynamic>{
      'Email': instance.Email,
      'VerificationCode': instance.VerificationCode,
      'OfficePhone': instance.OfficePhone,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'MLSLoginID': instance.MLSLoginID,
      'MLSOfficeID': instance.MLSOfficeID,
      'ShowingRequest': instance.ShowingRequest
    };

BadgeDisplayModel _$BadgeDisplayModelFromJson(Map<String, dynamic> json) {
  return BadgeDisplayModel(
      UnreadMessage: json['UnreadMessage'] as int,
      UnreadApprovalMessage: json['UnreadApprovalMessage'] as int,
      UnreadRequestMessage: json['UnreadRequestMessage'] as int);
}

Map<String, dynamic> _$BadgeDisplayModelToJson(BadgeDisplayModel instance) =>
    <String, dynamic>{
      'UnreadMessage': instance.UnreadMessage,
      'UnreadApprovalMessage': instance.UnreadApprovalMessage,
      'UnreadRequestMessage': instance.UnreadRequestMessage
    };

PagedListShowingProfileModel _$PagedListShowingProfileModelFromJson(
    Map<String, dynamic> json) {
  return PagedListShowingProfileModel(
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int,
      TotalCount: json['TotalCount'] as int,
      ListObjects: (json['ListObjects'] as List)
          ?.map((e) => e == null
              ? null
              : ShowingProfileModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PagedListShowingProfileModelToJson(
        PagedListShowingProfileModel instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects
    };

PagedListShowingRequestModel _$PagedListShowingRequestModelFromJson(
    Map<String, dynamic> json) {
  return PagedListShowingRequestModel(
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int,
      TotalCount: json['TotalCount'] as int,
      ListObjects: (json['ListObjects'] as List)
          ?.map((e) => e == null
              ? null
              : ShowingRequestModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PagedListShowingRequestModelToJson(
        PagedListShowingRequestModel instance) =>
    <String, dynamic>{
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'TotalCount': instance.TotalCount,
      'ListObjects': instance.ListObjects
    };

ShowingProfileSearch _$ShowingProfileSearchFromJson(Map<String, dynamic> json) {
  return ShowingProfileSearch(
      Guid: json['Guid'] as String,
      StoreCustomerGuid: json['StoreCustomerGuid'] as String,
      CustomerName: json['CustomerName'] as String,
      ProfileName: json['ProfileName'] as String,
      PhoneNumber: json['PhoneNumber'] as String,
      Email: json['Email'] as String,
      StartUpdateTime: json['StartUpdateTime'] as int,
      EndUpdateTime: json['EndUpdateTime'] as int,
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int,
      WithDetails: json['WithDetails'] as bool);
}

Map<String, dynamic> _$ShowingProfileSearchToJson(
        ShowingProfileSearch instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'CustomerName': instance.CustomerName,
      'ProfileName': instance.ProfileName,
      'PhoneNumber': instance.PhoneNumber,
      'Email': instance.Email,
      'StartUpdateTime': instance.StartUpdateTime,
      'EndUpdateTime': instance.EndUpdateTime,
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize,
      'WithDetails': instance.WithDetails
    };

ShowingProfileModel _$ShowingProfileModelFromJson(Map<String, dynamic> json) {
  return ShowingProfileModel(
      Guid: json['Guid'] as String,
      CustomerName: json['CustomerName'] as String,
      ProfileName: json['ProfileName'] as String,
      PhoneNumber: json['PhoneNumber'] as String,
      Email: json['Email'] as String,
      SearchCriteria: json['SearchCriteria'] as String,
      CreatedOn: json['CreatedOn'] as int,
      UpdatedOn: json['UpdatedOn'] as int,
      ShowingDetails: (json['ShowingDetails'] as List)
          ?.map((e) => e == null
              ? null
              : ShowingRequestModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      TotalShowingRequests: json['TotalShowingRequests'] as int);
}

Map<String, dynamic> _$ShowingProfileModelToJson(
        ShowingProfileModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'CustomerName': instance.CustomerName,
      'ProfileName': instance.ProfileName,
      'PhoneNumber': instance.PhoneNumber,
      'Email': instance.Email,
      'SearchCriteria': instance.SearchCriteria,
      'CreatedOn': instance.CreatedOn,
      'UpdatedOn': instance.UpdatedOn,
      'ShowingDetails': instance.ShowingDetails,
      'TotalShowingRequests': instance.TotalShowingRequests
    };

ShowingScheduleSearch _$ShowingScheduleSearchFromJson(
    Map<String, dynamic> json) {
  return ShowingScheduleSearch(
      Guid: json['Guid'] as String,
      StoreCustomerGuid: json['StoreCustomerGuid'] as String,
      MLSNumber: json['MLSNumber'] as String,
      HouseProductGuid: json['HouseProductGuid'] as String,
      DeviceQRCode: json['DeviceQRCode'] as String,
      DeviceMACAddress: json['DeviceMACAddress'] as String,
      RequestStatus: json['RequestStatus'] as int,
      ShowingProfileGuid: json['ShowingProfileGuid'] as String,
      StartCreateTime: json['StartCreateTime'] as int,
      EndCreateTime: json['EndCreateTime'] as int,
      OrderBy: json['OrderBy'] as String,
      SortBy: json['SortBy'] as String,
      PageIndex: json['PageIndex'] as int,
      PageSize: json['PageSize'] as int);
}

Map<String, dynamic> _$ShowingScheduleSearchToJson(
        ShowingScheduleSearch instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'StoreCustomerGuid': instance.StoreCustomerGuid,
      'MLSNumber': instance.MLSNumber,
      'HouseProductGuid': instance.HouseProductGuid,
      'DeviceQRCode': instance.DeviceQRCode,
      'DeviceMACAddress': instance.DeviceMACAddress,
      'RequestStatus': instance.RequestStatus,
      'ShowingProfileGuid': instance.ShowingProfileGuid,
      'StartCreateTime': instance.StartCreateTime,
      'EndCreateTime': instance.EndCreateTime,
      'OrderBy': instance.OrderBy,
      'SortBy': instance.SortBy,
      'PageIndex': instance.PageIndex,
      'PageSize': instance.PageSize
    };

ShowingRequestModel _$ShowingRequestModelFromJson(Map<String, dynamic> json) {
  return ShowingRequestModel(
      Guid: json['Guid'] as String,
      ProductGuid: json['ProductGuid'] as String,
      MLSNumber: json['MLSNumber'] as String,
      DeviceMACAddress: json['DeviceMACAddress'] as String,
      RequestStatus: json['RequestStatus'] as int,
      ScheduledStartTime: json['ScheduledStartTime'] as int,
      ScheduledEndTime: json['ScheduledEndTime'] as int,
      OpenBoxTime1: json['OpenBoxTime1'] as int,
      CloseBoxTime1: json['CloseBoxTime1'] as int,
      OpenBoxTime2: json['OpenBoxTime2'] as int,
      CloseBoxTime2: json['CloseBoxTime2'] as int,
      FeedBack: json['FeedBack'] as String,
      ChangeReason: json['ChangeReason'] as String,
      PriceEstimation: (json['PriceEstimation'] as num)?.toDouble(),
      AddressText: json['AddressText'] as String,
      ClientName: json['ClientName'] as String,
      BuyerAgentName: json['BuyerAgentName'] as String,
      DeviceToken: json['DeviceToken'] == null
          ? null
          : IoTDeviceTokenModel.fromJson(
              json['DeviceToken'] as Map<String, dynamic>),
      HouseInfo: json['HouseInfo'] == null
          ? null
          : HouseProductModel.fromJson(
              json['HouseInfo'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ShowingRequestModelToJson(
        ShowingRequestModel instance) =>
    <String, dynamic>{
      'Guid': instance.Guid,
      'ProductGuid': instance.ProductGuid,
      'MLSNumber': instance.MLSNumber,
      'DeviceMACAddress': instance.DeviceMACAddress,
      'RequestStatus': instance.RequestStatus,
      'ScheduledStartTime': instance.ScheduledStartTime,
      'ScheduledEndTime': instance.ScheduledEndTime,
      'OpenBoxTime1': instance.OpenBoxTime1,
      'CloseBoxTime1': instance.CloseBoxTime1,
      'OpenBoxTime2': instance.OpenBoxTime2,
      'CloseBoxTime2': instance.CloseBoxTime2,
      'FeedBack': instance.FeedBack,
      'ChangeReason': instance.ChangeReason,
      'PriceEstimation': instance.PriceEstimation,
      'AddressText': instance.AddressText,
      'ClientName': instance.ClientName,
      'BuyerAgentName': instance.BuyerAgentName,
      'DeviceToken': instance.DeviceToken,
      'HouseInfo': instance.HouseInfo
    };
