import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/custom/device_info.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/helpers/shimmer_helper.dart';
import 'package:csh_app/models/items/Offer.dart';
import 'package:csh_app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/providers/offer_provider.dart';
import 'package:csh_app/repositories/merchant/merchant_offer_repository.dart';
import 'package:csh_app/screens/merchant/offers/offer_details.dart';
import 'package:csh_app/ui_elements/merchant_drawer.dart';
import 'package:csh_app/ui_elements/merchant_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MerchantOffers extends StatefulWidget {
  MerchantOffers() : super();

  @override
  _MerchantOffersState createState() => _MerchantOffersState();
}

class _MerchantOffersState extends State<MerchantOffers>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _mainScrollController = ScrollController();
  bool _isOffersLoading = true;
  late List<Offer> _offersList = [];
  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    reset();
    fetchOffers();
    super.initState();

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

  @override
  void dispose() {
    super.dispose();
  }

  fetchOffers() async {
    final offerProvider = Provider.of<OfferProvider>(context, listen: false);
    offerProvider.clearFirstOffer();
    await MerchantOfferRepository()
        .getMerchantOffersResponse(page: _page)
        .then((value) {
      if (value.runtimeType.toString() == 'MerchantOffersResponse') {
        _offersList = value.offers;
        if (_offersList.length > 0) {
          offerProvider.setFirstOffer(_offersList.first);
        }
      } else {}
    });
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
              context, 'list_offers', _scaffoldKey),
          drawer: MerchantDrawer.buildDrawer(context),
          extendBody: true,
          body: RefreshIndicator(
              color: MyTheme.accent_color,
              backgroundColor: Colors.white,
              displacement: 0,
              onRefresh: _onRefresh,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
      children: _offersList.length > 0
          ? _offersList.map((offer) {
              TextSpan getOfferStateText(Offer offer) {
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
                    padding: EdgeInsets.only(bottom: 12),
                    child: Container(
                        height: 80,
                        decoration: BoxDecorations.buildBoxDecoration_2(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
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
                                        style: TextStyle(
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
                                      Text('sales'),
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
                                      Text('Commissions'),
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
                                offer: offer,
                              )));
                },
              );
            }).toList()
          : [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.no_offers_found)
                  ],
                ),
              )
            ],
    );
  }
}
