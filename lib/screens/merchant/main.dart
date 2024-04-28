import 'dart:async';
import 'dart:io';

import 'package:csh_app/custom/common_functions.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/presenter/bottom_appbar_index.dart';
import 'package:csh_app/screens/guest.dart';
import 'package:csh_app/screens/merchant/home.dart';
import 'package:csh_app/screens/user/home.dart';
import 'package:csh_app/screens/user/menu.dart';
import 'package:csh_app/screens/user/profile.dart';
import 'package:csh_app/screens/user/scan.dart';
import 'package:csh_app/screens/user/wallet.dart';
import 'package:csh_app/ui_elements/merchant_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:csh_app/ui_elements/merchant_drawer.dart';

class MerchantMain extends StatefulWidget {
  late bool go_back;
  // ignore: non_constant_identifier_names
  MerchantMain({bool go_back = true}) : super();

  @override
  _MerchantMainState createState() => _MerchantMainState();
}

class _MerchantMainState extends State<MerchantMain> {
  int _currentIndex = 0;
  var _children = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //int _cartCount = 0;

  fetchAll() {}

  void onTapped(int i) {
    fetchAll();
    debugPrint(' ${is_logged_in.$} ${access_token.$} ');
    if (i == 1 && !is_logged_in.$) {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      return;
    }
    // if (i == 2) {}
    // if (i == 3) {}

    setState(() {
      _currentIndex = i;
    });
  }

  @override
  void initState() {
    // _children = [Guest()];

    // if (is_logged_in.$) {
    //   _children = [
    //     UserHome(),
    //     const UserWallet(),
    //     const UserScan(),
    //     const UserProfile(),
    //     const UserMenu()
    //   ];
    //   // if (logged_in_model.$ == 'merchant') {
    //   //   _children = [
    //   //     MerchantHome(),
    //   //   ];
    //   // } else if (logged_in_model.$ == 'user') {
    //   //   _showBottomNavigationBar = true;
    //   // }
    // }

    // debugPrint(logged_in_model.$.toString());

    // _children = [
    //   is_logged_in.$ ? Home() : Guest(),
    //   // is_logged_in.$ ? Offers() : Login(),
    //   // Clubs()
    // ];
    fetchAll();
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //print("_currentIndex");
        if (_currentIndex != 0) {
          fetchAll();
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          CommonFunctions(context).appExitDialog();
        }
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar:
              MerchantAppBar.buildMerchantAppBar(context, 'main', _scaffoldKey),
          drawer: MerchantDrawer.buildDrawer(context),
          extendBody: true,
          body: MerchantHome(),
        ),
      ),
    );
  }
}

  // class RootScaffold {
  //   static openDrawer(BuildContext context) {    
  //      final ScaffoldState? scaffoldState = context.findRootAncestorStateOfType<ScaffoldState>();
  //      scaffoldState?.openDrawer();
  //   }
  // }
