import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_bank_account_repository.dart';
import 'package:com.mybill.app/screens/user/bank_accounts.dart';
import 'package:com.mybill.app/ui_elements/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:toast/toast.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({Key? key}) : super(key: key);

  @override
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ibanController = TextEditingController();

  bool _isLoading = false;
  Map<String, dynamic> _errors = {};

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

  onPressedSaveBankAccount() async {
    setState(() {
      _isLoading = true;
    });

    var bank_name = _bankNameController.value.text.toString();
    var full_name = _fullNameController.value.text.toString();
    var account_number = _accountNumberController.value.text.toString();
    var iban = _ibanController.value.text.toString();

    var response = await UserBankAccountRepository()
        .getUsercreateBankAccountResponse(
            bank_name, full_name, account_number, iban);
    if (response.runtimeType.toString() == 'UserCreateBankAccountsResponse') {
      ToastComponent.showDialog('bank account successfully created', context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
      // Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return BankAccounts();
      }));
    } else if (response.runtimeType.toString() == 'ValidationResponse') {
      setState(() {
        _errors = response.errors;
      });
    } else {}

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: UserAppBar.buildUserAppBar(context, 'add_bank_account',
                S.of(context).add_bank_account, {}),
            body: Container(
                padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          FormBuilder(
                            key: _formKey,
                            onChanged: () {
                              setState(() {
                                _errors = {};
                              });
                            },
                            child: Column(
                              children: [
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Padding(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Text(S.of(context).bank_name,
                                          ),
                                        ),
                                        FormBuilderTextField(
                                          name: 'bank_name',
                                          controller: _bankNameController,
                                          decoration: InputDecorations
                                              .buildDropdownInputDecoration_1(),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.minLength(3),
                                          ]),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Padding(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Text(S.of(context).full_name),
                                        ),
                                        FormBuilderTextField(
                                          name: 'full_name',
                                          controller: _fullNameController,
                                          decoration: InputDecorations
                                              .buildDropdownInputDecoration_1(),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.minLength(3),
                                          ]),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Padding(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Text(S.of(context).account_number),
                                        ),
                                        FormBuilderTextField(
                                          name: 'account_number',
                                          controller: _accountNumberController,
                                          decoration: InputDecorations
                                              .buildDropdownInputDecoration_1(
                                                  hint_text: '***************'),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.minLength(3),
                                          ]),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Padding(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Text(S.of(context).iban),
                                        ),
                                        FormBuilderTextField(
                                          name: 'iban',
                                          controller: _ibanController,
                                          maxLength: 24,
                                          decoration: InputDecorations
                                              .buildInputDecoration_1(
                                            hint_text:
                                                'SA**********************',
                                            error_text: _errors['iban'] != null
                                                ? _errors['iban']![0]
                                                : null,
                                          ),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.minLength(24),
                                          ]),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      backgroundColor:
                                          bgColorSub(), //MyTheme.accent_color
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0))),
                                  onPressed: isFormValid()
                                      ? () async {
                                          await onPressedSaveBankAccount();
                                        }
                                      : null,
                                  child: _isLoading
                                      ? const SizedBox(
                                          height: 24, // Set the desired height
                                          child: LoadingIndicator(
                                            indicatorType:
                                                Indicator.ballPulseSync,
                                            colors: [
                                              Color.fromARGB(255, 255, 255, 255)
                                            ], // Customize the color if needed
                                            strokeWidth:
                                                2, // Customize the stroke width if needed
                                            backgroundColor: Colors
                                                .transparent, // Customize the background color if needed
                                          ))
                                      : Text(
                                          'Save',
                                          style: TextStyle(
                                            color: MyTheme.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )

                                  // Text(
                                  //   'save',
                                  //   style: TextStyle(color: Colors.white),
                                  // )
                                  ))
                        ],
                      )
                    ]))));
  }
}
