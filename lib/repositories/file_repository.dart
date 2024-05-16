import 'dart:convert';

import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/file/file_upload_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FileRepository {
  Future<dynamic> getFileUploadResponse(
      @required String image, @required String filename) async {
    var post_body = jsonEncode({"image": "${image}", "filename": "$filename"});
    Uri url = Uri.parse("${AppConfig.BASE_URL}/file");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
        },
        body: post_body);
    if (response.statusCode == 200) {
      return fileUploadResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
