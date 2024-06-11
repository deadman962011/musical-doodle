import 'package:com.mybill.app/models/responses/zone/all_zones_response.dart';
import 'package:com.mybill.app/models/responses/zone/zone_districts_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

class ZoneRepository {
  Future<dynamic> getAllZonesResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/zone");
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
      },
    );
    AppConfig.alice.onHttpResponse(response, body: null);
    if (response.statusCode == 200) {
      return allZonesResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getZoneDistrictsResponse(@required int zoneId) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/zone/${zoneId}/districts");
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
      },
    );
    AppConfig.alice.onHttpResponse(response, body: null);
    if (response.statusCode == 200) {
      return zoneDistrictsResponseFromMap(response.body);
    } else {
      return false;
    }
  }
}
