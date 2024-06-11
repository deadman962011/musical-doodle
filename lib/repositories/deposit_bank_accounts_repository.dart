import 'dart:convert';

import 'package:com.mybill.app/models/responses/deposit_bank_account/all_deposit_bank_accounts.dart';
import 'package:com.mybill.app/models/responses/unexpected_error_response.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

class DepositBankAccountsRepository {
  Future<dynamic> getDepositBankAccountsResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/deposit_bank_accounts");
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
      },
    );
    AppConfig.alice.onHttpResponse(response, body: null);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 && responseBody['success'] == true) {
      return allDepoistBankAccountsResponseFromMap(response.body);
    } else {
      return unexpectedErrorResponseFromJson(response.body);
    }
  }
}
