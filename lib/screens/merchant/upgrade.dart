import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/subscription/merchant_subscription_plans_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_subscription_repository.dart';
import 'package:com.mybill.app/screens/merchant/pay_upgrade.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';

class MerchantUpgrade extends StatefulWidget {
  const MerchantUpgrade({Key? key}) : super(key: key);

  @override
  _UpgradeState createState() => _UpgradeState();
}

class _UpgradeState extends State<MerchantUpgrade> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<MerchantSubscriptionPlan> _merchantSubscriptionPlansList = [];
  String selectedPlanId = '';
  bool isLoading = true;

  void initState() {
    super.initState();
    fetchMerchantSubscriptionPlans();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchMerchantSubscriptionPlans() async {
    var response = await MerchantSubscriptionRepository()
        .getAllMerchantSubscriptionPlansResponse();

    if (response is MerchantSubscriptionPlansResponse) {
      setState(() {
        _merchantSubscriptionPlansList = response.payload;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        key: _scaffoldKey,
        body: RefreshIndicator(
            color: MyTheme.accent_color,
            backgroundColor: Colors.white,
            onRefresh: () async {
              // reset();
            },
            child: SingleChildScrollView(
                child: Column(
              children: [
                Stack(
                  // alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/wallet_bg.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(height: 300, child: _buildHead())
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  child: _buildBody(),
                ),
                // _buildWalletPreviousOffer()
              ],
            ))),
        bottomNavigationBar: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Terms and conditions',
                    style: TextStyle(color: MyTheme.accent_color),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text('Privacy Policy',
                      style: TextStyle(color: MyTheme.accent_color))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHead() {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: MerchantAppBar.buildMerchantAppBar(
          context, 'upgrade_profile', _scaffoldKey, S.of(context).wallet),
      drawer: MerchantDrawer.buildDrawer(context),
      body: Column(
        children: [],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            ': Your current clients',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text('200',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
        ]),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'earn bonus for every clinet share offers  .',
              textAlign: TextAlign.center,
            )),
        _buildPlansList()
      ],
    );
  }

  Widget _buildPlansList() {
    return Column(
      children:
          _merchantSubscriptionPlansList.map((MerchantSubscriptionPlan plan) {
        return Padding(
          padding: EdgeInsets.only(top: 32),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PayUpgrade(
                                plan_id: plan.id.toString(),
                              ),
                            ));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: MyTheme.accent_color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            plan.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(plan.price.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700))
                        ],
                      )))
            ],
          ),
        );
      }).toList(),
    );
  }
}
