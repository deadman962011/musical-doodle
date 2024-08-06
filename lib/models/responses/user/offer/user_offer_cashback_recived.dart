// To parse this JSON data, do
//
//     final userOfferCashbackRecived = userOfferCashbackRecivedFromJson(jsonString);

import 'dart:convert';

UserOfferCashbackRecived userOfferCashbackRecivedFromJson(String str) => UserOfferCashbackRecived.fromJson(json.decode(str));

String userOfferCashbackRecivedToJson(UserOfferCashbackRecived data) => json.encode(data.toJson());

class UserOfferCashbackRecived {
    bool success;
    Payload payload;
    String message;

    UserOfferCashbackRecived({
        required this.success,
        required this.payload,
        required this.message,
    });

    factory UserOfferCashbackRecived.fromJson(Map<String, dynamic> json) => UserOfferCashbackRecived(
        success: json["success"],
        payload: Payload.fromJson(json["payload"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "payload": payload.toJson(),
        "message": message,
    };
}

class Payload {
    int amount;
    bool hasCoupon;

    Payload({
        required this.amount,
        required this.hasCoupon,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        amount: json["amount"],
        hasCoupon: json["hasCoupon"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "hasCoupon": hasCoupon,
    };
}
