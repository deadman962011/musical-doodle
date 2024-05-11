import 'package:csh_app/my_theme.dart';
import 'package:csh_app/screens/merchant/home.dart';
import 'package:csh_app/screens/merchant/main.dart';
import 'package:csh_app/screens/merchant/offers/offers.dart';
import 'package:csh_app/screens/merchant/profile_edit.dart';
import 'package:csh_app/screens/merchant/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MerchantDrawer {
  static Drawer buildDrawer(context) {
    final List<Map<String, dynamic>> drawerItems = [
      {
        'title': AppLocalizations.of(context)!.statistics,
        'image': 'assets/pie.png',
        'action': null,
        'sub': [
          {'title': AppLocalizations.of(context)!.statistics, 'action': () {}},
          {'title': AppLocalizations.of(context)!.statistics, 'action': () {}}
        ]
      },
      {
        'title': AppLocalizations.of(context)!.wallet,
        'image': 'assets/wallet.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MerchantMain();
          }));
        },
        'sub': []
      },
      {
        'title': AppLocalizations.of(context)!.offers,
        'image': 'assets/offers.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MerchantOffers();
          }));
        },
        'sub': []
      },
      {
        'title': AppLocalizations.of(context)!.pay_commissions,
        'image': 'assets/suitcase.png',
        'sub': []
      },
      {
        'title': AppLocalizations.of(context)!.loyalty_program,
        'image': 'assets/gift.png',
        'action': () {},
        'sub': []
      },
      {
        'title': AppLocalizations.of(context)!.notifications,
        'image': 'assets/menu.png',
        'sub': []
      },
      {
        'title': AppLocalizations.of(context)!.profile,
        'image': 'assets/profile.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MerchantProfileEdit();
          }));
        },
        'sub': []
      },
      {
        'title': AppLocalizations.of(context)!.upgrade_profile,
        'image': 'assets/upgrade_account.png',
        'action': () {},
        'sub': []
      },
      {
        'title': AppLocalizations.of(context)!.settings,
        'image': 'assets/settings.png',
        'action': () {},
        'sub': []
      },
    ];

    return Drawer(
      width: 230,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: MyTheme.accent_color,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 12, left: 12, top: 50),
            child: SizedBox(
              height: 50,
              child: Text(
                'Drawer Header',
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
                            child: Image.asset(item['image']),
                          ),
                          Text(
                            item['title'],
                            style:
                                TextStyle(color: MyTheme.white, fontSize: 12),
                          )
                        ],
                      ),
                      children: item['sub'].map<Widget>((child) {
                        return Text(child['title'],
                            style: TextStyle(
                              color: MyTheme.white,
                              fontSize: 12,
                            ));
                      }).toList(),
                      shape: Border(),
                    )
                  : ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 6, end: 12),
                            child: Image.asset(item['image']),
                          ),
                          Text(
                            item['title'],
                            style:
                                TextStyle(color: MyTheme.white, fontSize: 12),
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
