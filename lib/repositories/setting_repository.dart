import 'package:csh_app/models/responses/setting/setting_response.dart';
import 'package:http/http.dart' as http;
import 'package:csh_app/app_config.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';

class SettingRepository {
  Future<dynamic> getSettingResponse({required key}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/setting/$key");
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
      },
    );
    if (response.statusCode == 200) {
      return settingResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  // Future<dynamic> getAllCategoriesResponse() async {
  //   Uri url = Uri.parse("${AppConfig.BASE_URL}/category");
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Accept': 'application/json',
  //       "Content-Type": "application/json",
  //       "Accept-Language": app_language.$,
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return allCategoriesResponseFromJson(response.body);
  //   } else {
  //     return false;
  //   }
  // }
}
