// To parse this JSON data, do
//
//     final userSplitCashbackResponse = userSplitCashbackResponseFromMap(jsonString);
 
import 'dart:convert';

UserSplitCashbackResponse userSplitCashbackResponseFromMap(
        String str) =>
    UserSplitCashbackResponse.fromMap(json.decode(str));

String userSplitCashbackResponseToMap(
        UserSplitCashbackResponse data) =>
    json.encode(data.toMap());

class UserSplitCashbackResponse {
  bool success;
  dynamic payload;
  String message;

  UserSplitCashbackResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserSplitCashbackResponse.fromMap(Map<String, dynamic> json) =>
      UserSplitCashbackResponse(
        success: json["success"],
        payload: json["payload"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload,
        "message": message,
      };
}
