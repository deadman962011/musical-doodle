import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/deposit_bank_account/all_deposit_bank_accounts.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/deposit_bank_accounts_repository.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_subscription_repository.dart';
import 'package:com.mybill.app/screens/merchant/statistics/statistics.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:toast/toast.dart';

class PayUpgradeBank extends StatefulWidget {
  String plan_id = '';

  PayUpgradeBank({Key? key, required this.plan_id}) : super(key: key);

  @override
  _PayUpgradeBankState createState() => _PayUpgradeBankState();
}

class _PayUpgradeBankState extends State<PayUpgradeBank> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  List<DropdownMenuItem<Object>> _depositBankAccouts = [];
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _depositAtController = TextEditingController();

  bool _isLoading = false;
  String fullPhone = '';
  Country _country = Country(
    name: "Saudi Arabia",
    nameTranslations: {
      "no": "Saudi-Arabia",
      "sk": "Saudská Arábia",
      "se": "Saudi-Arábia",
      "pl": "Arabia Saudyjska",
      "ja": "サウジアラビア",
      "it": "Arabia Saudita",
      "zh": "沙特阿拉伯",
      "nl": "Saoedi-Arabië",
      "de": "Saudi-Arabien",
      "fr": "Arabie saoudite",
      "es": "Arabia Saudí",
      "en": "Saudi Arabia",
      "pt_BR": "Arábia Saudita",
      "sr-Cyrl": "Саудијска Арабија",
      "sr-Latn": "Saudijska Arabija",
      "zh_TW": "沙烏地阿拉",
      "tr": "Suudi Arabistan",
      "ro": "Arabia Saudită",
      "ar": "السعودية",
      "fa": "عربستان سعودی",
      "yue": "沙地阿拉伯"
    },
    flag: "🇸🇦",
    code: "SA",
    dialCode: "966",
    minLength: 9,
    maxLength: 9,
  );

  bool isFormValid() {
    if (_formKey.currentState != null && !_formKey.currentState!.isValid) {
      return false;
    }
    if (_isLoading) {
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

  onPressedSendPayUpgradenReq() async {
    setState(() {
      _isLoading = true;
    });

    // final TextEditingController _fullNameController = TextEditingController();
    // final TextEditingController _phoneController = TextEditingController();
    // final TextEditingController _bankNameController = TextEditingController();
    // final TextEditingController _accountNumberController =TextEditingController();
    // final TextEditingController _ibanController = TextEditingController();
    // final TextEditingController _depositAtController = TextEditingController();

    String fullname = _fullNameController.text.toString();
    String phoneNumber = _phoneController.text.toString();
    String bankName = _bankNameController.text.toString();
    String accountNumber = _accountNumberController.text.toString();
    String iban = _ibanController.text.toString();
    String depositAt = _depositAtController.text.toString();

    var response = await MerchantSubscriptionRepository()
        .getSaveMerchantSubscriptionRequestResponse(
      fullname,
      phoneNumber,
      bankName,
      accountNumber,
      iban,
      widget.plan_id,
    );
    if (response.runtimeType.toString() ==
        'MerchantSavePaySubscriptionBankRequestResponse') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MerchantStatistics();
      }));
    }
    // if (response.runtimeType.toString() == 'UnexpectedErrorResponse') {

    // }

    ToastComponent.showDialog(response.message, context,
        gravity: Toast.bottom, duration: Toast.lengthLong);
    setState(() {
      _isLoading = false;
    });
  }

  fetchDepositBankAccounts() async {
    List<DropdownMenuItem<Object>> dropDownItems = [];

    var response =
        await DepositBankAccountsRepository().getDepositBankAccountsResponse();

    if (response.runtimeType.toString() == 'AllDepoistBankAccountsResponse') {
      List<DepositBankAccount> _depositBankAccoutsItems = response.payload;
      debugPrint(_depositBankAccoutsItems.toString());
      if (_depositBankAccoutsItems.isNotEmpty) {
        for (var _depositBankAccout in _depositBankAccoutsItems) {
          dropDownItems.add(DropdownMenuItem(
            value: _depositBankAccout.id,
            child: Text(
              _depositBankAccout.bankName,
              // style: TextStyle(color: Colors.white),
            ),
          ));
        }
      }

      setState(() {
        _depositBankAccouts = dropDownItems;
      });
    } else if (response.runtimeType.toString() == 'UnexpectedErrorResponse') {
      ToastComponent.showDialog(response.message, context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }
  }

  Widget _customPopupItemBuilder(BuildContext context, item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: item.child,
      ),
    );
  }

  @override
  void initState() {
    fetchDepositBankAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: MerchantAppBar.buildMerchantAppBar(context,
              'pay_upgrade_bank', _scaffoldKey, S.of(context).pay_comission),
          drawer: MerchantDrawer.buildDrawer(context),
          body: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.only(right: 14, left: 14, bottom: 20),
                  child: FormBuilder(
                      onChanged: () {
                        setState(() {});
                      },
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 3),
                                      child:
                                          Text(S.of(context).sender_full_name),
                                    ),
                                    FormBuilderTextField(
                                      name: 'sender_full_name',
                                      controller: _fullNameController,
                                      decoration: InputDecorations
                                          .buildInputDecoration_1(
                                              hint_text: S
                                                  .of(context)
                                                  .offer_name_placeholder),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.minLength(3),
                                      ]),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 3),
                                      child:
                                          Text(S.of(context).sender_bank_name),
                                    ),
                                    FormBuilderTextField(
                                      name: 'sender_bank_name',
                                      controller: _bankNameController,
                                      decoration: InputDecorations
                                          .buildInputDecoration_1(
                                              hint_text: S
                                                  .of(context)
                                                  .offer_name_placeholder),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.minLength(3),
                                      ]),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 3),
                                      child: Text(S
                                          .of(context)
                                          .sender_bank_account_number),
                                    ),
                                    FormBuilderTextField(
                                      name: 'sender_bank_account_number',
                                      controller: _accountNumberController,
                                      decoration: InputDecorations
                                          .buildInputDecoration_1(
                                              hint_text: S
                                                  .of(context)
                                                  .offer_name_placeholder),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.minLength(3),
                                      ]),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 3),
                                      child: Text(S
                                          .of(context)
                                          .sender_bank_account_iban),
                                    ),
                                    FormBuilderTextField(
                                      name: 'sender_bank_iban',
                                      controller: _ibanController,
                                      decoration: InputDecorations
                                          .buildInputDecoration_1(
                                              hint_text: S
                                                  .of(context)
                                                  .offer_name_placeholder),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.minLength(24)
                                      ]),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 3),
                                      child: Text(
                                          S.of(context).sender_phone_number),
                                    ),
                                    IntlPhoneField(
                                      enabled: true,
                                      onChanged: (phone) {
                                        List<int> _prefixes = [
                                          50,
                                          53,
                                          54,
                                          55,
                                          59,
                                          58,
                                          56,
                                          57
                                        ];
                                        if (phone.number.length > 3) {
                                          int prefix = int.parse(
                                              phone.number.substring(0, 2));
                                          bool containsPrefix =
                                              _prefixes.contains(prefix);
                                          if (phone.number.length >=
                                                  _country.minLength &&
                                              phone.number.length <=
                                                  _country.maxLength &&
                                              containsPrefix) {
                                            setState(() {
                                              fullPhone = phone.number;
                                            });
                                          } else {
                                            setState(() {
                                              fullPhone = '';
                                            });
                                          }
                                        }
                                      },
                                      countries: [_country],
                                      controller: _phoneController,
                                      decoration: InputDecorations
                                          .buildDropdownInputDecoration_1(),
                                      initialCountryCode: 'SA',
                                    )
                                  ],
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Padding(
                                //       padding:
                                //           EdgeInsets.only(top: 0, bottom: 3),
                                //       child: Text(S.of(context).deposited_at),
                                //     ),
                                //     FormBuilderDateTimePicker(
                                //       lastDate: DateTime.now(),
                                //       name: 'birth_date',
                                //       controller: _depositAtController,
                                //       autovalidateMode:
                                //           AutovalidateMode.disabled,
                                //       decoration: InputDecorations
                                //           .buildInputDecoration_1(
                                //               hint_text:
                                //                   S.of(context).birthDate),
                                //       validator: FormBuilderValidators.compose([
                                //         FormBuilderValidators.required(),
                                //       ]),
                                //       inputType: InputType.date,
                                //       textInputAction: TextInputAction.next,
                                //     )
                                //   ],
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 3),
                                      child: Text(S.of(context).deposited_at),
                                    ),
                                    DropdownSearch(
                                      dropdownBuilder: (context, selectedItem) {
                                        if (selectedItem != null) {
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                child: ListTile(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  title: selectedItem,
                                                ),
                                              ));
                                        } else {
                                          return Text(S
                                              .of(context)
                                              .select_bank_account);
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            // categoriesIds = value.value.toString();
                                          },
                                        );
                                      },
                                      popupProps: PopupPropsMultiSelection.menu(
                                        itemBuilder: _customPopupItemBuilder,
                                        showSearchBox: false,
                                        isFilterOnline: true,
                                      ),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecorations
                                                .buildInputDecoration_1(
                                                    hint_text:
                                                        S.of(context).search),
                                      ),
                                      items: _depositBankAccouts,
                                    )
                                  ],
                                ),

                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Padding(
                                //       padding:
                                //           EdgeInsets.only(top: 12, bottom: 3),
                                //       child: Text(S.of(context).notice),
                                //     ),
                                //     FormBuilderTextField(
                                //         name: 'notice',
                                //         controller: _noticeCodeController,
                                //         decoration: InputDecorations
                                //             .buildInputDecoration_1(
                                //                 hint_text: S
                                //                     .of(context)!
                                //                     .offer_name_placeholder),
                                //         minLines: 4,
                                //         maxLines: null),
                                //   ],
                                // ),
                              ]),
                        ],
                      ))))),
          bottomNavigationBar: Container(
              margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
              height: 46,
              child: TextButton(
                onPressed: isFormValid()
                    ? () {
                        onPressedSendPayUpgradenReq();
                      }
                    : null,
                style: TextButton.styleFrom(
                  // primary: Colors.white,
                  backgroundColor: bgColorSub(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                child: _isLoading
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
                    : Text(S.of(context).save,
                        style: TextStyle(
                          color: MyTheme.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )),
              )),
        ));
  }
}
