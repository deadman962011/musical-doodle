import 'package:csh_app/helpers/shared_value_helper.dart';
// import 'package:csh_app/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';

class AuthHelper {
  setMerchantAdminData(loginResponse) {
    is_logged_in.$ = true;
    is_logged_in.save();
    logged_in_model.$ = 'merchant';
    logged_in_model.save();
    access_token.$ = loginResponse['token'];
    access_token.save();
    shop_admin_id.$ = loginResponse['admin']['id'].toString();
    shop_admin_id.save();
    shop_admin_name.$ = loginResponse['admin']['name'];
    shop_admin_name.save();
    shop_admin_email.$ = loginResponse['admin']['email'];
    shop_admin_email.save();

    // shop_admin_avatar.$=loginResponse.payload['avatar'];
    // shop_id
    // shop_name
  }

  clearMerchantData() {
    is_logged_in.$ = false;
    is_logged_in.save();
    logged_in_model.$ = '';
    logged_in_model.save();
    access_token.$ = "";
    access_token.save();
    shop_admin_id.$ = '';
    shop_admin_id.save();
    shop_admin_name.$ = '';
    shop_admin_name.save();
    shop_admin_email.$ = '';
    shop_admin_email.save();
  }

  setUserData(loginResponse) {
    is_logged_in.$ = true;
    is_logged_in.save();
    logged_in_model.$ = 'user';
    logged_in_model.save();
    access_token.$ = loginResponse['token'];
    access_token.save();
    user_id.$ = loginResponse['user']['id'].toString();
    user_id.save();
    user_name.$ = loginResponse['user']['name'];
    user_name.save();
    user_email.$ = loginResponse['user']['email'];
    user_email.save();
  }

  clearUserData() {
    is_logged_in.$ = false;
    is_logged_in.save();
    logged_in_model.$ = '';
    logged_in_model.save();
    access_token.$ = '';
    access_token.save();
    user_id.$ = '';
    user_id.save();
    user_name.$ = '';
    user_name.save();
    user_email.$ = '';
    user_email.save();
  }

  fetch_and_set() async {
    // var userByTokenResponse = await AuthRepository().getUserByTokenResponse();

    // if (userByTokenResponse.result == true) {
    //   is_logged_in.$ = true;
    //   is_logged_in.save();
    //   user_id.$ = userByTokenResponse.id;
    //   user_id.save();
    //   user_name.$ = userByTokenResponse.name;
    //   user_name.save();
    //   user_email.$ = userByTokenResponse.email;
    //   user_email.save();
    //   user_phone.$ = userByTokenResponse.phone;
    //   user_phone.save();
    //   avatar_original.$ = userByTokenResponse.avatar_original;
    //   avatar_original.save();
    // }else{
    //   is_logged_in.$ = false;
    //   is_logged_in.save();
    //   user_id.$ = 0;
    //   user_id.save();
    //   user_name.$ = "";
    //   user_name.save();
    //   user_email.$ = "";
    //   user_email.save();
    //   user_phone.$ = "";
    //   user_phone.save();
    //   avatar_original.$ = "";
    //   avatar_original.save();
    // }
  }
}
