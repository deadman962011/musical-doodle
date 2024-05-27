// To parse this JSON data, do
//
//     final userCouponsResponse = userCouponsResponseFromMap(jsonString);

import 'dart:convert';

UserCouponsResponse userCouponsResponseFromMap(String str) =>
    UserCouponsResponse.fromMap(json.decode(str));

String userCouponsResponseToMap(UserCouponsResponse data) =>
    json.encode(data.toMap());

class UserCouponsResponse {
  bool success;
  Payload payload;
  String message;

  UserCouponsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserCouponsResponse.fromMap(Map<String, dynamic> json) =>
      UserCouponsResponse(
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
  List<CouponMini> data;
  String firstPageUrl;
  int? from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int? to;
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
        data: List<CouponMini>.from(
            json["data"].map((x) => CouponMini.fromMap(x))),
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

class CouponMini {
  int id;
  String name;
  String thumbnail;

  CouponMini({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory CouponMini.fromMap(Map<String, dynamic> json) => CouponMini(
        id: json["id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
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
