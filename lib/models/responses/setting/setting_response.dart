import 'dart:convert';

SettingResponse settingResponseFromJson(String str) =>
    SettingResponse.fromJson(json.decode(str));

class SettingResponse {
  SettingResponse({required this.success, required this.value});

  bool success;
  String value;

  factory SettingResponse.fromJson(Map<String, dynamic> json) =>
      SettingResponse(success: json["success"], value: json['payload']);
}
