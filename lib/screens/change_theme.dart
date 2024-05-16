import 'package:com.mybill.app/custom/useful_elements.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  var _selected_index = 0;
  ScrollController _mainScrollController = ScrollController();
  var _list = [];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: Stack(
            children: [
              CustomScrollView(
                controller: _mainScrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  // SliverList(
                  //   delegate: SliverChildListDelegate([
                  //     Padding(
                  //       padding: const EdgeInsets.all(18.0),
                  //       child: buildLanguageMethodList(),
                  //     ),
                  //   ]),
                  // )
                ],
              ),
            ],
          )),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      leading: Builder(
        builder: (context) => IconButton(
          padding: EdgeInsets.zero,
          icon: UsefulElements.backButton(context),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "${AppLocalizations.of(context)!.change_language} (${app_language.$}) - (${app_mobile_language.$})",
        style: TextStyle(
            fontSize: 16,
            color: MyTheme.dark_font_grey,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
