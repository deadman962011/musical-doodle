import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/helpers/auth_helper.dart';
import 'package:csh_app/helpers/shimmer_helper.dart';
import 'package:csh_app/models/items/Category.dart';
import 'package:csh_app/models/items/Offer.dart';
import 'package:csh_app/models/responses/category/all_categories_response.dart';
import 'package:csh_app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/repositories/category_repository.dart';
import 'package:csh_app/repositories/user/user_offers_repository.dart';
import 'package:csh_app/screens/user/main.dart';
import 'package:csh_app/ui_elements/home_map.dart';
import 'package:csh_app/ui_elements/home_search.dart';
import 'package:csh_app/ui_elements/user_appbar.dart';
import 'package:csh_app/widgets/OfferWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';

class UserHome extends StatefulWidget {
  UserHome() : super();

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;

  bool _isCarouselLoading = true;
  bool _isCategoriesLoading = true;
  bool _isOffersLoading = true;
  late int? selectedCategoryId = null;
  List<dynamic> _carouselImageList = [];
  List<CategoryItem> _categoriesList = [];
  List<Offer> _offersList = [];
  bool showMapWidget = false;

  @override
  void initState() {
    fetchAll();

    super.initState();
  }

  reset() {
    // _isCarouselLoading = true;
    // _isCategoriesLoading = true;
    // _isOffersLoading = true;

    _carouselImageList = [];
    _categoriesList = [];
    _offersList = [];
    fetchAll();
    setState(() {});
  }

  fetchAll() async {
    debugPrint('categories feth triggerd');
    fetchCarousel();
    fethCategories();
    fethOffers();
  }

  fetchCarousel() async {
    _isCarouselLoading = false;
    _carouselImageList = ['https://placehold.co/600x400.png'];
  }

  fethCategories() async {
    setState(() {
      _isCategoriesLoading = true;
    });
    var response =
        await CategoryRepository().getAllCategoriesResponse().then((value) {
      if (value.runtimeType.toString() == 'AllCategoriesResponse') {
        setState(() {
          _isCategoriesLoading = false;
          _categoriesList = value.categories;
        });
      }
    });
    // if(response.)
  }

  fethOffers() async {
    setState(() {
      _isOffersLoading = true;
    });
    var response =
        await UserOfferRepository().getUserOffersResponse().then((value) {
      if (value.runtimeType.toString() == 'UserOffersResponse') {
        setState(() {
          _isOffersLoading = false;
          _offersList = value.offers;
        });
      }
    });
  }

  toggleMap() {
    setState(() {
      showMapWidget = !showMapWidget;
    });
  }

  selectCategory(categoryId) {
    selectedCategoryId = categoryId;
    fethOffers();
  }

  toggleFavorite(int offerId) {
    setState(() {
      final offerIndex = _offersList.indexWhere((offer) => offer.id == offerId);
      if (offerIndex != -1) {
        _offersList[offerIndex].isFavorite =
            !_offersList[offerIndex].isFavorite;
      }
    });
  }

  logout() {
    AuthHelper().clearUserData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UserMain();
    }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        child: Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: UserAppBar.buildUserAppBar(context, 'home'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              Expanded(
                  child: RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                displacement: 0,
                onRefresh: () async {
                  reset();
                },
                child: SingleChildScrollView(
                  // physics: ,
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: HomeSearch(onToggle: () => toggleMap())),
                      showMapWidget
                          ? HomeMap()
                          : _buildHomeCarouselSlider(context),
                      _buildCategoriesSlide(),
                      _buildOfferList()
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildCategoriesSlide() {
    if (_isCategoriesLoading) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerHelper().buildBasicShimmer(width: 70, height: 30),
              ShimmerHelper().buildBasicShimmer(width: 70, height: 30),
              ShimmerHelper().buildBasicShimmer(width: 70, height: 30),
              ShimmerHelper().buildBasicShimmer(width: 70, height: 30)
            ],
          ));
    } else {
      if (_categoriesList.isEmpty) {
        return Text('no categories');
      } else {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 12),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategoryId = null;
                            fethOffers();
                          });
                        },
                        child: Container(
                            margin: EdgeInsetsDirectional.only(end: 6),
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: selectedCategoryId != null
                                  ? MyTheme.background_item_color
                                  : MyTheme.accent_color,
                            ),
                            child: Text(
                              'All',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedCategoryId != null
                                      ? Colors.black
                                      : MyTheme.white),
                            ))),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _categoriesList.map((category) {
                          return GestureDetector(
                            child: Container(
                                margin: EdgeInsetsDirectional.only(end: 6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: selectedCategoryId == category.id
                                      ? MyTheme.accent_color
                                      : MyTheme.background_item_color,
                                ),
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                      color: selectedCategoryId == category.id
                                          ? MyTheme.white
                                          : Colors.black),
                                )),
                            onTap: () {
                              selectCategory(category.id);
                            },
                          );
                        }).toList()),
                  ],
                )));
      }
    }
  }

  Widget _buildOfferList() {
    if (_isOffersLoading) {
      return Container(
          margin: EdgeInsets.only(bottom: 80),
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
        return Text('no Offers');
      } else {
        return Container(
            margin: EdgeInsets.only(bottom: 80),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _offersList.map((offer) {
                  return OfferWidget(
                    offer: offer,
                    onToggleFavorite: (int offerId) => toggleFavorite(offer.id),
                  );
                }).toList()));
      }
    }
  }

  // Widget _buildHomeMap(context){

  //   return Container(
  //     height: 40,
  //     child:
  //   );

  // }

  Widget _buildHomeCarouselSlider(context) {
    if (_isCarouselLoading) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else {
      if (_carouselImageList.isEmpty) {
        return Container(
            height: 100,
            child: Center(
                child: Text(
              AppLocalizations.of(context)!.no_offers_found,
              style: TextStyle(color: MyTheme.font_grey),
            )));
      } else {
        return CarouselSlider(
          options: CarouselOptions(
              aspectRatio: 338 / 140,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.easeInExpo,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _current_slider = index;
                });
              }),
          items: _carouselImageList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                          //color: Colors.amber,
                          width: double.infinity,
                          decoration: BoxDecorations.buildBoxDecoration_1(),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/dummy_376x238.png',
                                image: i,
                                height: 140,
                                fit: BoxFit.cover,
                              ))),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        );
      }
    }

    // if (_isCarouselLoading && _carouselImageList.isEmpty) {

    // } else if (_carouselImageList.length > 0) {
    // } else if (!_isCarouselLoading && _carouselImageList.length == 0) {
    //   ;
    // } else {
    //   // should not be happening
    //   return Container(
    //     height: 100,
    //   );
    // }
  }
}
