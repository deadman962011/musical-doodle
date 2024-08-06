import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/items/Offer.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_favorite_offers_repository.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:com.mybill.app/widgets/OfferWidget.dart';
import 'package:flutter/material.dart';

import 'package:com.mybill.app/generated/l10n.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String activeTab = 'offers';
  bool _isOfferLoading = false;
  List<Offer> _offersList = [];

  fetch_favorite_offers() async {
    setState(() {
      _isOfferLoading = true;
    });
    var response = await UserFavoriteOfferRepository()
        .getUserFavoriteOffersResponse()
        .then((value) {
      if (value.runtimeType.toString() == 'UserOffersResponse') {
        setState(() {
          _isOfferLoading = false;
          _offersList = value.offers;
        });
      }
    });
  }

  fetch_active_tab() {
    if (activeTab == 'offers') {
      setState(() {
        _isOfferLoading = false;
      });
      fetch_favorite_offers();

      fetch_favorite_offers();
    } else if (activeTab == 'codes') {}
  }

  fetch_favorite_codes() {}

  reset() {
    fetch_active_tab();
  }

  onTabClicked(tab) {
    if (tab == 'offers') {
      fetch_favorite_offers();
    } else if (tab == 'codes') {}

    setState(() {
      activeTab = tab;
    });
  }

  toggleFavorite(int offerId) {
    setState(() {
      _offersList.removeWhere((offer) => offer.id == offerId);
    });
  }

  @override
  void initState() {
    fetch_favorite_offers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: UserAppBar.buildUserAppBar(
                context, 'favorite', S.of(context).favorite, {}),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: RefreshIndicator(
                  color: MyTheme.accent_color,
                  backgroundColor: Colors.white,
                  displacement: 0,
                  onRefresh: () async {
                    reset();
                  },
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // _buildFavoriteTabs(),
                      activeTab == 'offers'
                          ? _buildFavoriteOfferList()
                          : _buildFavoriteCodes()
                    ],
                  )),
            )));

    // Container();
  }

  Widget _buildFavoriteTabs() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                  style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.horizontal(
                              start: Radius.circular(20))),
                      backgroundColor: activeTab == 'codes'
                          ? MyTheme.accent_color
                          : MyTheme.grey_153),
                  onPressed: () {
                    onTabClicked('codes');
                  },
                  child: Text(
                    S.of(context).my_codes,
                    style: TextStyle(
                        color: activeTab == 'codes'
                            ? Colors.white
                            : MyTheme.light_grey),
                  )),
            ),
            Expanded(
                flex: 1,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.horizontal(
                                end: Radius.circular(20))),
                        backgroundColor: activeTab == 'offers'
                            ? MyTheme.accent_color
                            : MyTheme.grey_153),
                    onPressed: () {
                      onTabClicked('offers');
                    },
                    child: Text(S.of(context).offers,
                        style: TextStyle(
                            color: activeTab == 'offers'
                                ? Colors.white
                                : MyTheme.light_grey))))
          ],
        ));
  }

  Widget _buildFavoriteOfferList() {
    if (_isOfferLoading) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerHelper().buildBasicShimmer(height: 160),
              ShimmerHelper().buildBasicShimmer(height: 160),
              ShimmerHelper().buildBasicShimmer(height: 160),
            ],
          ));
    } else {
      if (_offersList.isEmpty) {
        return _build_no_favorite();
      } else {
        return Expanded(
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _offersList.map((offer) {
                      return OfferWidget(
                        offer: offer,
                        onToggleFavorite: (int offerId) =>
                            toggleFavorite(offer.id),
                      );
                    }).toList())));
      }
    }
  }

  Widget _buildFavoriteCodes() {
    return _build_no_favorite();
  }

  Widget _build_no_favorite() {
    return Expanded(
        child: CustomScrollView(slivers: [
      // Wrap your widgets with the SliverToBoxAdapter
      SliverFillRemaining(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            color: MyTheme.accent_color,
            size: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              S.of(context).no_favorites,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ))
    ]));
  }
}
