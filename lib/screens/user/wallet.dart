import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/user/offer_invoice/user_previous_invoice_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_offer_invoice.dart';
import 'package:com.mybill.app/screens/user/invoice_details.dart';
import 'package:com.mybill.app/screens/user/redeem_points.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';

import 'package:com.mybill.app/generated/l10n.dart';

class UserWallet extends StatefulWidget {
  const UserWallet({super.key});

  @override
  _UserWalletState createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> _previousOffersList = [];
  int _page = 0;
  bool _isPreviousOffersLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAll();
  }

  reset() async {
    setState(() {
      fetchPreviousOffers();
    });
  }

  fetchPreviousOffers() async {
    setState(() {
      _isPreviousOffersLoading = true;

      _previousOffersList.clear();
    });
    var response = await UserOfferInvoiceRepository()
        .getUserPreviousOffersInvoiceResponse(
      page: _page + 1,
    )
        .then((value) {
      if (value.runtimeType.toString() == 'UserPreviousOfferInvoiceResponse') {
        UserPreviousOfferInvoiceResponse data = value;
        if (data.payload.data.isNotEmpty) {
          setState(() {
            _previousOffersList = data.payload.data;
          });
        }
      }
    });

    setState(() {
      _isPreviousOffersLoading = false;
    });
  }

  fetchAll() async {
    fetchPreviousOffers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        key: _scaffoldKey,
        body: RefreshIndicator(
            color: MyTheme.accent_color,
            backgroundColor: Colors.white,
            onRefresh: () async {
              reset();
            },
            child: SingleChildScrollView(
                child: Column(
              children: [
                Stack(
                  // alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/wallet_bg.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(height: 300, child: _buildBody())
                  ],
                ),
                _buildWalletBoxes(),
                _buildWalletPreviousOffer()
              ],
            ))),
      ),
    );
  }

  Widget _buildBody() {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: UserAppBar.buildUserAppBar(context, 'wallet', 'wallet', {}),
      drawer: MerchantDrawer.buildDrawer(context),
      body: Column(
        children: [
          _buildWalletMainBox(),
        ],
      ),
    );
  }

  Widget _buildWalletMainBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Available Balance'), Text('0.00')],
              ),
              Text('SAR')
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Pending Balance'), Text('0.00')],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Total Balance'), Text('0.00')],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      backgroundColor: MyTheme.accent_color,
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 6, bottom: 6, end: 6),
                            child: ImageIcon(
                              AssetImage('assets/rep.png'),
                              color: Colors.white,
                              size: 20,
                            )),
                        Text(
                          'My History',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWalletBoxes() {
    return Container(
      margin: const EdgeInsets.only(
        right: 14,
        left: 14,
        top: 6,
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 110,
            height: 110,
            // padding: EdgeInsets.all(26),
            decoration: BoxDecorations.buildBoxDecoration_1(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/wallet_2.png',
                ),
                const Text(
                  'الرصيد المعلق',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const RedeemPoints();
              }));
            },
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecorations.buildBoxDecoration_1(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/wallet_1.png',
                  ),
                  const Text(
                    'استبدال الرصيد',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecorations.buildBoxDecoration_1(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/wallet_3.png',
                ),
                const Text(
                  'سحب الرصيد',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletPreviousOffer() {
    return Container(
        width: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(left: 14, right: 14, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Previous Offers',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            _buildWalletPreviousOffersList()
          ],
        ));
    ;
  }

  Widget _buildWalletPreviousOffersItem(OfferInvoice offerInvoice) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        constraints: BoxConstraints(minHeight: 90),
        decoration: BoxDecorations.buildBoxDecoration2(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  offerInvoice.shopName,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                    offerInvoice.state == 'paid'
                        ? 'Approved at 1/1/2023'
                        : offerInvoice.state == 'pending'
                            ? 'Pending'
                            : offerInvoice.state == 'canceled'
                                ? 'Rejected invoice'
                                : '',
                    style: TextStyle(
                        color: MyTheme.accent_color,
                        fontSize: 14,
                        fontWeight: FontWeight.w500))
                // : offerInvoice.state == 'pending' ? Text() :SizedBox()
              ],
            ),
            offerInvoice.state == 'paid'
                ? Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: MyTheme.accent_color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                '${offerInvoice.points} points',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: ImageIcon(
                                color: MyTheme.accent_color,
                                AssetImage('assets/bill.png'),
                                size: 50,
                              ))
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: offerInvoice.isRewardDivided
                              ? _buildFriendsList()
                              : SizedBox())
                    ],
                  )
                : offerInvoice.state == 'canceled'
                    ? Icon(
                        Icons.priority_high,
                        color: MyTheme.accent_color,
                        size: 36,
                      )
                    : offerInvoice.state == 'pending'
                        ? Icon(
                            Icons.timer,
                            color: MyTheme.accent_color,
                            size: 36,
                          )
                        : SizedBox()
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserInvoiceDetails(
            offerInvoiceId: offerInvoice.id,
          );
        }));
      },
    );
  }

  Widget _buildWalletPreviousOffersList() {
    if (_isPreviousOffersLoading) {
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
      if (_previousOffersList.isEmpty) {
        return Container(
          height: 260,
          alignment: Alignment.center,
          child: const Text(
            'no Offers',
          ),
        );
      } else {
        return Column(
            children: _previousOffersList
                .map((offerInvoice) =>
                    _buildWalletPreviousOffersItem(offerInvoice))
                .toList());
      }
    }
  }

  Widget _buildFriendsList() {
    return Row(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: MyTheme.accent_color, shape: BoxShape.circle),
              child: Text('12', style: TextStyle(color: Colors.white)),
            ),
            Text(
              'انا',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: MyTheme.accent_color, shape: BoxShape.circle),
              child: Text('12', style: TextStyle(color: Colors.white)),
            ),
            Text(
              'انا',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
