import 'dart:async';

import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_auth_repository.dart';
import 'package:com.mybill.app/repositories/user/user_auth_repository.dart';
import 'package:com.mybill.app/screens/merchant/main.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:com.mybill.app/screens/merchant/registration.dart';
import 'package:com.mybill.app/screens/user/registration.dart';
import 'package:com.mybill.app/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//  navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) {
//           return VerifyLink(url: initialLink);
//         }));

class VerifyLink extends StatefulWidget {
  final Uri url;

  const VerifyLink({Key? key, required this.url});

  @override
  _VerifyLinkState createState() => _VerifyLinkState();
}

class _VerifyLinkState extends State<VerifyLink> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleDeepLink(widget.url);
  }

  void handleDeepLink(Uri uri) {
    debugPrint(uri.path.toString());
    String token = uri.queryParameters['token']!;
    String action = uri.pathSegments.last;

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
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MerchantRegistration(
                email: value.payload['email'].toString());
          }));
        } else if (value.runtimeType.toString() ==
            'MerchantValidateLoginResponse') {
          AuthHelper().setMerchantAdminData(value.payload);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MerchantMain();
          }));
        } else {
          debugPrint(value.toString());
        }
      });
    }

    if (uri.path.toString() == '/to/verifyUserRegister' ||
        uri.path.toString() == '/to/verifyUserLogin') {
      UserAuthRepository()
          .getUserValidateMagicLinkResponse(token, action)
          .then((value) {
        if (value.runtimeType.toString() == 'UserValidateRegisterResponse') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return UserRegistration(email: value.payload['email'].toString());
          }));
        } else if (value.runtimeType.toString() ==
            'UserValidateLoginResponse') {
          AuthHelper().setUserData(value.payload);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return UserMain();
          }));
        }
      });
    }
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
