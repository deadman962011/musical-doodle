import 'dart:convert';

MerchantUpdateLogoResponse merchantUpdateLogoResponseFromJson(String str) =>
    MerchantUpdateLogoResponse.fromJson(json.decode(str));

class MerchantUpdateLogoResponse {
  MerchantUpdateLogoResponse({required this.success, required this.path});

  bool success;
  String path;

  factory MerchantUpdateLogoResponse.fromJson(Map<String, dynamic> json) =>
      MerchantUpdateLogoResponse(success: json["success"], path: json['path']);

  Map<String, dynamic> toJson() => {"success": success, "path": path};
}
