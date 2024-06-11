import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/user/bank_accounts.dart';
import 'package:com.mybill.app/screens/user/profile_edit.dart';
import 'package:com.mybill.app/screens/user/favorite.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:com.mybill.app/screens/user/my_codes.dart';
import 'package:com.mybill.app/screens/user/notifications.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';

import 'package:com.mybill.app/generated/l10n.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mainScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(key: _scaffoldKey, body: buildBody(context)));
  }

  Widget buildBody(context) {
    final Map<String, dynamic> mainProfilesData = {
      'tabs': [
        {
          'title': S.of(context).profile,
          'image': 'assets/profile.png',
          'redirect_to': 'profile',
          'items': []
        },
        {
          'title': S.of(context).favorite,
          'image': 'assets/favorite.png',
          'redirect_to': 'favorite',
          'items': []
        },
        {
          'title': S.of(context).notifications,
          'image': 'assets/bell.png',
          'redirect_to': 'notifications',
          'items': []
        },
        {
          'title': S.of(context).my_codes,
          'image': 'assets/offers.png',
          'redirect_to': 'my_codes',
          'items': []
        },
        {
          'title': S.of(context).bank_accounts,
          'image': 'assets/bank.png',
          'redirect_to': 'banks',
          'items': []
        },
        {
          'title': S.of(context).invite_friends,
          'image': 'assets/share_2.png',
          'redirect_to': 'change_theme',
          'items': []
        },
        {
          'title': S.of(context).logout,
          'image': 'assets/logout.png',
          'redirect_to': 'logout',
          'items': []
        },
        {
          'title': S.of(context).delete_my_acc,
          'image': 'assets/trash.png',
          'redirect_to': 'change_theme',
          'items': []
        }
      ]
    };

    return Scaffold(
      appBar: UserAppBar.buildUserAppBar(context, 'profile', '', {}),
      backgroundColor: MyTheme.background_color,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
        ),
        child: Column(
          children: [
            buildMenuSection(mainProfilesData),
          ],
        ),
      ),
    );
  }

  Widget buildMenuSection(data) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(
        children: data['tabs'].map<Widget>((tab) {
          if (tab['items'].length > 0) {
            return ExpansionTile(
              title: Row(
                children: [
                  Image.asset(
                    tab['image'],
                    color: MyTheme.accent_color,
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      tab['title'],
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
              iconColor: Colors.black,
              // tilePadding: EdgeInsets,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              collapsedIconColor: Colors.black,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
                  alignment: AlignmentDirectional.topStart,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: tab['items'].map<Widget>((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                item['name'],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              )),
                        );
                      }).toList()),
                ),
              ],
            );
          } else {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (tab['redirect_to'] == 'profile') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ProfileEdit();
                        }));
                      }
                      if (tab['redirect_to'] == 'favorite') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Favorite();
                        }));
                      }
                      if (tab['redirect_to'] == 'notifications') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const UserNotifications();
                        }));
                      }
                      if (tab['redirect_to'] == 'my_codes') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const MyCodes();
                        }));
                      }
                      if (tab['redirect_to'] == 'banks') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const BankAccounts();
                        }));
                      }

                      if (tab['redirect_to'] == 'logout') {
                        AuthHelper().clearUserData();
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return UserMain();
                        }), (route) => false);
                      }

                      // else if (tab['redirect_to'] == 'change_theme') {
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) {
                      //     // return ChangeTheme();
                      //   }));
                      // }
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8),
                          child: Image.asset(
                            tab['image'],
                            color: MyTheme.accent_color,
                            height: 20,
                          ),
                        ),
                        Text(
                          tab['title'],
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    )));
          }
        }).toList(),
      )
    ]);
  }
}
