import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/user/withdraw_balance/user_withdraw_balance_history.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_withdraw_balance_repository.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';

class WithdrawBalanceHistory extends StatefulWidget {
  const WithdrawBalanceHistory({Key? key}) : super(key: key);

  @override
  _WithdrawBalanceHistoryState createState() => _WithdrawBalanceHistoryState();
}

class _WithdrawBalanceHistoryState extends State<WithdrawBalanceHistory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mainScrollController = ScrollController();
  bool _isWithdrawHistoryLoading = true;
  List<WithdrawBalanceHistoryItem> _withdrawHistoryList = [];
  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    reset();
    fetchWithdrawBalanceHistory();
    super.initState();

    _mainScrollController.addListener(() {
      if (_mainScrollController.position.pixels ==
          _mainScrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _isWithdrawHistoryLoading = true;
        reset();
        fetchWithdrawBalanceHistory();
      }
    });
  }

  fetchWithdrawBalanceHistory() async {
    setState(() {
      _isWithdrawHistoryLoading = true;
    });

    var response = await UserWithdrawBalanceRepository()
        .getUserWithdrawBalanceHistoryResponse(_page);
    if (response.runtimeType.toString() ==
        'UserWithdrawBalanceHistoryResponse') {
      UserWithdrawBalanceHistoryResponse data = response;
      _withdrawHistoryList = data.payload.data;
    }

    setState(() {
      _isWithdrawHistoryLoading = false;
    });
  }

  reset() {
    setState(() {
      _page = 1;
      _isWithdrawHistoryLoading = true;
      _withdrawHistoryList.clear();
    });
  }

  Future<void> _onRefresh() async {
    reset();
    fetchWithdrawBalanceHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(context, 'withdraw_points_history',
              'withdraw balance history ', {}),
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
                      child: _isWithdrawHistoryLoading
                          ? _buildLoaderWidget()
                          : _buildWithdrawHistoryList())

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

  Widget _buildWithdrawHistoryEmpty() {
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
                'No Withdraw history',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

  Widget _buildWithdrawHistoryList() {
    if (_withdrawHistoryList.length > 0) {
      return Column(
          children: _withdrawHistoryList.map((withdrawHistory) {
        Color stateColor = Colors.black;
        if (withdrawHistory.state == 'pending') {
          stateColor = MyTheme.warning_color;
        }
        if (withdrawHistory.state == 'rejected') {
          stateColor = MyTheme.red;
        }
        if (withdrawHistory.state == 'approved') {
          stateColor = Colors.green;
        }

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
                      'withdraw balance',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    Text(
                      withdrawHistory.state,
                      style: TextStyle(
                          color: stateColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(withdrawHistory.at.toString()),
                    Text(
                      '${withdrawHistory.amount} points',
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
      return _buildWithdrawHistoryEmpty();
    }
  }
}
