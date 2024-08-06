import 'package:carousel_slider/carousel_slider.dart';
import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/items/Category.dart';
import 'package:com.mybill.app/models/items/Offer.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/category_repository.dart';
import 'package:com.mybill.app/repositories/slider_repository.dart';
import 'package:com.mybill.app/repositories/user/user_offers_repository.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:com.mybill.app/ui_elements/home_map.dart';
import 'package:com.mybill.app/ui_elements/home_search.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:com.mybill.app/widgets/OfferWidget.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:latlong2/latlong.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  int _page = 0;
  bool _isCarouselLoading = true;
  bool _isCategoriesLoading = true;
  bool _isOffersLoading = true;
  int? selectedCategoryId;
  List<dynamic> _carouselImageList = [];
  List<CategoryItem> _categoriesList = [];
  List<Offer> _offersList = [];
  List _mapPinsLis = [];
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
    _mapPinsLis = [];
    fetchAll();
    setState(() {});
  }

  fetchAll() async {
    fetchCarousel();
    fethCategories();
    fethOffers();
  }

  fetchCarousel() async {
    setState(() {
      _isCarouselLoading = true;
    });

    var response =
        await SliderRepository().getUserHomeSliderResponse().then((value) {
      if (value.runtimeType.toString() == 'HomeSliderResponse') {
        setState(() {
          _isCarouselLoading = false;
          if (value.slider.slides.length > 0) {
            _carouselImageList = value.slider.slides;
          }
        });
      }
    });
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

      _offersList.clear();
    });
    var response = await UserOfferRepository()
        .getUserOffersResponse(page: _page + 1, category: selectedCategoryId)
        .then((value) {
      if (value.runtimeType.toString() == 'UserOffersResponse') {
        List<Offer> offers = value.offers;

        if (offers.isNotEmpty) {
          for (var offer in offers) {
            var pin = {
              'coordinates': LatLng(double.parse(offer.shop['latitude']),
                  double.parse(offer.shop['longitude'])),
              "amount": offer.cashback_amount
            };
            setState(() {
              _mapPinsLis.add(pin);
            });
          }
          setState(() {
            _offersList = offers;
          });
        }
      }
    });

    setState(() {
      _isOffersLoading = false;
    });
  }

  toggleMap() {
    setState(() {
      showMapWidget = !showMapWidget;
    });
  }

  selectCategory(categoryId) {
    if (selectedCategoryId == categoryId) {
      setState(() {
        selectedCategoryId = null;
      });
    } else {
      selectedCategoryId = categoryId;
    }
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
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return UserMain();
    }), (route) => false);
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
        appBar: UserAppBar.buildUserAppBar(context, 'home', '', {}),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: HomeSearch(onToggle: () => toggleMap())),
                      showMapWidget
                          ? HomeMap(
                              items: _mapPinsLis,
                            )
                          : _buildHomeCarouselSlider(context),
                      Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            S.of(context).select_category_home,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                      _buildCategoriesSlide(),
                      Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 10),
                          child: Text(
                            S.of(context).best_offers,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
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
              ShimmerHelper().buildBasicShimmer(width: 70, height: 70),
              ShimmerHelper().buildBasicShimmer(width: 70, height: 70),
              ShimmerHelper().buildBasicShimmer(width: 70, height: 70),
              ShimmerHelper().buildBasicShimmer(width: 70, height: 70),
              ShimmerHelper().buildBasicShimmer(width: 70, height: 70)
            ],
          ));
    } else {
      if (_categoriesList.isEmpty) {
        return Text(S.of(context).no_cateogies);
      } else {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _categoriesList.map((category) {
                    return GestureDetector(
                      child: Container(
                        // margin: const EdgeInsetsDirectional.only(end: 2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: selectedCategoryId ==
                                                    category.id
                                                ? MyTheme.accent_color
                                                : Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        category.thumbnail,
                                        width: 80,
                                        height: 50,
                                      ),
                                    )),
                              ],
                            ),
                            Text(
                              category.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedCategoryId == category.id
                                      ? MyTheme.accent_color
                                      : Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        selectCategory(category.id);
                      },
                    );
                  }).toList()),
            ));
      }
    }
  }

  Widget _buildOfferList() {
    if (_isOffersLoading) {
      return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 80),
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
        return Container(
          height: 260,
          alignment: Alignment.topCenter,
          child: const Text(
            'no Offers',
          ),
        );
      } else {
        return Container(
            margin: const EdgeInsets.only(bottom: 80),
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

  Widget _buildHomeCarouselSlider(context) {
    if (_isCarouselLoading) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else {
      if (_carouselImageList.isEmpty) {
        return SizedBox(
            height: 220,
            child: Center(
                child: Text(
              'no slides Found',
              style: TextStyle(color: MyTheme.font_grey),
            )));
      } else {
        return CarouselSlider(
          options: CarouselOptions(
              // aspectRatio: 338 / 140,
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
                                image: i.image_url,
                                height: 220,
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
  }
}
