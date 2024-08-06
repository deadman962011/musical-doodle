import 'package:com.mybill.app/helpers/shared_value_helper.dart';
// import 'package:com.mybill.app/repositories/auth_repository.dart';

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
    shop_admin_permissions.$ = loginResponse['admin']['permissions'];
    shop_admin_permissions.save();
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
    shop_admin_permissions.$ = [];
    shop_admin_permissions.save();
    // app_fcm.$ = '';
    // app_fcm.save();
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
    user_name.$ = loginResponse['user']['first_name'] +
        '' +
        loginResponse['user']['last_name'];
    user_name.save();
    user_email.$ = loginResponse['user']['email'];
    user_email.save();
    user_phone.$ = loginResponse['user']['phone'] != null
        ? loginResponse['user']['phone']
        : '';
    user_phone.save();

    user_avatar.$ = loginResponse['user']['avatar_image'];
    user_avatar.save();
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
    user_phone.$ = '';
    user_phone.save();
    user_avatar.$ = '';
    user_avatar.save();
    // app_fcm.$ = '';
    // app_fcm.save();
  }

  bool canAny(permissions) {
    return permissions.isEmpty ||
        permissions
            .any((permission) => shop_admin_permissions.$.contains(permission));
  }

  bool can(permission) {
    if (shop_admin_permissions.$.contains(permission)) {
      return true;
    }
    return false;
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
