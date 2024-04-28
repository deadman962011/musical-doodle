import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserWallet extends StatefulWidget {
  const UserWallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<UserWallet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        child: Directionality(
            textDirection:
                app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
            child: SafeArea(
                child: Scaffold(
                    key: _scaffoldKey,
                    body: Container(
                      child: Text('Wallet Page'),
                    )))));
  }
}
