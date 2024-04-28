import 'package:csh_app/app_config.dart';
import 'package:shared_value/shared_value.dart';

final SharedValue<bool> is_logged_in = SharedValue(
  value: false, // initial value
  key: "is_logged_in", // disk storage key for shared_preferences
);

final SharedValue<String> logged_in_model = SharedValue(
  value: "", // initial value
  key: "logged_in_model", // disk storage key for shared_preferences
);


final SharedValue<String> access_token = SharedValue(
  value: "", // initial value
  key: "access_token", // disk storage key for shared_preferences
);

final SharedValue<String> app_language = SharedValue(
  value: AppConfig.default_language, // initial value
  key: "app_language", // disk storage key for shared_preferences
);


final SharedValue<String> app_theme = SharedValue(
  value: 'system', // initial value
  key: "app_theme", // disk storage key for shared_preferences
);



final SharedValue<String> shop_id = SharedValue(
  value: "", // initial value
  key: "shop_id", // disk storage key for shared_preferences
);

final SharedValue<String> shop_name = SharedValue(
  value: "", // initial value
  key: "shop_name", // disk storage key for shared_preferences
);

final SharedValue<String> shop_admin_id = SharedValue(
  value: "", // initial value
  key: "shop_admin_id", // disk storage key for shared_preferences
);

final SharedValue<String> shop_admin_name = SharedValue(
  value: "", // initial value
  key: "shop_admin_name", // disk storage key for shared_preferences
);

final SharedValue<String> shop_admin_email = SharedValue(
  value: "", // initial value
  key: "shop_admin_email", // disk storage key for shared_preferences
);


final SharedValue<String> shop_admin_avatar = SharedValue(
  value: "", // initial value
  key: "shop_admin_avatar", // disk storage key for shared_preferences
);

final SharedValue<String> user_id = SharedValue(
  value: "", // initial value
  key: "user_id", // disk storage key for shared_preferences
);

final SharedValue<String> user_name = SharedValue(
  value: "", // initial value
  key: "user_name", // disk storage key for shared_preferences
);

final SharedValue<String> user_email = SharedValue(
  value: "", // initial value
  key: "user_email", // disk storage key for shared_preferences
);


final SharedValue<bool> app_language_rtl = SharedValue(
  value: AppConfig.app_language_rtl, // initial value
  key: "app_language_rtl", // disk storage key for shared_preferences
);

final SharedValue<String> app_mobile_language = SharedValue(
  value: AppConfig.mobile_app_code, // initial value
  key: "app_mobile_language", // disk storage key for shared_preferences
);






// final SharedValue<String> user_name = SharedValue(
//   value: "", // initial value
//   key: "user_name", // disk storage key for shared_preferences
// );

// final SharedValue<String> user_email = SharedValue(
//   value: "", // initial value
//   key: "user_email", // disk storage key for shared_preferences
// );

// final SharedValue<String> user_phone = SharedValue(
//   value: "", // initial value
//   key: "user_phone", // disk storage key for shared_preferences
// );

// final SharedValue<String> user_ams = SharedValue(
//   value: "", // initial value
//   key: "user_ams", // disk storage key for shared_preferences
// );

// final SharedValue<String> forgort_password_request_token = SharedValue(
//   value: "", // initial value
//   key: "forgort_password_request_token", // disk storage key for shared_preferences
// );

// // addons start

// final SharedValue<bool> club_point_addon_installed = SharedValue(
//   value: false, // initial value
//   key: "club_point_addon_installed", // disk storage key for shared_preferences
// );

// final SharedValue<bool> refund_addon_installed = SharedValue(
//   value: false, // initial value
//   key: "refund_addon_installed", // disk storage key for shared_preferences
// );

// final SharedValue<bool> otp_addon_installed = SharedValue(
//   value: false, // initial value
//   key: "otp_addon_installed", // disk storage key for shared_preferences
// );
// // addon end

// // social login start
// final SharedValue<bool> allow_google_login = SharedValue(
//   value: false, // initial value
//   key: "allow_google_login", // disk storage key for shared_preferences
// );

// final SharedValue<bool> allow_facebook_login = SharedValue(
//   value: false, // initial value
//   key: "allow_facebook_login", // disk storage key for shared_preferences
// );

// final SharedValue<bool> allow_twitter_login = SharedValue(
//   value: false, // initial value
//   key: "allow_twitter_login", // disk storage key for shared_preferences
// );
// // social login end

// // business setting
// final SharedValue<bool> pick_up_status = SharedValue(
//   value: false, // initial value
//   key: "pick_up_status", // disk storage key for shared_preferences
// );
// // business setting
// final SharedValue<bool> carrier_base_shipping = SharedValue(
//   value: false, // initial value
//   key: "carrier_base_shipping", // disk storage key for shared_preferences
// );


// final SharedValue<bool> wallet_system_status = SharedValue(
//   value: false, // initial value
//   key: "wallet_system_status", // disk storage key for shared_preferences
// );

// final SharedValue<bool> mail_verification_status = SharedValue(
//   value: false, // initial value
//   key: "mail_verification_status", // disk storage key for shared_preferences
// );

// final SharedValue<bool> conversation_system_status = SharedValue(
//   value: false, // initial value
//   key: "conversation_system", // disk storage key for shared_preferences
// );


// final SharedValue<bool> has_subscription = SharedValue(
//   value: false, // initial value
//   key: "has_subscription", // disk storage key for shared_preferences
// );

// final SharedValue<String> avatar_original = SharedValue(
//   value: "", // initial value
//   key: "avatar_original", // disk storage key for shared_preferences
// );