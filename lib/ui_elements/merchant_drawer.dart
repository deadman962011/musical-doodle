import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/providers/offer_provider.dart';
import 'package:com.mybill.app/screens/guest.dart';
import 'package:com.mybill.app/screens/merchant/offers/offers.dart';
import 'package:com.mybill.app/screens/merchant/profile_edit.dart';
import 'package:com.mybill.app/screens/merchant/statistics/latest_sales.dart';
import 'package:com.mybill.app/screens/merchant/statistics/statistics.dart';
import 'package:com.mybill.app/screens/merchant/wallet.dart';
import 'package:flutter/material.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:provider/provider.dart';

class MerchantDrawer {
  static Drawer buildDrawer(context) {
    final List<Map<String, dynamic>> drawerItems = [
      {
        'title': S.of(context).statistics,
        'image': 'assets/pie.png',
        'action': null,
        'sub': [
          {
            'title': S.of(context).statistics,
            'action': () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MerchantStatistics();
              }));
            }
          },
          {
            'title': S.of(context).statistics,
            'action': () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MerchantLatestSales();
              }));
            }
          }
        ]
      },
      {
        'title': S.of(context).wallet,
        'image': 'assets/wallet.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MerchantWallet();
          }));
        },
        'sub': []
      },
      {
        'title': S.of(context).offers,
        'image': 'assets/offers.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MerchantOffers();
          }));
        },
        'sub': []
      },
      {
        'title': S.of(context).pay_commissions,
        'image': 'assets/suitcase.png',
        'sub': []
      },
      {
        'title': S.of(context).loyalty_program,
        'image': 'assets/gift.png',
        'action': () {},
        'sub': []
      },
      {
        'title': S.of(context).notifications,
        'image': 'assets/menu.png',
        'sub': []
      },
      {
        'title': S.of(context).profile,
        'image': 'assets/profile.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MerchantProfileEdit();
          }));
        },
        'sub': []
      },
      {
        'title': S.of(context).upgrade_profile,
        'image': 'assets/upgrade_account.png',
        'action': () {},
        'sub': []
      },
      {
        'title': S.of(context).settings,
        'image': 'assets/settings.png',
        'action': () {},
        'sub': []
      },
      {
        'title': S.of(context).logout,
        'image': 'assets/settings.png',
        'action': () {
          AuthHelper().clearMerchantData();
          final offerProvider =
              Provider.of<OfferProvider>(context, listen: false);

          offerProvider.clearFirstOffer();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return Guest();
          }), (route) => false);
        },
        'sub': []
      },
    ];

    return Drawer(
      width: 230,

      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: MyTheme.accent_color_shadow,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 12, left: 12, top: 50),
            child: SizedBox(
              height: 50,
              child: Text(
                ' ',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Column(
            children: drawerItems.map<Widget>((item) {
              return item['sub'].length > 0
                  ? ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 6, end: 12),
                            child: Image.asset(
                              item['image'],
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            item['title'],
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                      children: item['sub'].map<Widget>((child) {
                        return ListTile(
                          title: Text(child['title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              )),
                          onTap: child['action'],
                        );
                      }).toList(),
                      shape: const Border(),
                    )
                  : ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 6, end: 12),
                            child: Image.asset(item['image'],
                                color: MyTheme.white),
                          ),
                          Text(
                            item['title'],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                      onTap: item['action'],
                    );
            }).toList(),
          )

          // ListTile(
          //   title: const Text('Item 2'),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
        ],
      ),

      // Column(children: [
      // ListView(
      //   children:drawerItems.map<Widget>((item){
      //     return ListTile(
      //       title:Text(item['title']),
      //       onTap: item['action'],
      //     );

      //   }).toList() ,
      // )

      // ],)
    );
  }
}
