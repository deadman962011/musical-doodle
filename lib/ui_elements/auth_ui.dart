import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen {
  // static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final ScrollController _mainScrollController = ScrollController();
  static Widget buildScreen(
      BuildContext context,
      String headerText,
      Widget child,
      bool isScrollEnabled,
      GlobalKey<ScaffoldState> scaffoldKey) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            key: scaffoldKey,
            body: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset('assets/auth_bg.png'),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 14, right: 14,
                      // bottom: MediaQuery.of(context).viewInsets.bottom
                    ),
                    child: Container(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          reverse: true,
                          controller: _mainScrollController,
                          physics: isScrollEnabled
                              ? const AlwaysScrollableScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [child],
                          ),
                        )))
              ],
            )));
  }
}
