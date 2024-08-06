// ignore_for_file: unused_field
import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/ui_elements/dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_context/one_context.dart';

import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/providers/locale_provider.dart';
import 'package:com.mybill.app/screens/guest.dart';
import 'package:com.mybill.app/screens/merchant/main.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // PackageInfo _packageInfo = PackageInfo(
  //   appName: AppConfig.app_name,
  //   packageName: 'Unknown',
  //   version: 'Unknown',
  //   buildNumber: 'Unknown',
  // );

  Future<void> _initPackageInfo() async {
    // final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      // _packageInfo = info;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPackageInfo();
    // _checkPermission();
    // Future.delayed(Duration(seconds: 5), );
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _checkPermission();
    // });

    // _locationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getSharedValueHelperData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Future.delayed(const Duration(seconds: 3)).then((value) {
              Provider.of<LocaleProvider>(context, listen: false)
                  .setLocale(app_mobile_language.$);

              if (is_logged_in.$) {
                if (logged_in_model.$ == 'merchant') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MerchantMain();
                      },
                    ),
                    (route) => false,
                  );
                } else if (logged_in_model.$ == 'user') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserMain();
                      },
                    ),
                    (route) => false,
                  );
                }
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Guest();
                    },
                  ),
                  (route) => false,
                );
              }
            });
          }
          return splashScreen();
        });
  }

  Widget splashScreen() {
    return Container(
      width: DeviceInfo(context).height,
      height: DeviceInfo(context).height,
      color: MyTheme.splash_screen_color,
      child: InkWell(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              top: DeviceInfo(context).height / 2 - 72,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Hero(
                      tag: "splashscreenImage",
                      child: Container(
                        height: 200,
                        width: 200,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Image.asset(
                          "assets/splash_screen_logo.png",
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getSharedValueHelperData() async {
    // access_token.load().whenComplete(() {
    //   AuthHelper().fetch_and_set();
    // });
    await app_language.load();
    await app_mobile_language.load();
    await app_language_rtl.load();

    // print("new splash screen ${app_mobile_language.$}");
    // print("new splash screen app_language_rtl ${app_language_rtl.$}");

    return app_mobile_language.$;
  }
}
