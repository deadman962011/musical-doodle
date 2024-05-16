import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserScan extends StatefulWidget {
  const UserScan({Key? key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<UserScan> {
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
                      child: Text('Scan Page'),
                    )))));

    Container(
      child: Text('Scan Page'),
    );
  }
}
