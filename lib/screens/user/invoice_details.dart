import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/user/offer_invoice/user_offer_invoice_details_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_offer_invoice.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/widgets.dart';

class UserInvoiceDetails extends StatefulWidget {
  final int offerInvoiceId;
  const UserInvoiceDetails({Key? key, required this.offerInvoiceId})
      : super(key: key);

  @override
  _UserInvoiceDetailsState createState() => _UserInvoiceDetailsState();
}

class _UserInvoiceDetailsState extends State<UserInvoiceDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;
  OfferInvoiceDetails? _offerInvoice;
  @override
  void initState() {
    super.initState();
    fetchInvoiceDetail();
  }

  fetchInvoiceDetail() async {
    setState(() {
      _isLoading = true;
    });
    await UserOfferInvoiceRepository()
        .getUserOfferInvoiceDetailsResponse(id: widget.offerInvoiceId)
        .then((value) {
      if (value.runtimeType.toString() == 'UserOfferInvoiceDetailsResponse') {
        UserOfferInvoiceDetailsResponse data = value;
        setState(() {
          _offerInvoice = data.payload;
        });
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          appBar:
              UserAppBar.buildUserAppBar(context, 'invoice_details', '', {}),
          body: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: _isLoading
                  ? Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          ShimmerHelper().buildBasicShimmer(height: 200),
                          ShimmerHelper().buildBasicShimmer(height: 360),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [_buildInvoiceDetailsHeading()],
                            ),
                            Container(
                              height: 300,
                              margin: EdgeInsets.symmetric(vertical: 30),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'shop name',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20),
                                                ),
                                                Text(_offerInvoice!.shop.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 20))
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            _buildInvoiceDetailsState()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Divider(
                                        color: Colors.grey.shade300,
                                        height: 6,
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'tax number',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          Text(_offerInvoice!.shop.tax_register,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Invoice Date',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                              intl.DateFormat(
                                                      'yyyy-MM-dd h:m a')
                                                  .format(DateTime.parse(
                                                      _offerInvoice!
                                                          .created_at)),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Total with VAT',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.grey)),
                                              Text(_offerInvoice!.amount,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'VAT ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                              ),
                                              Text(_offerInvoice!.vat,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                            width: double.infinity,
                            height: 100,
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'ok',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: MyTheme.accent_color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                            ))
                      ],
                    ))),
    );
  }

  Widget _buildInvoiceDetailsHeading() {
    if (_offerInvoice!.state == 'paid') {
      return Column(
        children: [
          Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 50,
              )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Valid Invoice',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ))
        ],
      );
    } else if (_offerInvoice!.state == 'pending') {
      return Column(
        children: [
          Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.priority_high,
                color: Colors.white,
                size: 50,
              )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Pending Invoice',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ))
        ],
      );
    } else if (_offerInvoice!.state == 'canceled') {
      return Column(
        children: [
          Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.priority_high,
                color: Colors.white,
                size: 50,
              )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Canceled Invoice',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ))
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildInvoiceDetailsState() {
    String text = 'Unknown';
    Color text_color = Colors.red;
    if (_offerInvoice!.state == 'paid') {
      text = 'Approved';
      text_color = Colors.green;
    }
    if (_offerInvoice!.state == 'pending') {
      text = 'Pending';
      text_color = Colors.amber;
    }
    if (_offerInvoice!.state == 'canceled') {
      text = 'Canceled';
      text_color = Colors.red;
    }

    return Container(
      width: 100,
      height: 40,
      alignment: Alignment.center,
      padding: EdgeInsets.all(6),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20, color: text_color, fontWeight: FontWeight.w700),
      ),
      decoration: BoxDecorations.buildBoxDecoration2(),
    );
  }
}
