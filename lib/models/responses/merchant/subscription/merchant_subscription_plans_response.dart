// To parse this JSON data, do
//
//     final merchantSubscriptionPlansResponse = merchantSubscriptionPlansResponseFromJson(jsonString);

import 'dart:convert';

MerchantSubscriptionPlansResponse merchantSubscriptionPlansResponseFromJson(String str) => MerchantSubscriptionPlansResponse.fromJson(json.decode(str));

String merchantSubscriptionPlansResponseToJson(MerchantSubscriptionPlansResponse data) => json.encode(data.toJson());

class MerchantSubscriptionPlansResponse {
    bool success;
    List<MerchantSubscriptionPlan> payload;
    String message;

    MerchantSubscriptionPlansResponse({
        required this.success,
        required this.payload,
        required this.message,
    });

    factory MerchantSubscriptionPlansResponse.fromJson(Map<String, dynamic> json) => MerchantSubscriptionPlansResponse(
        success: json["success"],
        payload: List<MerchantSubscriptionPlan>.from(json["payload"].map((x) => MerchantSubscriptionPlan.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
        "message": message,
    };
}

class MerchantSubscriptionPlan {
    int id;
    String name;
    int price;
    int duration;

    MerchantSubscriptionPlan({
        required this.id,
        required this.name,
        required this.price,
        required this.duration,
    });

    factory MerchantSubscriptionPlan.fromJson(Map<String, dynamic> json) => MerchantSubscriptionPlan(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        duration: json["duration"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "duration": duration,
    };
}
