import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/merchant/statistics/latest_sales.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';

import 'package:com.mybill.app/generated/l10n.dart';

class MerchantStatistics extends StatefulWidget {
  const MerchantStatistics({super.key});

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<MerchantStatistics> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // reset();
    // fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: MerchantAppBar.buildMerchantAppBar(
                context, 'statistics', _scaffoldKey, S.of(context).statistics),
            drawer: MerchantDrawer.buildDrawer(context),
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              color: MyTheme.accent_color,
              backgroundColor: Colors.white,
              displacement: 0,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                  child: SizedBox(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [_buildStatisticsCards(), _buildOfferSalesBody()],
                ),
              )),
            )));
  }

  Widget _buildStatisticsCards() {
    return Column(children: [
      GestureDetector(
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Image.asset('assets/statistics_2.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ImageIcon(
                    AssetImage(
                      'assets/sales.png',
                    ),
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    S.of(context).total_sales,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    '0 ${S.of(context).sar}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MerchantLatestSales();
          }));
        },
      ),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GestureDetector(
              child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Image.asset('assets/statistics_3.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ImageIcon(
                      AssetImage(
                        'assets/gift.png',
                      ),
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      S.of(context).total_balance,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      '0 ${S.of(context).sar}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ],
          ))),
      GestureDetector(
          child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Image.asset('assets/statistics_1.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ImageIcon(
                  AssetImage(
                    'assets/offers.png',
                  ),
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  S.of(context).total_commission,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  '0 ${S.of(context).sar}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              )
            ],
          ),
        ],
      )),
    ]);
  }

  Widget _buildOfferSalesBody() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).offers),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MyTheme.accent_color,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  onPressed: () {},
                  child: const Text(
                    '11/10/2023',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          _buildOfferItem(),
          _buildOfferItem(),
          _buildOfferItem(),
          _buildOfferItem()
        ],
      ),
    );
  }

  Widget _buildOfferItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${S.of(context).offer} #1 '),
              Text(
                  ' ${S.of(context).you_can_cancel_bill_in}  14 ${S.of(context).day}')
            ],
          ),
          DataTable(
              horizontalMargin: 6,
              columnSpacing: 24,
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
              rows: [
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      '1',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )),
                    DataCell(Text(
                      'ahmad mahmoud',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )),
                    DataCell(Text(
                      '10/12/2024',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )),
                    DataCell(Text(
                      'paid',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )),
                    DataCell(Text(
                      '50',
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
                )
              ])
        ],
      ),
    );
  }
}
