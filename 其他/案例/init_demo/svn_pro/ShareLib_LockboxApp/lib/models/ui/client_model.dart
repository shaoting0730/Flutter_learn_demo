import '../showing.dart';

class ClientModel {
  String name;
  String phone;
  String email;
  List<ShowingRequestModel> records;
  ClientModel({this.name, this.phone, this.email, this.records});
}

ClientModel ShowingProfileModelToClientModel(ShowingProfileModel model) {
  var result = ClientModel(
    email: "",
    phone: "",
    name: model.ProfileName,
    records: model.ShowingDetails
  );
  return result;
}

class MyClientRecordCellModel {
  int type;
  ShowingRequestModel model;
  String datetime;

  MyClientRecordCellModel({this.type, this.model, this.datetime});
}