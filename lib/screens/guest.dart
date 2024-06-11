import 'package:com.mybill.app/custom/common_functions.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/login.dart';
import 'package:com.mybill.app/screens/user/scan.dart';
import 'package:flutter/material.dart';

// import 'package:com.mybill.app/dummy_data/dummy_subscription_steps.dart';
// import 'package:com.mybill.app/screens/profile.dart';
// import 'package:com.mybill.app/repositories/layout_repository.dart';
// import 'package:com.mybill.app/dummy_data/dummy_entities.dart';
// import 'package:com.mybill.app/dummy_data/dummey_services.dart';
// import 'package:com.mybill.app/ui_sections/drawer.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:flutter/services.dart';

import 'package:com.mybill.app/ui_elements/dialog.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:geolocator/geolocator.dart';

class Guest extends StatefulWidget {
  late bool go_back;
  late bool show_back_button;

  Guest({
    super.key,
    this.show_back_button = false,
    go_back = true,
  });

  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _current_slider = 0;
  final ScrollController _mainScrollController = ScrollController();
  final bool _isCarouselInitial = true;
  bool _isGusetLayoutInitial = true;

// _isCarouselInitial && _carouselImageList.length == 0

  @override
  void initState() {
    // print("app_mobile_language.en${app_mobile_language.$}");
    // print("app_language.${app_language.$}");
    // print("app_language_rtl${app_language_rtl.$}");

    // TODO: implement initState
    super.initState();
    // In initState()

    fetchAll();
    _checkPermission();
  }

  fetchAll() {
    fetchGuestLayout();
  }

  void _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CheckLocaionDialog(
              description: 'you_denied',
              onOkPressed: () async {
                await Geolocator.requestPermission();
                _checkPermission();
              }));
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      user_longitude.$ = position.longitude.toString();
      user_latitude.$ = position.latitude.toString();
      user_longitude.save();
      user_latitude.save();
    }
  }

  fetchGuestLayout() async {
    // var response = await layoutRepository().getHomeGuestLayout();
    // _isGusetLayoutInitial = true;
    // _servicesList.addAll(response.services);
    // _entitiesList.addAll(response.services);
    // _common_questions.addAll(response.common_questions);
    // _carouselImageList
    //     .add('http://192.168.43.103/ammanauto/guest_slider/1.png');
    // _isCarouselInitial = false;

    // if (app_language.$ == 'en') {
    //   _subsription_steps_List.addAll(dummy_subsription_steps_list_en);
    // } else {
    //   _subsription_steps_List.addAll(dummy_subsription_steps_list_ar);
    // }
    // debugPrint(_servicesList.length.toString());
    // _isGusetLayoutInitial = false;
    setState(() {});
  }

  reset() {
    _isGusetLayoutInitial = true;
    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return WillPopScope(
      onWillPop: () async {
        CommonFunctions(context).appExitDialog();
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,

            //drawer: MainDrawer(),
            body: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset('assets/auth_bg.png'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            // Text(
                            //   S.of(context).cruise_through,
                            //   style: const TextStyle(fontSize: 32),
                            // ),
                            Text(
                              S.of(context).mybill,
                              style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: MyTheme.accent_color),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  // primary: Colors.white,
                                  backgroundColor: MyTheme.accent_color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: Text(
                                  S.of(context).client_login,
                                  style: TextStyle(
                                    color: MyTheme.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const Login(
                                      model: 'user',
                                    );
                                  }));
                                })),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  // primary: Colors.white,
                                  backgroundColor: MyTheme.accent_color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: Text(
                                  S.of(context).merchant_login,
                                  style: TextStyle(
                                    color: MyTheme.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const Login(
                                      model: 'merchant',
                                    );
                                  }));
                                })),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  // child: buildProductLoadingContainer()
                ),
              ],
            )),

        //  SafeArea(
        //   child:

        // ),
      ),
    );
  }
}
