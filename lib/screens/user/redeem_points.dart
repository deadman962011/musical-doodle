import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/user/coupon/user_coupons_response.dart';
import 'package:com.mybill.app/repositories/user/user_coupon_repository.dart';
import 'package:com.mybill.app/screens/user/coupon_details.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RedeemPoints extends StatefulWidget {
  const RedeemPoints({Key? key}) : super(key: key);

  @override
  _RedeemPointsState createState() => _RedeemPointsState();
}

class _RedeemPointsState extends State<RedeemPoints> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _couponsScrollController = ScrollController();
  bool isCouponsLoading = true;
  List<CouponMini> _coupons = [];
  final TextEditingController _pointAmountController = TextEditingController();
  int? selectedCoupon;

  fetchCoupons() async {
    setState(() {
      isCouponsLoading = true;
    });
    var response = await UserCouponRepository()
        .getUserCouponsResponse(category: '', page: 1);
    if (response.runtimeType.toString() == 'UserCouponsResponse') {
      UserCouponsResponse data = response;

      setState(() {
        _coupons = data.payload.data;
      });
    } else {}

    setState(() {
      isCouponsLoading = false;
    });
  }

  bool isFormValid() {
    if (isCouponsLoading) {
      return false;
    }
    if (_pointAmountController.value.text.isEmpty) {
      return false;
    }
    if (selectedCoupon == null) {
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

  selectCoupon(int id) {
    setState(() {
      selectedCoupon = id;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(
              context, 'redeem_points', S.of(context).redeem_points, {}),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          _buildAvailablePointsCard(),
                          _buildRedeemAmountCard(),
                          _buildRedeemSelectCouponCard()
                          // child:
                          // Expanded(
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                backgroundColor:
                                    bgColorSub(), //MyTheme.accent_color
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            onPressed: isFormValid()
                                ? () async {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CouponDetails(
                                        couponId: selectedCoupon!,
                                      );
                                    }));
                                  }
                                : () {},
                            child: Text(
                              S.of(context).next,
                              style: TextStyle(
                                color: MyTheme.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            )))
                  ])),
        ));
  }

  Widget _buildAvailablePointsCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecorations.buildBoxDecoration2(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).available_points,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          Text(
            '0 ${S.of(context).points}',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: MyTheme.accent_color),
          )
        ],
      ),
    );
  }

  Widget _buildRedeemAmountCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecorations.buildBoxDecoration2(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).enter_points_amount_you_want_to_redeem,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('${S.of(context).notice}: 1 ${S.of(context).point_at_my_bill_equal} 1 ${S.of(context).sar}'),
          ),
          FormBuilder(
              onChanged: () {
                setState(() {});
              },
              child: Column(
                children: [
                  FormBuilderTextField(
                    // autofocus: false,
                    // autovalidateMode: AutovalidateMode.always,
                    name: 'point_amount',
                    controller: _pointAmountController,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: '20'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                    ]),
                    textInputAction: TextInputAction.next,
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildRedeemSelectCouponCard() {
    return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          alignment: AlignmentDirectional.centerStart,
          decoration: BoxDecorations.buildBoxDecoration2(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).choose_your_gift_from_our_partners),
                  GestureDetector(
                    child: Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: MyTheme.accent_color),
                      child: Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MyTheme.accent_color),
                          onPressed: () {},
                          child: Text(
                            S.of(context).all,
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )),
              _buildCouponList()
            ],
          )),
    );
  }

  Widget _buildCouponList() {
    if (isCouponsLoading) {
      return Container(
          height: 254,
          child: SingleChildScrollView(
              child: ShimmerHelper().buildSquareGridShimmerCoupons(
                  scontroller: _couponsScrollController, item_count: 10)));
    } else {
      if (_coupons.length > 0) {
        return SizedBox(
            height: 258,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 20,
                    childAspectRatio: 2),
                itemCount: _coupons.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(_coupons[index].thumbnail),
                        ),
                        border: selectedCoupon != null &&
                                selectedCoupon == _coupons[index].id
                            ? Border.all(color: MyTheme.accent_color, width: 1)
                            : null,
                        borderRadius: BorderRadius.all(Radius.circular(
                            8.0)), // Border radius for rounded corners
                      ),
                    ),
                    onTap: () {
                      selectCoupon(_coupons[index].id);
                    },
                  );
                }));
      } else {
        return Container(
          height: 254,
          child: Text(S.of(context).no_coupons),
        );
      }
    }
  }
}
