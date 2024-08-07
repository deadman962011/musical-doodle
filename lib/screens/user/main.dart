import 'package:com.mybill.app/custom/common_functions.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/presenter/bottom_appbar_index.dart';
import 'package:com.mybill.app/screens/guest.dart';
import 'package:com.mybill.app/screens/user/home.dart';
import 'package:com.mybill.app/screens/user/menu.dart';
import 'package:com.mybill.app/screens/user/profile.dart';
import 'package:com.mybill.app/screens/user/scan.dart';
import 'package:com.mybill.app/screens/user/wallet.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:alice/alice.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

import 'package:com.mybill.app/generated/l10n.dart';

class UserMain extends StatefulWidget {
  late bool go_back;
  // ignore: non_constant_identifier_names
  UserMain({super.key, bool go_back = true});

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _currentIndex = 0;
  var _children = [];
  late final bool _showBottomNavigationBar = false;
  late Alice _alice;

  //int _cartCount = 0;

  BottomAppbarIndex bottomAppbarIndex = BottomAppbarIndex();

  fetchAll() {}

  void onTapped(int i) {
    fetchAll();
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
    _children = [Guest()];

    if (is_logged_in.$) {
      _children = [
        const UserHome(),
        const UserWallet(),
        const UserScan(),
        const UserProfile(),
        const UserMenu()
      ];
    }
    fetchAll();
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
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
          extendBody: true,
          body: _children[_currentIndex],
          bottomNavigationBar: is_logged_in.$ && logged_in_model.$ == 'user'
              ? Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: _currentIndex != 2
                      ? BottomAppBar(
                          padding: EdgeInsets.zero,
                          color: Colors.transparent,
                          clipBehavior: Clip.antiAlias,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.5), // Change the color and opacity as needed
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0,
                                      -3), // Positive y-offset for shadow above the bar
                                ),
                              ]),
                              height: 72,
                              child: BottomNavigationBar(
                                type: BottomNavigationBarType.fixed,
                                onTap: onTapped,
                                currentIndex: _currentIndex,
                                backgroundColor: Colors.white.withOpacity(0.95),
                                unselectedItemColor:
                                    const Color.fromRGBO(168, 175, 179, 1),
                                selectedItemColor: Colors.black,
                                selectedLabelStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 12),
                                unselectedLabelStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(168, 175, 179, 1),
                                    fontSize: 12),
                                items: [
                                  BottomNavigationBarItem(
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: Image.asset(
                                          "assets/home.png",
                                          color: _currentIndex == 0
                                              ? Colors.black
                                              : const Color.fromRGBO(
                                                  153, 153, 153, 1),
                                          height: 24,
                                        ),
                                      ),
                                      label: S
                                          .of(context)
                                          ?.main_screen_bottom_navigation_home),
                                  BottomNavigationBarItem(
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: Image.asset(
                                          "assets/wallet.png",
                                          color: _currentIndex == 1
                                              ? Colors.black
                                              : const Color.fromRGBO(
                                                  153, 153, 153, 1),
                                          height: 24,
                                        ),
                                      ),
                                      label: S
                                          .of(context)
                                          ?.main_screen_bottom_navigation_wallet),
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: Image.asset(
                                        "assets/scan.png",
                                        color: _currentIndex == 2
                                            ? Colors.black
                                            : const Color.fromRGBO(
                                                153, 153, 153, 1),
                                        height: 24,
                                      ),
                                    ),
                                    label: S
                                        .of(context)
                                        ?.main_screen_bottom_navigation_scan,
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: Image.asset(
                                        "assets/profile.png",
                                        color: _currentIndex == 3
                                            ? Colors.black
                                            : const Color.fromRGBO(
                                                153, 153, 153, 1),
                                        height: 24,
                                      ),
                                    ),
                                    label: S
                                        .of(context)
                                        ?.main_screen_bottom_navigation_profile,
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: Image.asset(
                                        "assets/menu.png",
                                        color: _currentIndex == 4
                                            ? Colors.black
                                            : const Color.fromRGBO(
                                                153, 153, 153, 1),
                                        height: 24,
                                      ),
                                    ),
                                    label: S
                                        .of(context)
                                        ?.main_screen_bottom_navigation_more,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox())
              : null,
        ),
      ),
    );
  }
}
