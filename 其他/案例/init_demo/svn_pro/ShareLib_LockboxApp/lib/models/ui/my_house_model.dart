import './plan_model.dart';
import '../showing.dart';
import '../iotdevice.dart';

class MyHouseModel {

  HouseModel houseModel;
  List<ShowingRequestModel> showingRequestModels;
  List<ShowingRequestModel> showingMessageList;
  List<LockBoxDeviceOpenRecordModel> openRecordList;
  List<ShowingAutoConfirmSettingModel> showingAutoConfirmSettingList;

  MyHouseModel({this.houseModel, this.showingRequestModels, this.showingMessageList, this.openRecordList, this.showingAutoConfirmSettingList});
}





