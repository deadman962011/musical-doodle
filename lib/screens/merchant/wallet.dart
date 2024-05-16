import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/guest.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MerchantWallet extends StatefulWidget {
  MerchantWallet() : super();

  @override
  _MerchantWalletState createState() => _MerchantWalletState();
}

class _MerchantWalletState extends State<MerchantWallet> {
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Stack(
          children: [
            Image.asset(
              'assets/wallet_bg.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Scaffold(
                key: _scaffoldKey,
                appBar: MerchantAppBar.buildMerchantAppBar(context, 'add_offer',
                    _scaffoldKey, AppLocalizations.of(context)!.add_offer),
                drawer: MerchantDrawer.buildDrawer(context),
                backgroundColor: Colors.transparent,
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      _buildWalletMainBox(),
                      _buildWalletBoxes(),
                      _buildWalletActiveOffer()
                    ],
                  ),
                )),
          ],
        ));
  }

  Widget _buildWalletMainBox() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Available Balance'), Text('0.00')],
              ),
              Text('SAR')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Pending Balance'), Text('0.00')],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Total Balance'), Text('0.00')],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(top: 12),
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      backgroundColor: MyTheme.accent_color,
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 6, bottom: 6, end: 6),
                            child: ImageIcon(
                              AssetImage('assets/rep.png'),
                              color: Colors.white,
                              size: 20,
                            )),
                        Text(
                          'My History',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWalletBoxes() {
    return Container(
      margin: EdgeInsets.only(
        right: 14,
        left: 14,
        top: 6,
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 110,
            height: 110,
            // padding: EdgeInsets.all(26),
            decoration: BoxDecorations.buildBoxDecoration_1(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/wallet_2.png',
                ),
                Text(
                  'اجمالي العملاء',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecorations.buildBoxDecoration_1(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/wallet_1.png',
                ),
                Text(
                  'دفع عمولة التطبيق',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecorations.buildBoxDecoration_1(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/wallet_3.png',
                ),
                Text(
                  'سحب الرصيد',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletActiveOffer() {
    return Expanded(
        child: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Commission amout for offer 9',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecorations.buildBoxDecoration_2(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Offer sales:',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Text('35000 SAR',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: MyTheme.accent_color))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecorations.buildBoxDecoration_2(),
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('total commission: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14)),
                                ImageIcon(
                                  AssetImage('assets/inf.png'),
                                  color: Colors.grey,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                          Text(
                            '700 SAR',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: MyTheme.accent_color),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecorations.buildBoxDecoration_2(),
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('total commission: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14)),
                                ImageIcon(
                                  AssetImage('assets/inf.png'),
                                  color: Colors.grey,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                          Text('700 SAR',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: MyTheme.accent_color))
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: TextButton(
              onPressed: () {},
              child: Text(
                'Pay',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                backgroundColor: MyTheme.accent_color,
              ),
            ))
          ],
        )
      ],
    )));
  }
}
