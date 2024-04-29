import 'package:csh_app/custom/device_info.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/screens/change_language.dart';
import 'package:csh_app/screens/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<UserMenu> {
  ScrollController _mainScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(key: _scaffoldKey, body: buildBody(context)));
  }

  Widget buildBody(context) {
    final Map<String, dynamic> themeSettingsData = {
      'tabs': [
        {
          'title': AppLocalizations.of(context)!.theme,
          'image': 'assets/theme.png',
          'redirect_to': 'change_theme',
          'items': []
        },
      ]
    };
    final Map<String, dynamic> languageSettingsData = {
      'tabs': [
        {
          'title': AppLocalizations.of(context)!.language,
          'image': 'assets/language.png',
          'redirect_to': 'change_language',
          'items': []
        },
      ]
    };

    return Container(
        margin: EdgeInsets.only(top: 26),
        height: DeviceInfo(context).height,
        child: Stack(
          children: [
            Scaffold(
                backgroundColor: MyTheme.background_color,
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 14),
                        alignment: Alignment.center,
                        width: 120,
                        child: Image.asset(
                          'assets/splash_screen_logo.png',
                        ),
                      ),
                      buildMenuSection(themeSettingsData),
                      buildMenuSection(languageSettingsData),
                    ],
                  ),
                )

                //  SingleChildScrollView(
                //     controller: _mainScrollController,
                //     physics: const BouncingScrollPhysics(
                //         parent: AlwaysScrollableScrollPhysics()),
                //     child:
                //     ),
                ),
          ],
        ));
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
                      if (tab['redirect_to'] == 'change_language') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChangeLanguage();
                        }));
                      } else if (tab['redirect_to'] == 'change_theme') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChangeTheme();
                        }));
                      }
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
