import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/items/MerchantIOffer.dart';
import 'package:com.mybill.app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/providers/offer_provider.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_offer_repository.dart';
import 'package:com.mybill.app/screens/merchant/offers/offer_details.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.mybill.app/generated/l10n.dart';

class MerchantOffers extends StatefulWidget {
  const MerchantOffers({super.key});

  @override
  _MerchantOffersState createState() => _MerchantOffersState();
}

class _MerchantOffersState extends State<MerchantOffers>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mainScrollController = ScrollController();
  bool _isOffersLoading = true;
  late List<MerchantOffer> _offersList = [];
  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reset();
    fetchOffers();

    _mainScrollController.addListener(() {
      if (_mainScrollController.position.pixels ==
          _mainScrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _isOffersLoading = true;
        reset();
        fetchOffers();
      }
    });
  }

  fetchOffers() async {
    final offerProvider = Provider.of<OfferProvider>(context, listen: false);
    offerProvider.clearFirstOffer();
    // if (offerProvider.firstOffer != null) {}

    var response =
        await MerchantOfferRepository().getMerchantOffersResponse(page: _page);
    debugPrint(response.runtimeType.toString());
    if (response.runtimeType.toString() == 'MerchantOffersResponse') {
      _offersList = response.offers;
      if (response.offers.isNotEmpty) {
        offerProvider.setFirstOffer(_offersList.first);
      }
    }
    setState(() {
      _isOffersLoading = false;
    });
  }

  reset() {
    setState(() {
      _page = 1;
      _isOffersLoading = true;
      _offersList.clear();
    });
  }

  Future<void> _onRefresh() async {
    reset();
    fetchOffers();
  }
  // getMerchantOffersResponse

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: MerchantAppBar.buildMerchantAppBar(
              context, 'list_offers', _scaffoldKey, S.of(context).offers),
          drawer: MerchantDrawer.buildDrawer(context),
          extendBody: true,
          body: RefreshIndicator(
              color: MyTheme.accent_color,
              backgroundColor: Colors.white,
              displacement: 0,
              onRefresh: _onRefresh,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: SingleChildScrollView(
                      controller: _mainScrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: _isOffersLoading
                          ? _buildLoaderWidget()
                          : _buildOffersList())))),
    );
  }

  Widget _buildLoaderWidget() {
    return Column(
      children: [
        ShimmerHelper().buildBasicShimmer(height: 100),
        ShimmerHelper().buildBasicShimmer(height: 100),
        ShimmerHelper().buildBasicShimmer(height: 100),
        ShimmerHelper().buildBasicShimmer(height: 100),
        ShimmerHelper().buildBasicShimmer(height: 100),
      ],
    );
  }

  Widget _buildOffersList() {
    return Column(
      children: _offersList.isNotEmpty
          ? _offersList.map((offer) {
              TextSpan getOfferStateText(MerchantOffer offer) {
                // Provide default values for state and end_date if they are null
                String state = offer.state ?? 'Unknown';
                String endDate = offer.end_date ?? 'N/A';
                Color textColor;
                double fontSize = 12;
                switch (state) {
                  case 'active':
                    textColor = Colors.green;
                    return TextSpan(
                      text: '$state ends at $endDate',
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w300,
                      ),
                    );
                  case 'end':
                    textColor = Colors.red;
                    return TextSpan(
                      text: 'Ended at $endDate',
                      style: TextStyle(color: textColor, fontSize: fontSize),
                    );
                  case 'pending':
                    textColor =
                        MyTheme.warning_color; // Example color for pending
                    return TextSpan(
                      text: 'Pending',
                      style: TextStyle(color: textColor, fontSize: fontSize),
                    );
                  case 'expired':
                    textColor = Colors.red; // Example color for expired
                    return TextSpan(
                      text: 'Expired',
                      style: TextStyle(color: textColor, fontSize: fontSize),
                    );
                  default:
                    textColor = Colors.black; // Default color for unknown
                    return TextSpan(
                      text: 'Unknown',
                      style: TextStyle(color: textColor, fontSize: fontSize),
                    );
                }
              }

              return GestureDetector(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                        height: 80,
                        decoration: BoxDecorations.buildBoxDecoration_2(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Offer Num #${offer.id}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Wrap(
                                        children: [
                                          RichText(
                                              text: getOfferStateText(offer))
                                        ],
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                        Text(S.of(context).sales),
                                      Text(offer.sales.toString())
                                    ],
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                       Text(S.of(context).commission),
                                      Text(offer.commission.toString())
                                    ],
                                  )),
                            ],
                          ),
                        ))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfferDetails(
                                offerId: offer.id,
                              )));
                },
              );
            }).toList()
          : [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text(S.of(context).no_offers_found)],
                ),
              )
            ],
    );
  }
}
