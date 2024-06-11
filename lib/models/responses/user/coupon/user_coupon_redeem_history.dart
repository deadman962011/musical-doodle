// To parse this JSON data, do
//
//     final userCouponRedeemHistoryResponse = userCouponRedeemHistoryResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserCouponRedeemHistoryResponse userCouponRedeemHistoryResponseFromMap(
        String str) =>
    UserCouponRedeemHistoryResponse.fromMap(json.decode(str));

String userCouponRedeemHistoryResponseToMap(
        UserCouponRedeemHistoryResponse data) =>
    json.encode(data.toMap());

class UserCouponRedeemHistoryResponse {
  bool success;
  Payload payload;
  String message;

  UserCouponRedeemHistoryResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserCouponRedeemHistoryResponse.fromMap(Map<String, dynamic> json) =>
      UserCouponRedeemHistoryResponse(
        success: json["success"],
        payload: Payload.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
        "message": message,
      };
}

class Payload {
  int currentPage;
  List<RedeemHistoryItem> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String? lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String path;
  int perPage;
  String? prevPageUrl;
  int to;
  int total;

  Payload({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        currentPage: json["current_page"],
        data: List<RedeemHistoryItem>.from(
            json["data"].map((x) => RedeemHistoryItem.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class RedeemHistoryItem {
  String couponName;
  String amount;
  DateTime redeemedAt;
  String state;

  RedeemHistoryItem({
    required this.couponName,
    required this.amount,
    required this.redeemedAt,
    required this.state,
  });

  factory RedeemHistoryItem.fromMap(Map<String, dynamic> json) =>
      RedeemHistoryItem(
        couponName: json["coupon_name"],
        amount: json["amount"],
        redeemedAt: DateTime.parse(json["redeemed_at"]),
        state: json["state"],
      );

  Map<String, dynamic> toMap() => {
        "coupon_name": couponName,
        "amount": amount,
        "redeemed_at": redeemedAt.toIso8601String(),
        "state": state,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
