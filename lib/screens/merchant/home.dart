import 'package:csh_app/helpers/auth_helper.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/screens/guest.dart';
import 'package:csh_app/screens/merchant/main.dart';
import 'package:csh_app/ui_elements/merchant_appbar.dart';
import 'package:flutter/material.dart';

class MerchantHome extends StatefulWidget {
  MerchantHome() : super();

  @override
  _MerchantHomeState createState() => _MerchantHomeState();
}

class _MerchantHomeState extends State<MerchantHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  reset() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  logout() {
    AuthHelper().clearMerchantData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Guest();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
            child: Container(
          child: Column(
            children: [
              Text('merchant home'),
              TextButton(
                  onPressed: () {
                    logout();
                  },
                  child: Text('logout'))
            ],
          ),
        )),
      ),
    );

    //  Container(
    //   child: Column(children: [

    //   ],),
    // );
  }
}
