// To parse this JSON data, do
//
//     final addUserModel = addUserModelFromJson(jsonString);

import 'dart:convert';

AddUserModel addUserModelFromJson(String str) => AddUserModel.fromJson(json.decode(str));

String addUserModelToJson(AddUserModel data) => json.encode(data.toJson());

class AddUserModel {
  String? email;
  String? phone;
  String? name;
  String? image;

  AddUserModel({
    this.email,
    this.phone,
    this.name,
    this.image,
  });

  factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
    email: json["email"],
    phone: json["phone"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
    "name": name,
    "image": image,
  };
}
