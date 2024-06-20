import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/items/Offer.dart';
import 'package:com.mybill.app/models/responses/merchant/offer/merchant_offer_details_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_offer_repository.dart';
import 'package:com.mybill.app/screens/merchant/pay_offer_commission.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'package:com.mybill.app/generated/l10n.dart';

class OfferDetails extends StatefulWidget {
  final int offerId;
  const OfferDetails({super.key, required this.offerId});

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isOfferLoading = true;
  OfferDetailsItem? _offerDetails;
  // late Offer? offer;
  Color widgetsColor = MyTheme.accent_color;

  @override
  void initState() {
    reset();
    fetchOffer();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  reset() {
    setState(() {
      _isOfferLoading = true;
      // offer = null;
    });
  }

  fetchOffer() async {
    var response = await MerchantOfferRepository()
        .getMerchantOfferDetailsResponse(widget.offerId);
    if (response.runtimeType.toString() == 'MerchantOfferDetailsResponse') {
      MerchantOfferDetailsResponse data = response;
      setState(() {
        _offerDetails = data.payload;
        if (data.payload.state == 'pending' ||
            data.payload.state == 'expired') {
          widgetsColor = MyTheme.warning_color;
        } else if (data.payload.state == 'active') {
          widgetsColor = Colors.green;
        }
      });
    }

    setState(() {
      _isOfferLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: MerchantAppBar.buildMerchantAppBar(context, 'offer_details',
              _scaffoldKey, _isOfferLoading ? '' : _offerDetails!.name),
          drawer: MerchantDrawer.buildDrawer(context),
          body: _isOfferLoading
              ? _buildLoaderWidget()
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          color: widgetsColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: Text(
                            _offerDetails!.state == 'active'
                                ? S.of(context).active
                                : _offerDetails!.state == 'pending'
                                    ? S.of(context).pending
                                    : _offerDetails!.state == 'expired'
                                        ? S.of(context).expired
                                        : '',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: MyTheme.white,
                            ),
                          ),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' ${S.of(context).cashback} :',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                    _offerDetails!.commissionAmountPercentage
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    ' ${S.of(context).offer_num_of_beneficiaries} :',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                                _offerDetails!.state == 'pending'
                                    ? const Text('-')
                                    : Text(_offerDetails!.beneficiariesCount
                                        .toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(' ${S.of(context).total_sales} :',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                                _offerDetails!.state == 'pending'
                                    ? const Text('-')
                                    : Text(_offerDetails!.cashbackAmount
                                        .toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration:
                              BoxDecorations.buildBoxDecoration2(radius: 10),
                          child: _buildSalesList(),
                        ),
                      ),
                      _offerDetails!.state == 'expired' &&
                              !_offerDetails!.isPaid
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: _buildOfferTicket(),
                            )
                          : Container(),
                      _offerDetails!.state == 'expired' &&
                              !_offerDetails!.isPaid
                          ? Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              width: double.infinity,
                              height: 50,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: MyTheme.warning_color,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PayOfferCommission(
                                                  offerId: _offerDetails!.id,
                                                  amount: _offerDetails!
                                                      .cashbackAmount)));
                                },
                                child: Text(
                                  S.of(context).pay,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          : Container(
                              height: 50,
                            )
                    ],
                  ),
                )),
    );
  }

  Widget _buildSalesList() {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: _offerDetails!.beneficiaries.isNotEmpty
            ? DataTable(
                horizontalMargin: 6,
                columnSpacing: 12,
                headingRowHeight: 24,
                columns: <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        S.of(context).id,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        S.of(context).customre_name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        S.of(context).date,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        S.of(context).status,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        S.of(context).amount,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        S.of(context).bill,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
                rows: _offerDetails!.beneficiaries.isNotEmpty
                    ? _offerDetails!.beneficiaries.map((beneficiary) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              beneficiary.id.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            )),
                            DataCell(Text(
                              beneficiary.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            )),
                            DataCell(Text(
                              intl.DateFormat('M /d/yyyy')
                                  .format(beneficiary.createdAt),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            )),
                            DataCell(Text(
                              beneficiary.state == 'paid'
                                  ? S.of(context).paid
                                  : beneficiary.state == 'pending'
                                      ? S.of(context).pending
                                      : beneficiary.state == 'canceled'
                                          ? S.of(context).canceled
                                          : '',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            )),
                            DataCell(Text(
                              beneficiary.amount,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            )),
                            DataCell(GestureDetector(
                              child: const ImageIcon(
                                AssetImage('assets/bill.png'),
                                size: 28,
                              ),
                            )),
                            // const DataCell(Text('X')),
                          ],
                        );
                      }).toList()
                    : <DataRow>[
                        DataRow(
                          cells: <DataCell>[],
                        ),
                      ],
              )
            : Expanded(
                child: Center(
                  child: Text(S.of(context).no_data),
                ),
              ));
  }

  Widget _buildOfferTicket() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
          height: 140,
          decoration: BoxDecorations.buildBoxDecoration2(radius: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${S.of(context).cashback} :',
                        style: const TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 16),
                      ),
                      _offerDetails!.state == 'pending'
                          ? const Text('-')
                          : Text(
                              ' ${_offerDetails!.cashbackAmount} ${S.of(context).sar}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 16)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${S.of(context).commission} : ',
                          style: const TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 16)),
                      _offerDetails!.state == 'pending'
                          ? const Text('-')
                          : Text(
                              '${_offerDetails!.commission} ${S.of(context).sar}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 16),
                            ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).payment,
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 16,
                          color: MyTheme.accent_color)),
                  _offerDetails!.state == 'pending'
                      ? const Text('-')
                      : Text(
                          '${_offerDetails!.commission} ${S.of(context).sar}',
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                              color: MyTheme.accent_color))
                ],
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 32,
            left: -20,
            child: Container(
              height: 40,
              width: 30,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
            )),
        Positioned(
            bottom: 32,
            right: -20,
            child: Container(
              height: 40,
              width: 30,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
            )),
      ],
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
}
