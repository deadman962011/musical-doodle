import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MerchantLatestSales extends StatefulWidget {
  const MerchantLatestSales({Key? key}) : super(key: key);

  @override
  _LatestSalesState createState() => _LatestSalesState();
}

class _LatestSalesState extends State<MerchantLatestSales> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // reset();
    // fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: MerchantAppBar.buildMerchantAppBar(context, 'latest_sales',
                _scaffoldKey, AppLocalizations.of(context)!.offers),
            drawer: MerchantDrawer.buildDrawer(context),
            body: RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                displacement: 0,
                onRefresh: _onRefresh,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  child: SingleChildScrollView(
                    child: _buildSalesList(),
                  ),
                ))));
  }

  Widget _buildSalesList() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/default_avatar.png',
                    width: 70,
                    height: 70,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ahmad mouhamad',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text('2 minutes ago',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500))
                        ],
                      )),
                ],
              ),
              Text(
                '240 SAR',
                style: TextStyle(
                    color: MyTheme.accent_color,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        )
      ],
    );
  }
}
