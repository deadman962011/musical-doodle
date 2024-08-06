import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/providers/offer_provider.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_auth_repository.dart';
import 'package:com.mybill.app/screens/change_language.dart';
import 'package:com.mybill.app/screens/guest.dart';
import 'package:com.mybill.app/screens/merchant/offers/offers.dart';
import 'package:com.mybill.app/screens/merchant/profile_edit.dart';
import 'package:com.mybill.app/screens/merchant/staffs/role/roles.dart';
import 'package:com.mybill.app/screens/merchant/staffs/staff/staff.dart';
import 'package:com.mybill.app/screens/merchant/statistics/latest_sales.dart';
import 'package:com.mybill.app/screens/merchant/statistics/statistics.dart';
import 'package:com.mybill.app/screens/merchant/upgrade.dart';
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
            },
            'permissions': ['show_shop_statistics']
          },
          {
            'title': S.of(context).statistics,
            'action': () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MerchantLatestSales();
              }));
            },
            'permissions': ['show_shop_statistics']
          }
        ],
        'permissions': ['show_shop_statistics']
      },
      {
        'title': S.of(context).wallet,
        'image': 'assets/wallet.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MerchantWallet();
          }));
        },
        'sub': [],
        'permissions': ['show_shop_wallet']
      },
      {
        'title': S.of(context).offers,
        'image': 'assets/offers.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MerchantOffers();
          }));
        },
        'sub': [],
        'permissions': [
          'add_shop_offer',
          'edit_shop_offer',
          'delete_shop_offer'
        ]
      },
      {
        'title': S.of(context).pay_commissions,
        'image': 'assets/suitcase.png',
        'sub': [],
        'permissions': ['pay_offer_commission']
      },
      {
        'title': S.of(context).loyalty_program,
        'image': 'assets/gift.png',
        'action': () {},
        'sub': [],
        'permissions': []
      },
      {
        'title': S.of(context).profile,
        'image': 'assets/profile.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MerchantProfileEdit();
          }));
        },
        'sub': [],
        'permissions': [
          'edit_shop_informations',
          'edit_shop_contact_informations',
          'edit_shop_availability'
        ],
      },
      {
        'title': S.of(context).staff,
        'image': 'assets/profile.png',
        'action': null,
        'permissions': [
          'add_shop_role',
          'edit_shop_role',
          'delete_shop_role',
          'add_shop_staff',
          'edit_shop_staff',
          'delete_shop_staff'
        ],
        'sub': [
          {
            'title': S.of(context).staff,
            'action': () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MerchantStaff();
              }));
            },
            'permissions': [
              'add_shop_role',
              'edit_shop_role',
              'delete_shop_role'
            ]
          },
          {
            'title': S.of(context).roles,
            'action': () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MerchantRoles();
              }));
            },
            'permissions': [
              'add_shop_staff',
              'edit_shop_staff',
              'delete_shop_staff'
            ]
          }
        ]
      },
      {
        'title': S.of(context).upgrade_profile,
        'image': 'assets/upgrade_account.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MerchantUpgrade();
          }));
        },
        'sub': [],
        'permissions': ['upgrade_shop']
      },
      {
        'title': S.of(context).notifications,
        'image': 'assets/menu.png',
        'sub': [],
        'permissions': []
      },
      {
        'title': S.of(context).settings,
        'image': 'assets/settings.png',
        'action': () {},
        'sub': [],
        'permissions': []
      },
      {
        'title': S.of(context).language,
        'image': 'assets/settings.png',
        'action': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ChangeLanguage(
              model: 'merchant',
            );
          }));
        },
        'sub': [],
        'permissions': []
      },
      {
        'title': S.of(context).logout,
        'image': 'assets/settings.png',
        'action': () {
          MerchantAuthRepository().getMerchantLogoutResponse();
          AuthHelper().clearMerchantData();
          final offerProvider =
              Provider.of<OfferProvider>(context, listen: false);

          offerProvider.clearFirstOffer();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return Guest();
          }), (route) => false);
        },
        'sub': [],
        'permissions': []
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
              if (AuthHelper().canAny(item['permissions'])) {
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
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              item['title'],
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            )
                          ],
                        ),
                        children: item['sub'].map<Widget>((child) {
                          return ListTile(
                            title: Text(child['title'],
                                style: TextStyle(
                                  color: Colors.black,
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
                                  color: Colors.black),
                            ),
                            Text(
                              item['title'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            )
                          ],
                        ),
                        onTap: item['action'],
                      );
              } else {
                return Container();
              }
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
