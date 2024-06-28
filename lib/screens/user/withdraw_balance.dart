import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/user/wallet/user_wallet_informations_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_bank_account_repository.dart';
import 'package:com.mybill.app/repositories/user/user_wallet_repository.dart';
import 'package:com.mybill.app/repositories/user/user_withdraw_balance_repository.dart';
import 'package:com.mybill.app/screens/user/withdraw_balance_history.dart';
import 'package:com.mybill.app/screens/user/withdraw_balance_success.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:toast/toast.dart';

class WithdrawBalance extends StatefulWidget {
  const WithdrawBalance({Key? key}) : super(key: key);

  @override
  _WithdrawBalanceState createState() => _WithdrawBalanceState();
}

class _WithdrawBalanceState extends State<WithdrawBalance> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isBankAccountsLoading = true;
  bool isLoading = false;

  final List<DropdownMenuItem<dynamic>> _bank_accounts = [];
  final TextEditingController _pointAmountController = TextEditingController();
  int? selectedBankAccount;

  bool _isWalletInformationsLoading = true;
  UserWalletInformations? _walletInformations;

  bool isFormValid() {
    if (isBankAccountsLoading) {
      return false;
    }
    if (isLoading) {
      return false;
    }
    if (_pointAmountController.value.text.isEmpty) {
      return false;
    }
    if (selectedBankAccount == null) {
      return false;
    }

    return true;
  }

  fetchBankAccounts() async {
    setState(() {
      isBankAccountsLoading = true;
    });
    var response =
        await UserBankAccountRepository().getUserBankAccountsResponse();
    if (response.runtimeType.toString() == 'UserBankAccountsResponse') {
      debugPrint(response.toString());
      List<dynamic> bank_accounts_items = response.payload;
      if (bank_accounts_items.isNotEmpty) {
        for (var bank_account in bank_accounts_items) {
          setState(() {
            _bank_accounts.add(DropdownMenuItem(
              value: bank_account.id,
              child: Text(
                bank_account.bankName,
                // style: TextStyle(color: Colors.white),
              ),
            ));
          });
        }
      }
      setState(() {
        isBankAccountsLoading = false;
      });
    } else if (response.runtimeType.toString() == 'ValidationResponse') {}
  }

  saveWithdrawBalanceRequest() async {
    setState(() {
      isLoading = true;
    });

    var amount = int.parse(_pointAmountController.value.text);
    var response = await UserWithdrawBalanceRepository()
        .getUserCreateWithdrawBalanceResponse(amount, selectedBankAccount!);
    if (response.runtimeType.toString() ==
        'UserSendWithdrawBalanceRequestResponse') {
      ToastComponent.showDialog(
          'balance witdhar request successfully sent', context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WithdrawBalanceSuccess();
      }));
    }

    setState(() {
      isLoading = false;
    });
  }

  Color bgColorSub() {
    if (!isFormValid()) {
      return MyTheme.accent_color_shadow;
    }
    return MyTheme.accent_color;
  }

  fetchWalletInforamtions() async {
    setState(() {
      _isWalletInformationsLoading = true;
    });
    var response =
        await UserWallettRepository().getUserWalletInforamtionsResponse();
    debugPrint(response.toString());
    if (response.runtimeType.toString() == 'UserWalletInformationsResponse') {
      UserWalletInformationsResponse data = response;
      setState(() {
        _walletInformations = data.payload;
      });
    }

    setState(() {
      _isWalletInformationsLoading = false;
    });
  }

  @override
  void initState() {
    //on Splash Screen hide statusbar
    super.initState();
    fetchBankAccounts();
    fetchWalletInforamtions();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: UserAppBar.buildUserAppBar(
              context, 'withdraw_balance', S.of(context).withdraw_balance, {}),
          body: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      _buildAvailablePointsCard(),
                      _buildRedeemAmountCard(),
                      _buildRedeemSelectBankAccountCard(),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            S.of(context).withdraw_blanace_long_text,
                            style: TextStyle(
                                color: MyTheme.grey_153,
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          ))
                    ]),
                  ])),
          bottomNavigationBar: Container(
              margin: EdgeInsets.all(10),
              child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: bgColorSub(), //MyTheme.accent_color
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  onPressed: isFormValid()
                      ? () async {
                          saveWithdrawBalanceRequest();
                        }
                      : () {},
                  child: isLoading
                      ? const SizedBox(
                          height: 36, // Set the desired height
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballPulseSync,
                            colors: [
                              Color.fromARGB(255, 255, 255, 255)
                            ], // Customize the color if needed
                            strokeWidth:
                                2, // Customize the stroke width if needed
                            backgroundColor: Colors
                                .transparent, // Customize the background color if needed
                          ))
                      : Text(
                          S.of(context).save,
                          style: TextStyle(
                            color: MyTheme.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ))),
        ));
  }

  Widget _buildAvailablePointsCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecorations.buildBoxDecoration2(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).available_points,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          !_isWalletInformationsLoading
              ? Text(
                  '${_walletInformations?.availableBalance} ${S.of(context).points}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: MyTheme.accent_color),
                )
              : Text('')
        ],
      ),
    );
  }

  Widget _buildRedeemAmountCard() {
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
            S.of(context).enter_points_amount_you_want_to_redeem,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
                '${S.of(context).notice}: 1 ${S.of(context).point_at_my_bill_equal} 1 ${S.of(context).sar}'),
          ),
          FormBuilder(
              onChanged: () {
                setState(() {});
              },
              child: Column(
                children: [
                  FormBuilderTextField(
                    // autofocus: false,
                    // autovalidateMode: AutovalidateMode.always,
                    name: 'point_amount',
                    controller: _pointAmountController,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: '20'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.minLength(3),
                    ]),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildRedeemSelectBankAccountCard() {
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
            S.of(context).enter_points_amount_you_want_to_redeem,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          FormBuilder(
              onChanged: () {
                setState(() {});
              },
              child: Column(
                children: [
                  FormBuilderDropdown(
                    name: 'point_amount',
                    items: _bank_accounts,
                    // controller: _pointAmountController,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: S.of(context).select_bank_account),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                    ]),
                    onChanged: (value) {
                      selectedBankAccount = value;
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }
}
