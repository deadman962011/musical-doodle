import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/items/Offer.dart';
import 'package:com.mybill.app/models/responses/user/offer/user_offer_search_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_offers_repository.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:com.mybill.app/widgets/OfferWidget.dart';
import 'package:flutter/material.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<UserSearch> {
  final TextEditingController _searchController = TextEditingController();
  bool _isOffersLoading = false;
  List<Offer> _offersList = [];
  String selectedFilter = 'nearby';
  List<Map<String, String>> filters = [
    {'name': 'Nearby', 'key': 'nearby'},
    {'name': 'Cashback amount', 'key': 'cashback_amount'},
    {'name': 'alphabet', 'key': 'alphabet'},
  ];

  _fetchSearch() async {
    var query = _searchController.value.text.toString();
    debugPrint(selectedFilter.toString());
    setState(() {
      _isOffersLoading = true;
    });

    var response = await UserOfferRepository()
        .getUserOfferSearchResponse(name: query, filter: selectedFilter);

    if (response.runtimeType.toString() == 'UserOfferSearchResponse') {
      setState(() {
        UserOfferSearchResponse data = response;
        _offersList = data.payload.data;
      });
    }

    setState(() {
      _isOffersLoading = false;
    });
  }

  reset() {
    _fetchSearch();
  }

  _toggleFilters() {
    return showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return _buildShowModalBottomSheet();
      },
    );
  }

  _setFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    reset();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            appBar: UserAppBar.buildUserAppBar(
                context, 'user_search', 'search', {}),
            body: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    _buildSearchInput(),
                    _buildSearchHitory(),
                    _buildOffersList()
                  ],
                )),
            bottomNavigationBar: _offersList.isEmpty && _isOffersLoading
                ? Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor:
                                MyTheme.accent_color, //MyTheme.accent_color
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0))),
                        onPressed: () async {
                          _fetchSearch();
                        },
                        child: Text(
                          S.of(context).search,
                          style: TextStyle(
                            color: MyTheme.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        )))
                : null));
  }

  Widget _buildSearchInput() {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 0, // Spread radius
                      blurRadius: 3, // Blur radius
                      offset: const Offset(-1, 0), // Shadow offset
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8),
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyTheme.accent_color,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.3, color: MyTheme.white),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.3, color: MyTheme.white),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5, color: MyTheme.accent_color_shadow),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: S.of(context).enter_shop_name,
                  ),
                  onSubmitted: (value) {
                    _fetchSearch();
                  },
                )),
            PositionedDirectional(
              end: 0,
              child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: IconButton(
                    style: IconButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        shape: const CircleBorder(),
                        backgroundColor: MyTheme.accent_color),
                    onPressed: _toggleFilters,
                    icon: Icon(Icons.settings_outlined),
                    color: MyTheme.white,
                  )),
            )
          ],
        ));
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

  Widget _buildSearchHitory() {
    if (_offersList.isEmpty) {
      return Container(
          margin: EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'last search ops',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )),
              Wrap(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 6),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 236, 236, 236)),
                    child: Text('macdona'),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 6),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 236, 236, 236)),
                    child: Text('testing'),
                  ),
                ],
              )
            ],
          ));
    } else {
      return Container();
    }
  }

  Widget _buildOffersList() {
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
          child: Text('no offers foubd'),
        );
      } else {
        return Expanded(
            child: SingleChildScrollView(
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

  Widget _buildShowModalBottomSheet() {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          height: 400,
          color: const Color.fromRGBO(255, 255, 255, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text('filters',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                'sort by:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              )),
                          Wrap(
                              children: filters
                                  .map(
                                    (filter) => GestureDetector(
                                      child: Container(
                                        margin: EdgeInsetsDirectional.only(
                                            end: 8, bottom: 8),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color:
                                                selectedFilter == filter['key']!
                                                    ? MyTheme.accent_color
                                                    : Color.fromARGB(
                                                        255, 236, 236, 236)),
                                        child: Text(
                                          filter['name']!,
                                          style: TextStyle(
                                              color: selectedFilter ==
                                                      filter['key']!
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                      onTap: () {
                                        _setFilter(filter['key']!);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                  .toList())
                        ],
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
