import '../iotdevice.dart';

class LockerInfo {
  String address;
  bool isInterview;
  String thumbnail;

  LockerInfo({
    this.address,
    this.isInterview = true,
    this.thumbnail
  });
}


LockerInfo IOTDeviceRequestModelToLockerInfo(IOTDeviceRequestModel model) {
  return LockerInfo(address: '', isInterview: model.RequestType == 1);
}
