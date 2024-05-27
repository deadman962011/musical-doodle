import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_bank_accounts_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_bank_account_repository.dart';
import 'package:com.mybill.app/screens/user/add_bank_account.dart';
import 'package:com.mybill.app/screens/user/bank_account_edit.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';

class BankAccounts extends StatefulWidget {
  const BankAccounts({super.key});

  @override
  _BankAccountsState createState() => _BankAccountsState();
}

class _BankAccountsState extends State<BankAccounts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  List<BankAccountMini> _bank_accounts = [];

  @override
  void initState() {
    fetchAll();

    super.initState();
  }

  fetchAll() async {
    fetchCoupons();
  }

  reset() async {
    fetchAll();
  }

  fetchCoupons() async {
    setState(() {
      isLoading = true;
    });
    var response =
        await UserBankAccountRepository().getUserBankAccountsResponse();
    if (response.runtimeType.toString() == 'UserBankAccountsResponse') {
      UserBankAccountsResponse data = response;

      setState(() {
        _bank_accounts = data.payload;
      });
    } else {}

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(
              context, 'notifications', S.of(context).notifications, {}),
          body: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                displacement: 0,
                onRefresh: () async {
                  reset();
                },
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildBankAccountList(),
                    ],
                  ),
                ),
              )),
        ));
  }

  Widget _buildBankAccountList() {
    if (isLoading) {
      return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 80),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerHelper().buildBasicShimmer(height: 120),
              ShimmerHelper().buildBasicShimmer(height: 120),
              ShimmerHelper().buildBasicShimmer(height: 120),
              ShimmerHelper().buildBasicShimmer(height: 120),
            ],
          ));
    } else {
      if (_bank_accounts.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/credit_card.png',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No Bank accounts',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                child: Text(
                  'Add new bank account',
                  style: TextStyle(
                      color: MyTheme.accent_color, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddBankAccount();
                  }));
                },
              ),
            )
          ],
        );
      } else {
        return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Column(
                  children: _bank_accounts
                      .map(
                          (bank_account) => _buildBankAccountItem(bank_account))
                      .toList(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    child: Text(
                      'Add new bank account',
                      style: TextStyle(
                          color: MyTheme.accent_color,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddBankAccount();
                      }));
                    },
                  ),
                )
              ],
            ));
      }
    }

    // return _buildNoNotifications();
  }

  Widget _buildBankAccountItem(BankAccountMini bank_account) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/credit_card.png'),
            Text(bank_account.bankName),
            Icon(
              Icons.arrow_right,
              color: MyTheme.accent_color,
            )
          ],
        ),
        decoration: BoxDecorations.buildBoxDecoration2(),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BankAccountEdit(
            bankAccountId: bank_account.id,
          );
        }));
      },
    );
  }
}
