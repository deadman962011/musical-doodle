import 'package:csh_app/models/responses/zone/all_zones_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csh_app/app_config.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';

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
    if (response.statusCode == 200) {
      return allZonesResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
