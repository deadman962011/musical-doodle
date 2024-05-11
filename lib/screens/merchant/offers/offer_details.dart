import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/custom/device_info.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/models/items/Offer.dart';
import 'package:csh_app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/ui_elements/merchant_appbar.dart';
import 'package:csh_app/ui_elements/merchant_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OfferDetails extends StatefulWidget {
  final offer;
  const OfferDetails({Key? key, required this.offer}) : super(key: key);

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isOfferLoading = true;
  late Offer? offer;

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
      offer = null;
    });
  }

  fetchOffer() {}

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: MerchantAppBar.buildMerchantAppBar(
              context, 'offer_details', _scaffoldKey, widget.offer.name),
          drawer: MerchantDrawer.buildDrawer(context),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: widget.offer.state == 'pendig'
                        ? MyTheme.warning_color
                        : widget.offer.state == 'active'
                            ? Colors.green
                            : MyTheme.accent_color,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      widget.offer.state == 'pendig'
                          ? '${AppLocalizations.of(context)!.done} / ${AppLocalizations.of(context)!.unpaid}'
                          : widget.offer.state == 'active'
                              ? '${AppLocalizations.of(context)!.active}'
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
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' ${AppLocalizations.of(context)!.cashback} :',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w900),
                          ),
                          Text('5 %',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              ' ${AppLocalizations.of(context)!.offer_num_of_beneficiaries} :',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700)),
                          widget.offer.state == 'pending'
                              ? Text('-')
                              : Text('0'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              ' ${AppLocalizations.of(context)!.total_sales} :',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700)),
                          widget.offer.state == 'pending'
                              ? Text('-')
                              : Text('0'),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecorations.buildBoxDecoration2(radius: 10),
                    child: _buildSalesList(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: _buildOfferTicket(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.pay,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: MyTheme.warning_color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                    onPressed: () {},
                  ),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.bill_number}',
                  style: TextStyle(fontSize: 10),
                ),
                Text(AppLocalizations.of(context)!.client_name,
                    style: TextStyle(fontSize: 10)),
                Text(AppLocalizations.of(context)!.date,
                    style: TextStyle(fontSize: 10)),
                Text(AppLocalizations.of(context)!.amount,
                    style: TextStyle(fontSize: 10)),
                Text(AppLocalizations.of(context)!.bill,
                    style: TextStyle(fontSize: 10)),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(AppLocalizations.of(context)!.no_data),
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('no data')
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('23'),
                  //     Text('Ahmad AMohamad'),
                  //     Text('20/10/2025'),
                  //     Text('12'),
                  //     Image.asset('assets/bill.png')
                  //   ],
                  // )
                ])
            // DataTable(
            //     dividerThickness: 0.00000000000000000001,
            //     headingRowHeight: 0.00000000000000000001,
            //     rows: [
            //       DataRow(
            //         cells: <DataCell>[
            //           DataCell(Text('Sarah', style: TextStyle(fontSize: 10))),
            //           DataCell(Text('19', style: TextStyle(fontSize: 10))),
            //           DataCell(Text('Student', style: TextStyle(fontSize: 10))),
            //           DataCell(Text('Student', style: TextStyle(fontSize: 10))),
            //           DataCell(Text('Student', style: TextStyle(fontSize: 10))),
            //         ],
            //       ),
            //     ],
            //     columns: [
            //       DataColumn(label: Text('')),
            //       DataColumn(label: Text('')),
            //       DataColumn(label: Text('')),
            //       DataColumn(label: Text('')),
            //       DataColumn(label: Text('')),
            //     ])
          ],
        ));
  }

  Widget _buildOfferTicket() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 18),
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
                        '${AppLocalizations.of(context)!.cashback} :',
                        style: TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 16),
                      ),
                      widget.offer.state == 'pending'
                          ? Text('-')
                          : Text(' 0 ${AppLocalizations.of(context)!.sar}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 16)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${AppLocalizations.of(context)!.commission} : ',
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 16)),
                      widget.offer.state == 'pending'
                          ? Text('-')
                          : Text(
                              '0 ${AppLocalizations.of(context)!.sar}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 16),
                            ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.payment,
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 16,
                          color: MyTheme.accent_color)),
                  widget.offer.state == 'pending'
                      ? Text('-')
                      : Text('0 ${AppLocalizations.of(context)!.sar}',
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
}
