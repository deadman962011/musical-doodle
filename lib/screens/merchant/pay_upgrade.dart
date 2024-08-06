import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/screens/merchant/pay_upgrade_bank.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/repositories/deposit_bank_accounts_repository.dart';
import 'package:com.mybill.app/models/responses/deposit_bank_account/all_deposit_bank_accounts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:toast/toast.dart';

class PayUpgrade extends StatefulWidget {
  final String plan_id;

  const PayUpgrade({Key? key, required this.plan_id}) : super(key: key);

  @override
  _PayUpgradeState createState() => _PayUpgradeState();
}

class _PayUpgradeState extends State<PayUpgrade> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDepositBankAccoutsLoading = false;
  List<DepositBankAccount> _depositBankAccouts = [];
  String selectedPaymentMethod = '';

  bool isFormValid() {
    if (selectedPaymentMethod.isEmpty) {
      return false;
    }

    return true;
  }

  Color bgColorSub() {
    if (isFormValid()) {
      return MyTheme.accent_color;
    } else {
      return MyTheme.accent_color_shadow;
    }
  }

  fetchDepositBankAccounts() async {
    setState(() {
      _isDepositBankAccoutsLoading = true;
    });

    var response =
        await DepositBankAccountsRepository().getDepositBankAccountsResponse();

    if (response.runtimeType.toString() == 'AllDepoistBankAccountsResponse') {
      setState(() {
        _depositBankAccouts = response.payload;
      });
    } else if (response.runtimeType.toString() == 'UnexpectedErrorResponse') {
      ToastComponent.showDialog(response.message, context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }

    setState(() {
      _isDepositBankAccoutsLoading = false;
    });
  }

  handlePayCommission() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PayUpgradeBank(plan_id: widget.plan_id);
    }));
  }

  Widget _buildSelectPaymentMethodCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecorations.buildBoxDecoration2(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).select_payment_method,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          FormBuilder(
              child: Column(
            children: [
              FormBuilderDropdown(
                name: 'payment_method',
                items: [
                  DropdownMenuItem(
                    value: 'bank_transaction',
                    child: Text(S.of(context).bank_transaction),
                  ),
                  DropdownMenuItem(
                    enabled: false,
                    value: 'online',
                    child: Text(
                      S.of(context).online_payment_soon,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                onChanged: (value) => {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                    if (value.toString() == 'bank_transaction') {
                      fetchDepositBankAccounts();
                    }
                  })
                },
                autovalidateMode: AutovalidateMode.disabled,
                decoration:
                    InputDecorations.buildInputDecoration_1(hint_text: '20'),
              )
            ],
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: MerchantAppBar.buildMerchantAppBar(context,
              'commission_payment', _scaffoldKey, 'commission payment'),
          drawer: MerchantDrawer.buildDrawer(context),
          body: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        _buildSelectPaymentMethodCard(),
                        selectedPaymentMethod == 'bank_transaction'
                            ? _buildDepositBankAccountsCard()
                            : Container()
                      ],
                    ),
                  ])),
          bottomNavigationBar: Container(
              margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
              width: double.infinity,
              height: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  // primary: Colors.white,
                  backgroundColor: bgColorSub(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                onPressed: isFormValid()
                    ? () {
                        handlePayCommission();
                      }
                    : null,
                child: Text(
                  S.of(context).next,
                  style: TextStyle(
                    color: MyTheme.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )),
        ));
  }

  Widget _buildDepositBankAccountsCard() {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        alignment: AlignmentDirectional.centerStart,
        decoration: BoxDecorations.buildBoxDecoration2(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).deposit_bank_account,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              Text(
                S.of(context).pay_offer_commission_pay_with_bank_transaction,
                style: TextStyle(color: MyTheme.warning_color),
              ),
              _buildDepositBankAccountList()
            ]));
  }

  Widget _buildDepositBankAccountList() {
    if (_isDepositBankAccoutsLoading) {
      return Container(
          height: 254,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerHelper().buildBasicShimmer(height: 60),
              ShimmerHelper().buildBasicShimmer(height: 60),
              ShimmerHelper().buildBasicShimmer(height: 60),
              ShimmerHelper().buildBasicShimmer(height: 60),
            ],
          )));
    }
    if (_depositBankAccouts.isNotEmpty) {
      return SizedBox(
          height: 260,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: SingleChildScrollView(
                child: Column(
                    children: _depositBankAccouts
                        .map((DepositBankAccount depositBankAccount) =>
                            _buildDepositBankAccountItem(depositBankAccount))
                        .toList()),
              )));
    } else {
      return Text(S.of(context).no_deposit_bank_accounts);
    }
  }

  Widget _buildDepositBankAccountItem(DepositBankAccount depositBankAccount) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecorations.buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${S.of(context).bank_name} :'),
              Text(
                depositBankAccount.bankName,
                style: TextStyle(
                    color: MyTheme.accent_color, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${S.of(context).account_number} :'),
              Text(
                depositBankAccount.accountNumber,
                style: TextStyle(
                    color: MyTheme.accent_color, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${S.of(context).iban} :'),
              Text(
                depositBankAccount.iban,
                style: TextStyle(
                    color: MyTheme.accent_color, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${S.of(context).full_name} :'),
              Text(
                depositBankAccount.fullName,
                style: TextStyle(
                    color: MyTheme.accent_color, fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    );
  }
}
