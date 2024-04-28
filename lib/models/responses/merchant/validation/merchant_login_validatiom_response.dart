import 'dart:convert';




MerchantLoginValidationResponse merchantLoginValidationResponseFromJson(String str) => MerchantLoginValidationResponse.fromJson(json.decode(str));


String merchantValidationResponseToJson(MerchantLoginValidationResponse data) => json.encode(data.toJson());

class MerchantLoginValidationResponse {
  MerchantLoginValidationResponse({
    required this.message,
    required this.errors,
  });


  String message;
  Map<String,dynamic> errors;

  factory MerchantLoginValidationResponse.fromJson(Map<String, dynamic> json) => MerchantLoginValidationResponse(
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors,
  };
}