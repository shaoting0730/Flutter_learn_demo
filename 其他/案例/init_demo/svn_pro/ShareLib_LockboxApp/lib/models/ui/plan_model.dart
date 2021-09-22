import 'package:intl/intl.dart';
import '../houseproduct.dart';
import '../showing.dart';
import '../iotdevice.dart';
import '../../service/serviceapi.dart';
import '../../models/loginmodel.dart';

enum PlanStatus {
  confirmed,
  waiting,
  timechanged,
  cancelled,
  completed,
  decline,
  none
}


class HouseModel {
  int selfScheduledStartTime;
  int selfScheduledEndTime;
  int messageCount;
  IOTDeviceInfoModel deviceInfo;
  HouseProductModel houseInfo;
  IoTDeviceTokenModel deviceToken;
  List<LockBoxDeviceOpenRecordModel> openRecordList;
  List<ShowingAutoConfirmSettingModel> showingAutoConfirmSettingList;
  List<ShowingRequestModel> showingRequestModels;
  ImpersonationorInfoModel houseOwner;

  HouseModel({this.deviceInfo, this.houseInfo, this.deviceToken, this.openRecordList, this.showingAutoConfirmSettingList,this.showingRequestModels, this.selfScheduledEndTime = 0, this.selfScheduledStartTime = 0, this.messageCount = 0});
}

class PlanModel {
  PlanStatus status;
  String date;
  String startAt;
  String endAt;
  String confirmedBy;
  HouseModel house;
  ShowingRequestModel ShowingRequest;
  bool isMyHouse;

  PlanModel({
    this.status,
    this.date,
    this.startAt,
    this.endAt,
    this.confirmedBy,
    this.house,
    this.ShowingRequest,
    this.isMyHouse = false
  });
}


HouseModel IOTDeviceHouseInfoModelToHouseModel(IOTDeviceHouseInfoModel productModel) {
  var houseModel = HouseModel();
  houseModel.houseInfo = productModel.HouseInfo;
  houseModel.deviceInfo = productModel.DeviceInfo;
  houseModel.deviceToken = productModel.DeviceToken;
  houseModel.openRecordList = productModel.OpenRecordList;
  houseModel.showingAutoConfirmSettingList = productModel.ShowingAutoConfirmSettingList;
  houseModel.showingRequestModels = productModel.ScheduledShowingRequestList;
  houseModel.houseOwner = productModel.HouseOwner;
  
  return houseModel;
}

PlanModel ShowingRequestModelToPlanModel(ShowingRequestModel requestModel) {
  var format = new DateFormat('E d/MM/y', 'en');
  var hourFormatter = DateFormat('HH:mm', 'en');
  PlanStatus status;
  if(requestModel.RequestStatus == 0) {
    status = PlanStatus.waiting;
  } else if (requestModel.RequestStatus == 1) {
    status = PlanStatus.confirmed;
  } else if(requestModel.RequestStatus == 2) {
    status = PlanStatus.decline;
  } else if(requestModel.RequestStatus == 3) {
    status = PlanStatus.timechanged;
  } else if(requestModel.RequestStatus == 4) {
    status = PlanStatus.cancelled;
  }
  IOTDeviceHouseInfoModel tmpModel = new IOTDeviceHouseInfoModel();
  tmpModel.HouseInfo = requestModel.HouseInfo;
  tmpModel.DeviceToken = requestModel.DeviceToken;
  var planModel = PlanModel(
    date: format.format(TicksToDateTime(requestModel.ScheduledStartTime)),
    startAt: hourFormatter.format(TicksToDateTime(requestModel.ScheduledStartTime)),
    endAt: hourFormatter.format(TicksToDateTime(requestModel.ScheduledEndTime)),
    confirmedBy: requestModel.ClientName,
    house: IOTDeviceHouseInfoModelToHouseModel(tmpModel),
    ShowingRequest: requestModel,
    status: status
  );

  planModel.house.selfScheduledStartTime = requestModel.ScheduledStartTime;
  planModel.house.selfScheduledEndTime = requestModel.ScheduledEndTime;

  return planModel;
}

