import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/user/wallet/user_wallet_transactions_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_wallet_repository.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';

class UserWalletHistory extends StatefulWidget {
  const UserWalletHistory({Key? key}) : super(key: key);

  @override
  _WalletHistoryState createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<UserWalletHistory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mainScrollController = ScrollController();
  bool _isTransactionsHistoryLoading = true;
  List<UserWalletTransactions> _transactionsHistoryList = [];
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
        _isTransactionsHistoryLoading = true;
        reset();
        fetchWithdrawBalanceHistory();
      }
    });
  }

  fetchWithdrawBalanceHistory() async {
    setState(() {
      _isTransactionsHistoryLoading = true;
    });

    var response =
        await UserWallettRepository().getUserWalletHistoryResponse(_page);
    if (response.runtimeType.toString() == 'UserWalletTransactionsResponse') {
      UserWalletTransactionsResponse data = response;
      _transactionsHistoryList = data.payload.data;
    }

    setState(() {
      _isTransactionsHistoryLoading = false;
    });
  }

  reset() {
    setState(() {
      _page = 1;
      _isTransactionsHistoryLoading = true;
      _transactionsHistoryList.clear();
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
          appBar: UserAppBar.buildUserAppBar(
              context,
              'user_wallet_transactions_history',
              S.of(context).wallet_history, {}),
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
                      child: _isTransactionsHistoryLoading
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
    if (_transactionsHistoryList.length > 0) {
      return Column(
          children: _transactionsHistoryList.map((_transactions) {
        Color stateColor = Colors.black;

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
                      _transactions.reason == 'withdraw_balance'
                          ? S.of(context).withdraw_balance
                          : _transactions.reason == 'redeem_coupon'
                              ? S.of(context).redeem_points
                              : '',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_transactions.createdAt.toString()),
                    Text(
                      '${_transactions.amount} ${S.of(context).point}',
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
