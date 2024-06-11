import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/user/coupon/user_coupon_details_response.dart';
import 'package:com.mybill.app/models/responses/user/coupon/user_coupon_redeem_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_coupon_repository.dart';
import 'package:com.mybill.app/screens/user/redeem_points_history.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';

class CouponDetails extends StatefulWidget {
  final int couponId;

  const CouponDetails({Key? key, required this.couponId}) : super(key: key);

  @override
  _CouponDetailsState createState() => _CouponDetailsState();
}

class _CouponDetailsState extends State<CouponDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isCouponDetailsLoading = true;
  CouponDetailsItem? couponDetails;
  int? selectedCouponVariation;
  int couponQty = 0;

  fetchCouponDetails() async {
    setState(() {
      isCouponDetailsLoading = true;
    });
    var response = await UserCouponRepository()
        .getUserCouponDetailsResponse(widget.couponId);
    if (response.runtimeType.toString() == 'UserCouponDetailsResponse') {
      UserCouponDetailsResponse data = response;
      debugPrint(data.payload.toString());
      setState(() {
        couponDetails = data.payload;
      });
    } else {}

    setState(() {
      isCouponDetailsLoading = false;
    });
  }

  void redeemCoupon() async {
    var response = await UserCouponRepository().getUserRdeemCouponResponse(
        couponDetails!.id, selectedCouponVariation!, couponQty);

    if (response.runtimeType.toString() == 'UserCouponRedeemResponse') {
      UserCouponRedeemResponse data = response;
      debugPrint(data.payload.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RedeemPointsHistory();
      }));
    } else {}
  }

  bool isFormValid() {
    if (isCouponDetailsLoading) {
      return false;
    }
    if (selectedCouponVariation == null) {
      return false;
    }
    if (couponQty == 0) {
      return false;
    }

    return true;
  }

  Color bgColorSub() {
    if (!isFormValid()) {
      return MyTheme.accent_color_shadow;
    }
    return MyTheme.accent_color;
  }

  selectCouponVariation(int id) {
    setState(() {
      selectedCouponVariation = id;
      couponQty = 0;
    });
  }

  increaseQty() {
    setState(() {
      couponQty = couponQty + 1;
    });
  }

  reduceQty() {
    if (couponQty > 0) {
      setState(() {
        couponQty = couponQty - 1;
      });
    }
  }

  String getExpireyUnitTranslation(expirey_unit) {
    if (expirey_unit == 'year') {
      return S.of(context).year;
    }
    if (expirey_unit == 'month') {
      return S.of(context).month;
    }
    if (expirey_unit == 'day') {
      return S.of(context).day;
    }
    if (expirey_unit == 'hour') {
      return S.of(context).hour;
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    fetchCouponDetails();
  }

  @override
  Widget build(BuildContext context) {
    // return ;

    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(
              context, 'coupon_details', S.of(context).coupon_detals, {}),
          body: isCouponDetailsLoading
              ? Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ShimmerHelper().buildBasicShimmer(height: 100),
                      ShimmerHelper().buildBasicShimmer(height: 100),
                      ShimmerHelper().buildBasicShimmer(height: 100),
                      ShimmerHelper().buildBasicShimmer(height: 100),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: MyTheme.accent_color,
                  backgroundColor: Colors.white,
                  displacement: 0,
                  onRefresh: () async {
                    // reset();
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Image.network(
                                            couponDetails!.thumbnail,
                                            width: 200,
                                            // height: 100,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              child: couponDetails!
                                                          .variations.length >
                                                      1
                                                  ? Text(
                                                      '${S.of(context).valid_for} ${couponDetails!.expirey_amount} ${getExpireyUnitTranslation(couponDetails!.expirey_unit)} /  ${couponDetails!.minAmount} ${S.of(context).sar} - ${couponDetails!.maxAmount} ${S.of(context).sar}')
                                                  : Text(
                                                      '${S.of(context).valid_for} ${couponDetails!.expirey_amount} ${getExpireyUnitTranslation(couponDetails!.expirey_unit)}  '))
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: _build_quntity_control()),
                                      _build_variation_list(),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: _build_details_accordion())
                              ],
                            )),
                      ),
                      _build_action_card()
                    ],
                  )),
        ));
  }

  Widget _build_quntity_control() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Ink(
          width: 50,
          height: 50,
          decoration: ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 10,
                spreadRadius: 0.0,
                offset:
                    const Offset(0.0, 6.0), // shadow direction: bottom right
              )
            ],
            shape: CircleBorder(
                side: BorderSide(
                    width: 0.1, color: Colors.black.withOpacity(.09))),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            color: MyTheme.accent_color,
            onPressed: () {
              increaseQty();
            },
          ),
        ),
        Text(couponQty.toString()),

        Ink(
          width: 50,
          height: 50,
          decoration: ShapeDecoration(
            color: couponQty == 0 ? Colors.grey.shade200 : Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 10,
                spreadRadius: 0.0,
                offset:
                    const Offset(0.0, 6.0), // shadow direction: bottom right
              )
            ],
            shape: CircleBorder(
                side: BorderSide(
                    width: 0.1, color: Colors.black.withOpacity(.09))),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.remove,
              size: 30,
            ),
            color: MyTheme.accent_color,
            onPressed: () {
              reduceQty();
            },
          ),
        )

        // Icon(Icons)
      ],
    );
  }

  Widget _build_variation_list() {
    if (couponDetails != null && couponDetails!.variations.length > 0) {
      return Wrap(
        children: couponDetails!.variations.map((variation) {
          return GestureDetector(
            child: Container(
                width: 80,
                margin: EdgeInsets.all(6),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.24),
                      blurRadius: 2,
                      spreadRadius: 0.0,
                      offset: const Offset(0.0, 0.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                      color: selectedCouponVariation == variation.id
                          ? MyTheme.accent_color
                          : Colors.white,
                      width: 1.6),
                  // borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: [
                    Text(
                      variation.amount.toString(),
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: variation.is_active
                              ? selectedCouponVariation == variation.id
                                  ? MyTheme.accent_color
                                  : Colors.black
                              : Colors.grey),
                    ),
                    Text(S.of(context).sar,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: variation.is_active
                                ? selectedCouponVariation == variation.id
                                    ? MyTheme.accent_color
                                    : Colors.black
                                : Colors.grey))
                  ],
                )),
            onTap: variation.is_active
                ? () {
                    selectCouponVariation(variation.id);
                  }
                : () {},
          );
        }).toList(),
      );
    } else {
      return Container();
    }
  }

  Widget _build_details_accordion() {
    return Column(
      children: [
        Divider(
          color: MyTheme.divider_color,
        ),
        ExpansionTile(
          shape: Border(),
          title: Text(S.of(context).about_this_coupon),
          iconColor: MyTheme.accent_color,
          trailing: Icon(Icons.arrow_drop_down),
          collapsedIconColor: MyTheme.accent_color,
          controlAffinity: ListTileControlAffinity.trailing,
          childrenPadding: EdgeInsets.symmetric(horizontal: 24),
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(couponDetails!.description),
            )
          ],
        ),
        Divider(
          color: MyTheme.divider_color,
        ),
        ExpansionTile(
          shape: Border(),
          title: Text(S.of(context).refund_details),
          iconColor: MyTheme.accent_color,
          trailing: Icon(Icons.arrow_drop_down),
          collapsedIconColor: MyTheme.accent_color,
          controlAffinity: ListTileControlAffinity.trailing,
          childrenPadding: EdgeInsets.symmetric(horizontal: 24),
          children: [
            Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  couponDetails!.refundDetails,
                ))
          ],
        ),
        Divider(
          color: MyTheme.divider_color,
        ),
      ],
    );
  }

  Widget _build_action_card() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 160,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).quantity),
                  Row(
                    children: [
                      Text(couponQty.toString()),
                      IconButton(
                          onPressed: () {
                            increaseQty();
                          },
                          icon: Icon(
                            Icons.add,
                            color: MyTheme.accent_color,
                          ))
                    ],
                  )
                ],
              )),
          Divider(
            color: MyTheme.divider_color,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: bgColorSub(), //MyTheme.accent_color
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onPressed: isFormValid()
                          ? () async {
                              redeemCoupon();
                            }
                          : () {},
                      child: Text(
                        S.of(context).redeem_points,
                        style: TextStyle(
                          color: MyTheme.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ))))
        ],
      ),
    );
  }
}
