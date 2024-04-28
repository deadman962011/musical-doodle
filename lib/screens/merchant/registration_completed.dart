import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/custom/device_info.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/screens/merchant/main.dart';
import 'package:csh_app/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistartionCompleted extends StatefulWidget {
  @override
  _RegistrationCompletedState createState() => _RegistrationCompletedState();
}

class _RegistrationCompletedState extends State<RegistartionCompleted> {
  @override
  void initState() {
    //on Splash Screen hide statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom]);
    // fetchCategories();
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AuthScreen.buildScreen(context, 'Merchant Registration Completed',
        merchantRegistrationCompleted(), false, scaffoldKey);
  }

  Widget merchantRegistrationCompleted() {
    return Container(
        width: DeviceInfo(context).width,
        margin: const EdgeInsets.only(top: 140, bottom: 40),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              'assets/envelop.png',
              width: 180,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.merchant_registration_completed,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: MyTheme.accent_color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MerchantMain();
                }));
              },
              child: Text(
                AppLocalizations.of(context)!.back_to_main,
                style: TextStyle(
                  color: MyTheme.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ]));
  }
}
