import 'package:com.mybill.app/custom/common_functions.dart';
import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/login.dart';
// import 'package:com.mybill.app/ui_sections/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:com.mybill.app/app_config.dart';

// import 'package:com.mybill.app/dummy_data/dummy_subscription_steps.dart';
// import 'package:com.mybill.app/screens/profile.dart';
// import 'package:com.mybill.app/repositories/layout_repository.dart';
// import 'package:com.mybill.app/dummy_data/dummy_entities.dart';
// import 'package:com.mybill.app/dummy_data/dummey_services.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Guest extends StatefulWidget {
  late bool go_back;
  late bool show_back_button;

  Guest({
    this.show_back_button = false,
    go_back = true,
  }) : super();

  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  final ScrollController _mainScrollController = ScrollController();
  bool _isCarouselInitial = true;
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
  }

  fetchAll() {
    fetchGuestLayout();
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

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
                Container(
                  width: double.infinity,
                  child: Image.asset('assets/auth_bg.png'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.cruise_through,
                              style: TextStyle(fontSize: 32),
                            ),
                            Text(
                              AppLocalizations.of(context)!.mybill,
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
                        child: Container(
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
                                  AppLocalizations.of(context)!.client_login,
                                  style: TextStyle(
                                    color: MyTheme.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Login(
                                      model: 'user',
                                    );
                                  }));
                                })),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
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
                                  AppLocalizations.of(context)!.merchant_login,
                                  style: TextStyle(
                                    color: MyTheme.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Login(
                                      model: 'merchant',
                                    );
                                  }));
                                })),
                      )
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
