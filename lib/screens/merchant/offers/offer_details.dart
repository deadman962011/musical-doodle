import 'package:csh_app/custom/box_decorations.dart';
import 'package:csh_app/custom/device_info.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:csh_app/models/items/Offer.dart';
import 'package:csh_app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/ui_elements/merchant_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              context, 'list_offers', _scaffoldKey),
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
                    color: MyTheme.warning_color,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      'مننهي / غير مدفوع',
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
                          Text('5 %',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w900)),
                          Text(
                            ': الكاش باك',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('145'),
                          Text(': عدد المستفيدين من العرض ',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('14500'),
                          Text(': إجمالي المبيعات ',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700)),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecorations.buildBoxDecoration2(radius: 16),
                  child: _buildSalesList(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: _buildOfferTicket(),
                )
              ],
            ),
          )),
    );
  }

  Widget _buildSalesList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'رقم الفاتورة',
              style: TextStyle(fontSize: 10),
            ),
            Text('اسم العميل', style: TextStyle(fontSize: 10)),
            Text('التاريخ', style: TextStyle(fontSize: 10)),
            Text('المبلغ ', style: TextStyle(fontSize: 10)),
            Text('الفاتورة ', style: TextStyle(fontSize: 10)),
          ],
        ),
        DataTable(
            dividerThickness: 0.00000000000000000001,
            headingRowHeight: 0.00000000000000000001,
            rows: [
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Sarah', style: TextStyle(fontSize: 10))),
                  DataCell(Text('19', style: TextStyle(fontSize: 10))),
                  DataCell(Text('Student', style: TextStyle(fontSize: 10))),
                  DataCell(Text('Student', style: TextStyle(fontSize: 10))),
                  DataCell(Text('Student', style: TextStyle(fontSize: 10))),
                ],
              ),
            ],
            columns: [
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
            ])
      ],
    );
  }

  Widget _buildOfferTicket() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 140,
          color: Color.fromARGB(255, 236, 236, 236),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('4250 ر.س'),
                  Text(':الكاش باك'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('145 ر.س'),
                  Text(':العمولة'),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 14,
            left: -20,
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
            )),
        Positioned(
            bottom: 14,
            right: -20,
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
            )),
      ],
    );
  }
}
