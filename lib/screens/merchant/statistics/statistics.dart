import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/merchant/statistics/latest_sales.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MerchantStatistics extends StatefulWidget {
  const MerchantStatistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<MerchantStatistics> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
            appBar: MerchantAppBar.buildMerchantAppBar(context, 'statistics',
                _scaffoldKey, AppLocalizations.of(context)!.add_offer),
            drawer: MerchantDrawer.buildDrawer(context),
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              color: MyTheme.accent_color,
              backgroundColor: Colors.white,
              displacement: 0,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                  child: Container(
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
            const Row(
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
                    'Total sales',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    '5656 SAR',
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
          padding: EdgeInsets.symmetric(vertical: 16),
          child: GestureDetector(
              child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Image.asset('assets/statistics_3.png'),
              const Row(
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
                      'Total sales',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      '5656 SAR',
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
          const Row(
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
                  'Total sales',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  '5656 SAR',
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
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Offers shh'),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MyTheme.accent_color,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  onPressed: () {},
                  child: Text(
                    '11/10/2023',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          _buildOfferSalesItem(),
          _buildOfferSalesItem(),
          _buildOfferSalesItem(),
          _buildOfferSalesItem()
        ],
      ),
    );
  }

  Widget _buildOfferSalesItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Offer 10# bills'),
              Text('you can cancel bill in 14 days')
            ],
          ),
          DataTable(
            horizontalMargin: 6,
            columnSpacing: 12,
            headingRowHeight: 24,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'bill ID',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Customer name',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Date',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Status',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Amount',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Bill',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
            rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('#150', style: TextStyle(fontSize: 12))),
                  DataCell(
                      Text('Ahmad Mouhamad', style: TextStyle(fontSize: 12))),
                  DataCell(Text('1/12/2024', style: TextStyle(fontSize: 12))),
                  DataCell(Text('Canceled', style: TextStyle(fontSize: 12))),
                  DataCell(Text('150 SAR', style: TextStyle(fontSize: 12))),
                  DataCell(GestureDetector(
                    child: ImageIcon(
                      AssetImage('assets/bill.png'),
                      size: 28,
                    ),
                  )),
                  DataCell(Text('X')),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
