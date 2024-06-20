import 'dart:convert';

MerchantUpdateMenuResponse merchantUpdateMenuResponseFromJson(String str) =>
    MerchantUpdateMenuResponse.fromJson(json.decode(str));

class MerchantUpdateMenuResponse {
  MerchantUpdateMenuResponse({required this.success, required this.path});

  bool success;
  String path;

  factory MerchantUpdateMenuResponse.fromJson(Map<String, dynamic> json) =>
      MerchantUpdateMenuResponse(success: json["success"], path: json['path']);

  Map<String, dynamic> toJson() => {"success": success, "path": path};
}
