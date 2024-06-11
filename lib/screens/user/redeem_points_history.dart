import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/user/coupon/user_coupon_redeem_history.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_coupon_repository.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class RedeemPointsHistory extends StatefulWidget {
  const RedeemPointsHistory({Key? key}) : super(key: key);

  @override
  _PreviousCouponRedeemHistoryState createState() =>
      _PreviousCouponRedeemHistoryState();
}

class _PreviousCouponRedeemHistoryState extends State<RedeemPointsHistory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mainScrollController = ScrollController();
  bool _isRedeemHistoryLoading = true;
  List<RedeemHistoryItem> _redeemHistoryList = [];
  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    reset();
    fetchRedeemHistory();
    super.initState();

    _mainScrollController.addListener(() {
      if (_mainScrollController.position.pixels ==
          _mainScrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _isRedeemHistoryLoading = true;
        reset();
        fetchRedeemHistory();
      }
    });
  }

  fetchRedeemHistory() async {
    setState(() {
      _isRedeemHistoryLoading = true;
    });

    var response =
        await UserCouponRepository().getUserCouponRedeemHistoyResponse(_page);
    if (response.runtimeType.toString() == 'UserCouponRedeemHistoryResponse') {
      UserCouponRedeemHistoryResponse data = response;
      _redeemHistoryList = data.payload.data;
    } else {}

    setState(() {
      _isRedeemHistoryLoading = false;
    });
  }

  reset() {
    setState(() {
      _page = 1;
      _isRedeemHistoryLoading = true;
      _redeemHistoryList.clear();
    });
  }

  Future<void> _onRefresh() async {
    reset();
    fetchRedeemHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(context, 'redeem_points_history',
              S.of(context).redeem_points_history, {}),
          extendBody: true,
          body: RefreshIndicator(
              color: MyTheme.accent_color,
              backgroundColor: Colors.white,
              displacement: 0,
              onRefresh: _onRefresh,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: SingleChildScrollView(
                      controller: _mainScrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: _isRedeemHistoryLoading
                          ? _buildLoaderWidget()
                          : _buildRedeemHistoryList())

                  // : _buildRedeemHistoryEmpty()

                  ))),
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

  Widget _buildRedeemHistoryEmpty() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/gift_1.png',
              width: 100,
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No Redeem history',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

  Widget _buildRedeemHistoryList() {
    if (_redeemHistoryList.length > 0) {
      return Column(
          children: _redeemHistoryList.map((redeemHistoryItem) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            height: 100,
            decoration: BoxDecorations.buildBoxDecoration_2(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      redeemHistoryItem.couponName,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    Text(
                      redeemHistoryItem.state == 'used'
                          ? S.of(context).used
                          : "",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(intl.DateFormat('yyyy-MM-dd ')
                        .format(redeemHistoryItem.redeemedAt)),
                    Text(
                      '${redeemHistoryItem.amount} ${S.of(context).point}',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList());
    } else {
      return _buildRedeemHistoryEmpty();
    }

    // return Column(
    //   children: _offersList.isNotEmpty
    //       ? _offersList.map((offer) {
    //           TextSpan getOfferStateText(MerchantOffer offer) {
    //             // Provide default values for state and end_date if they are null
    //             String state = offer.state ?? 'Unknown';
    //             String endDate = offer.end_date ?? 'N/A';
    //             Color textColor;
    //             double fontSize = 12;
    //             switch (state) {
    //               case 'active':
    //                 textColor = Colors.green;
    //                 return TextSpan(
    //                   text: '$state ends at $endDate',
    //                   style: TextStyle(
    //                     color: textColor,
    //                     fontSize: fontSize,
    //                     fontWeight: FontWeight.w300,
    //                   ),
    //                 );
    //               case 'end':
    //                 textColor = Colors.red;
    //                 return TextSpan(
    //                   text: 'Ended at $endDate',
    //                   style: TextStyle(color: textColor, fontSize: fontSize),
    //                 );
    //               case 'pending':
    //                 textColor =
    //                     MyTheme.warning_color; // Example color for pending
    //                 return TextSpan(
    //                   text: 'Pending',
    //                   style: TextStyle(color: textColor, fontSize: fontSize),
    //                 );
    //               case 'expired':
    //                 textColor = Colors.red; // Example color for expired
    //                 return TextSpan(
    //                   text: 'Expired',
    //                   style: TextStyle(color: textColor, fontSize: fontSize),
    //                 );
    //               default:
    //                 textColor = Colors.black; // Default color for unknown
    //                 return TextSpan(
    //                   text: 'Unknown',
    //                   style: TextStyle(color: textColor, fontSize: fontSize),
    //                 );
    //             }
    //           }

    //           return GestureDetector(
    //             child: Padding(
    //                 padding: const EdgeInsets.only(bottom: 12),
    //                 child: Container(
    //                     height: 80,
    //                     decoration: BoxDecorations.buildBoxDecoration_2(),
    //                     child: Padding(
    //                       padding: const EdgeInsets.symmetric(
    //                           horizontal: 12, vertical: 16),
    //                       child: Row(
    //                         children: [
    //                           Expanded(
    //                               flex: 6,
    //                               child: Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     'Offer Num #${offer.id}',
    //                                     style: const TextStyle(
    //                                         fontWeight: FontWeight.w300),
    //                                   ),
    //                                   Wrap(
    //                                     children: [
    //                                       RichText(
    //                                           text: getOfferStateText(offer))
    //                                     ],
    //                                   )
    //                                 ],
    //                               )),
    //                           Expanded(
    //                               flex: 3,
    //                               child: Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.center,
    //                                 children: [
    //                                   const Text('sales'),
    //                                   Text(offer.sales.toString())
    //                                 ],
    //                               )),
    //                           Expanded(
    //                               flex: 3,
    //                               child: Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.center,
    //                                 children: [
    //                                   const Text('Commissions'),
    //                                   Text(offer.commission.toString())
    //                                 ],
    //                               )),
    //                         ],
    //                       ),
    //                     ))),
    //             onTap: () {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => OfferDetails(
    //                             offer: offer,
    //                           )));
    //             },
    //           );
    //         }).toList()
    //       : [
    //           SizedBox(
    //             width: MediaQuery.of(context).size.width,
    //             height: 30,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [Text(S.of(context).no_offers_found)],
    //             ),
    //           )
    //         ],
    // );
  }
}
