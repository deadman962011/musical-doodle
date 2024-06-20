// To parse this JSON data, do
//
//     final merchantStaffResponse = merchantStaffResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantStaffResponse merchantStaffResponseFromMap(String str) =>
    MerchantStaffResponse.fromMap(json.decode(str));

String merchantStaffResponseToMap(MerchantStaffResponse data) =>
    json.encode(data.toMap());

class MerchantStaffResponse {
  bool success;
  Payload payload;
  String message;

  MerchantStaffResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantStaffResponse.fromMap(Map<String, dynamic> json) =>
      MerchantStaffResponse(
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
  List<MerchantStaffItem> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
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
        data: List<MerchantStaffItem>.from(
            json["data"].map((x) => MerchantStaffItem.fromMap(x))),
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

class MerchantStaffItem {
  int id;
  String name;
  String email;
  MerchantStaffRole role;

  MerchantStaffItem({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory MerchantStaffItem.fromMap(Map<String, dynamic> json) =>
      MerchantStaffItem(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: MerchantStaffRole.fromMap(json["role"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role.toMap(),
      };
}

class MerchantStaffRole {
  int id;
  String name;

  MerchantStaffRole({
    required this.id,
    required this.name,
  });

  factory MerchantStaffRole.fromMap(Map<String, dynamic> json) =>
      MerchantStaffRole(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
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
