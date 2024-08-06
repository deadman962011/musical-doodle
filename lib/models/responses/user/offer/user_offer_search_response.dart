// To parse this JSON data, do
//
//     final userOfferSearchResponse = userOfferSearchResponseFromMap(jsonString);

import 'package:com.mybill.app/models/items/Offer.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

UserOfferSearchResponse userOfferSearchResponseFromMap(String str) =>
    UserOfferSearchResponse.fromMap(json.decode(str));

String userOfferSearchResponseToMap(UserOfferSearchResponse data) =>
    json.encode(data.toMap());

class UserOfferSearchResponse {
  bool success;
  Payload payload;

  UserOfferSearchResponse({
    required this.success,
    required this.payload,
  });

  factory UserOfferSearchResponse.fromMap(Map<String, dynamic> json) =>
      UserOfferSearchResponse(
        success: json["success"],
        payload: Payload.fromMap(json["payload"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
      };
}

class Payload {
  int currentPage;
  List<Offer> data;
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
        data: List<Offer>.from(json["data"].map((x) => Offer.fromJson(x))),
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
        "data": List<Offer>.from(data.map((x) => x.toJson())),
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
