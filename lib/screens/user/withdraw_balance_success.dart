import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:flutter/material.dart';

class WithdrawBalanceSuccess extends StatefulWidget {
  const WithdrawBalanceSuccess({Key? key}) : super(key: key);

  @override
  _WithdrawBalanceSuccessState createState() => _WithdrawBalanceSuccessState();
}

class _WithdrawBalanceSuccessState extends State<WithdrawBalanceSuccess> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Expanded(
                  child: CustomScrollView(slivers: [
                // Wrap your widgets with the SliverToBoxAdapter
                SliverFillRemaining(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/tick.png',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        S
                            .of(context)
                            .your_withdrwa_balance_request_successfully_sent,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        S.of(context).withdrwa_balance_request_is_processing,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ))
              ]))),
          bottomNavigationBar: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor:
                          MyTheme.accent_color, //MyTheme.accent_color
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserMain();
                    }));
                  },
                  child: Text(
                    S.of(context).back_to_main,
                    style: TextStyle(
                      color: MyTheme.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ))),
        ));
  }
}
