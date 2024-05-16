import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/user/banks.dart';
import 'package:com.mybill.app/screens/user/profile_edit.dart';
import 'package:com.mybill.app/screens/user/favorite.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:com.mybill.app/screens/user/my_codes.dart';
import 'package:com.mybill.app/screens/user/notifications.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _mainScrollController = ScrollController();
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
          'title': AppLocalizations.of(context)!.profile,
          'image': 'assets/profile.png',
          'redirect_to': 'profile',
          'items': []
        },
        {
          'title': AppLocalizations.of(context)!.favorite,
          'image': 'assets/favorite.png',
          'redirect_to': 'favorite',
          'items': []
        },
        {
          'title': AppLocalizations.of(context)!.notifications,
          'image': 'assets/bell.png',
          'redirect_to': 'notifications',
          'items': []
        },
        {
          'title': AppLocalizations.of(context)!.my_codes,
          'image': 'assets/offers.png',
          'redirect_to': 'my_codes',
          'items': []
        },
        {
          'title': AppLocalizations.of(context)!.theme,
          'image': 'assets/bank.png',
          'redirect_to': 'banks',
          'items': []
        },
        {
          'title': AppLocalizations.of(context)!.invite_friends,
          'image': 'assets/share_2.png',
          'redirect_to': 'change_theme',
          'items': []
        },
        {
          'title': AppLocalizations.of(context)!.logout,
          'image': 'assets/logout.png',
          'redirect_to': 'logout',
          'items': []
        },
        {
          'title': AppLocalizations.of(context)!.delete_my_acc,
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      tab['title'],
                      style: TextStyle(fontSize: 14),
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
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                          return const Banks();
                        }));
                      }

                      if (tab['redirect_to'] == 'logout') {
                        AuthHelper().clearUserData();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return UserMain();
                        }));
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
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )));
          }
        }).toList(),
      )
    ]);
  }
}
