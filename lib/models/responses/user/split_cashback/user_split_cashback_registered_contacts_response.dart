// To parse this JSON data, do
//
//     final userSplitCashbackRegisteredContactsResponse = userSplitCashbackRegisteredContactsResponseFromJson(jsonString);

import 'dart:convert';

UserSplitCashbackRegisteredContactsResponse
    userSplitCashbackRegisteredContactsResponseFromJson(String str) =>
        UserSplitCashbackRegisteredContactsResponse.fromJson(json.decode(str));

String userSplitCashbackRegisteredContactsResponseToJson(
        UserSplitCashbackRegisteredContactsResponse data) =>
    json.encode(data.toJson());

class UserSplitCashbackRegisteredContactsResponse {
  bool success;
  List<RegisteredContact> payload;

  UserSplitCashbackRegisteredContactsResponse({
    required this.success,
    required this.payload,
  });

  factory UserSplitCashbackRegisteredContactsResponse.fromJson(
          Map<String, dynamic> json) =>
      UserSplitCashbackRegisteredContactsResponse(
        success: json["success"],
        payload: List<RegisteredContact>.from(
            json["payload"].map((x) => RegisteredContact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
      };
}

class RegisteredContact {
  int id;
  String name;
  String phone;
  bool isSelected;

  RegisteredContact({
    required this.id,
    required this.name,
    required this.phone,
    required this.isSelected,
  });

  factory RegisteredContact.fromJson(Map<String, dynamic> json) =>
      RegisteredContact(
          id: json["id"],
          name: json["name"],
          phone: json["phone"],
          isSelected: false);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "phone": phone, "isSelected": isSelected};
}
