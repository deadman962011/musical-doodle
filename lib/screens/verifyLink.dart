import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_auth_repository.dart';
import 'package:com.mybill.app/repositories/user/user_auth_repository.dart';
import 'package:com.mybill.app/screens/guest.dart';
import 'package:com.mybill.app/screens/login.dart';
import 'package:com.mybill.app/screens/merchant/main.dart';
import 'package:com.mybill.app/screens/merchant/statistics/statistics.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:com.mybill.app/screens/merchant/registration.dart';
import 'package:com.mybill.app/screens/user/registration.dart';
import 'package:com.mybill.app/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';

//  navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) {
//           return VerifyLink(url: initialLink);
//         }));

class VerifyLink extends StatefulWidget {
  final Uri url;

  const VerifyLink({super.key, required this.url});

  @override
  _VerifyLinkState createState() => _VerifyLinkState();
}

class _VerifyLinkState extends State<VerifyLink> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleDeepLink(widget.url);
    // getLocation();
  }

  void handleDeepLink(Uri uri) async {
    debugPrint(uri.path.toString());
    String token = uri.queryParameters['token']!;
    String action = uri.pathSegments.last;

    // if (mounted && uri.path.toString() == '/to/guest') {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return Guest();
    //   }));
    // }

    if (uri.path.toString() == '/to/verifyShopRegister' ||
        uri.path.toString() == '/to/verifyShopLogin') {
      //TODO::  if user or merchant is not registered

      // Extract the token parameter

      //validate token
      MerchantAuthRepository()
          .getMerchantValidateMagicLinkResponse(token, action)
          .then((value) {
        if (value.runtimeType.toString() ==
            'MerchantValidateRegisterResponse') {
          // Navigate to the register page
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return MerchantRegistration(
                email: value.payload['email'].toString());
          }), (route) => false);
        } else if (value.runtimeType.toString() ==
            'MerchantValidateLoginResponse') {
          AuthHelper().setMerchantAdminData(value.payload);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return MerchantStatistics();
          }), (route) => false);
        } else {
          ToastComponent.showDialog(value.message, context,
              gravity: Toast.bottom, duration: Toast.lengthLong);

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return Guest();
          }), (route) => false);
        }
      });
    } else if (uri.path.toString() == '/to/verifyUserRegister' ||
        uri.path.toString() == '/to/verifyUserLogin') {
      var response = await UserAuthRepository()
          .getUserValidateMagicLinkResponse(token, action);
      debugPrint(response.runtimeType.toString());
      if (response.runtimeType.toString() == 'UserValidateRegisterResponse') {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return UserRegistration(email: response.payload['email'].toString());
        }), (route) => false);
      } else if (response.runtimeType.toString() ==
          'UserValidateLoginResponse') {
        AuthHelper().setUserData(response.payload);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return UserMain();
        }), (route) => false);
      } else {
        ToastComponent.showDialog(response.message, context,
            gravity: Toast.bottom, duration: Toast.lengthLong);

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return Guest();
        }), (route) => false);
      }
      ;
    }
    //  else if (uri.path.toString() == '/to/guest') {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return Guest();
    //   }));
    // }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AuthScreen.buildScreen(
        context, 'Verify Link', verifyLink(), false, scaffoldKey);
  }

  Widget verifyLink() {
    return Container(
        width: DeviceInfo(context).width,
        margin: const EdgeInsets.only(top: 100, bottom: 40),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              'assets/envelop.png',
              width: 180,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Text(
                  'Verifying',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
          ),
        ]));
  }
}
