
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.userName,
    this.status,
  });

  String? userName;
  bool? status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["userName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "status": status,
  };
}
