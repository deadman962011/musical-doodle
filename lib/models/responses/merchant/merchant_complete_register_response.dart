import 'dart:convert';

MerchantCompleteRegisterResponse merchantCompleteRegisterResponseFromJson(String str) => MerchantCompleteRegisterResponse.fromJson(json.decode(str));

class MerchantCompleteRegisterResponse {
  MerchantCompleteRegisterResponse({
    required this.success,
  });

  bool success;

  factory MerchantCompleteRegisterResponse.fromJson(Map<String, dynamic> json) => MerchantCompleteRegisterResponse(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}

