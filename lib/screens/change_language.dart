import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/useful_elements.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/screens/merchant/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/my_theme.dart';
// import 'package:com.mybill.app/repositories/language_repository.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:com.mybill.app/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:com.mybill.app/dummy_data/dummy_languages.dart';

class ChangeLanguage extends StatefulWidget {
  final String model;

  const ChangeLanguage({super.key, required this.model});

  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  var _selected_index = 0;
  final ScrollController _mainScrollController = ScrollController();
  final _list = [];
  bool _isInitial = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchList();
  }

  @override
  void dispose() {
    super.dispose();
    _mainScrollController.dispose();
  }

  fetchList() async {
    // var languageListResponse = await LanguageRepository().getLanguageList();

    _list.addAll(dummy_languaes_list);

    var idx = 0;
    if (_list.isNotEmpty) {
      for (var lang in _list) {
        if (lang.code == app_language.$) {
          setState(() {
            _selected_index = idx;
          });
        }
        idx++;
      }
    }
    _isInitial = false;
    setState(() {});
  }

  reset() {
    _list.clear();
    _isInitial = true;
    _selected_index = 0;
    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchList();
  }

  onPopped(value) {
    reset();
    fetchList();
  }

  onLanguageItemTap(index) {
    if (index != _selected_index) {
      setState(() {
        _selected_index = index;
      });

      app_language.$ = _list[_selected_index].code;
      app_language.save();
      app_mobile_language.$ = _list[_selected_index].mobile_app_code;
      app_mobile_language.save();
      app_language_rtl.$ = _list[_selected_index].rtl;
      app_language_rtl.save();

      // var local_provider = new LocaleProvider();
      // local_provider.setLocale(_list[_selected_index].code);
      Provider.of<LocaleProvider>(context, listen: false)
          .setLocale(_list[_selected_index].mobile_app_code);

      if (widget.model == 'merchant') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MerchantStatistics();
        }));
      } else if (widget.model == 'user') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserMain(
            go_back: false,
          );
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: Stack(
            children: [
              RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                onRefresh: _onRefresh,
                displacement: 0,
                child: CustomScrollView(
                  controller: _mainScrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: buildLanguageMethodList(),
                        ),
                      ]),
                    )
                  ],
                ),
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
        "${S.of(context).change_language} (${app_language.$}) - (${app_mobile_language.$})",
        style: TextStyle(
            fontSize: 16,
            color: MyTheme.dark_font_grey,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildLanguageMethodList() {
    if (_isInitial && _list.isEmpty) {
      return Container();
      // return SingleChildScrollView(child: ShimmerHelper().buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (_list.isNotEmpty) {
      return SingleChildScrollView(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 14,
            );
          },
          itemCount: _list.length,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return buildPaymentMethodItemCard(index);
          },
        ),
      );
    } else if (!_isInitial && _list.isEmpty) {
      return SizedBox(
          height: 100,
          child: Center(
              child: Text(
            'no language added',
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  GestureDetector buildPaymentMethodItemCard(index) {
    return GestureDetector(
      onTap: () {
        onLanguageItemTap(index);
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecorations.buildBoxDecoration_1().copyWith(
                border: Border.all(
                    color: _selected_index == index
                        ? MyTheme.accent_color
                        : MyTheme.light_grey,
                    width: _selected_index == index ? 1.0 : 0.0)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                              /*Image.asset(
                          _list[index].image,
                          fit: BoxFit.fitWidth,
                        ),*/
                              FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: _list[index].image,
                            fit: BoxFit.fitWidth,
                          ))),
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${_list[index].name} - ${_list[index].code} - ${_list[index].mobile_app_code}",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: MyTheme.font_grey,
                                fontSize: 14,
                                height: 1.6,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          app_language_rtl.$
              ? Positioned(
                  left: 16,
                  top: 16,
                  child: buildCheckContainer(_selected_index == index),
                )
              : Positioned(
                  right: 16,
                  top: 16,
                  child: buildCheckContainer(_selected_index == index),
                )
        ],
      ),
    );
  }

  Container buildCheckContainer(bool check) {
    return Container();
  }
}
