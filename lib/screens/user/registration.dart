import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/helpers/auth_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/user/user_auth_repository.dart';
import 'package:com.mybill.app/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/screens/user/main.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl_phone_field/countries.dart';

class UserRegistration extends StatefulWidget {
  final String email;

  const UserRegistration({super.key, required this.email});

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  //controllers

  Map<String, dynamic> _errors = {};
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _gender = '';
  final TextEditingController _referralCodeController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool obscureText = true;
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

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onPressSignUp() async {
    String firstName = _firstNameController.text.toString();
    String lastName = _lastNameController.text.toString();
    String birthDate = _birthDateController.text.toString();
    String referralCode = _referralCodeController.text.toString();
    setState(() {
      _isLoading = true;
    });
    debugPrint(_gender);
    await UserAuthRepository()
        .getUserCompleteRegisterResponse(
            widget.email, firstName, lastName, _gender, birthDate, referralCode)
        .then((value) {
      debugPrint(value.runtimeType.toString());
      debugPrint(fullPhone);
      if (value.runtimeType.toString() == 'UserCompleteRegisterResponse') {
        //authHelper
        AuthHelper().setUserData(value.payload);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return UserMain();
        }));
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Color bgColorSub() {
    if (_formKey.currentState == null || !_formKey.currentState!.isValid) {
      return MyTheme.accent_color_shadow;
    }
    if (_isLoading) {
      return MyTheme.accent_color_shadow;
    }

    return MyTheme.accent_color;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AuthScreen.buildScreen(
        context, 'User Registration', userRegistration(), true, scaffoldKey);
  }

  Widget userRegistration() {
    return Container(
        width: DeviceInfo(context).width,
        margin: const EdgeInsets.only(top: 140, bottom: 40),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/envelop.png',
                width: 180,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    S.of(context).please_enter_your_informations_to_continue,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ),
            FormBuilder(
              key: _formKey,
              onChanged: () {
                setState(() {
                  // _errors = {};
                });
              },
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FormBuilderTextField(
                    // autofocus: false,
                    // autovalidateMode: AutovalidateMode.always,
                    name: 'first_name_name',
                    controller: _firstNameController,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: S.of(context).firstname),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                    ]),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FormBuilderTextField(
                    // autofocus: false,
                    // autovalidateMode: AutovalidateMode.always,
                    name: 'last_name_name',
                    controller: _lastNameController,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: S.of(context).lastname),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                    ]),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                // Padding(
                //     padding: const EdgeInsets.only(bottom: 8),
                //     child: IntlPhoneField(
                //       enabled: true,
                //       disableLengthCheck: true,
                //       onChanged: (phone) {
                //         List<int> _prefixes = [50, 53, 54, 55, 59, 58, 56, 57];
                //         int prefix = int.parse(phone.number.substring(0, 2));
                //         bool containsPrefix = _prefixes.contains(prefix);
                //         if (phone.number.length >= _country.minLength &&
                //             phone.number.length <= _country.maxLength &&
                //             containsPrefix) {
                //           setState(() {
                //             fullPhone = phone.number;
                //             _errors['phone'] = "";
                //           });
                //         } else {
                //           setState(() {
                //             fullPhone = '';
                //             _errors['phone'] = [
                //               S.of(context).phone_number_is_invalid
                //             ];
                //           });
                //         }
                //       },
                //       countries: [_country],
                //       controller: _phoneController,
                //       decoration:
                //           InputDecorations.buildDropdownInputDecoration_1(
                //               error_text: _errors['phone'] != null &&
                //                       _errors['phone'].length > 0
                //                   ? _errors['phone']![0]
                //                   : null),
                //       initialCountryCode: 'SA',
                //     )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FormBuilderDateTimePicker(
                    lastDate: DateTime.now(),
                    name: 'birth_date',
                    controller: _birthDateController,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: S.of(context).birthDate),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    inputType: InputType.date,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FormBuilderDropdown(
                      name: 'gender',
                      items: [
                        DropdownMenuItem(
                            value: 'male', child: Text(S.of(context).male)),
                        DropdownMenuItem(
                            value: 'female', child: Text(S.of(context).female))
                      ],
                      decoration:
                          InputDecorations.buildDropdownInputDecoration_1(
                              hint_text: S.of(context).select_gender),
                      onChanged: (value) {
                        _gender = value.toString();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FormBuilderTextField(
                    // autofocus: false,
                    // autovalidateMode: AutovalidateMode.always,
                    controller: _referralCodeController,
                    name: 'referral_code',
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: S.of(context).referral_code),
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: 130,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        // primary: Colors.white,
                        backgroundColor: bgColorSub(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: !_isLoading
                            ? const EdgeInsets.symmetric(vertical: 12)
                            : null,
                      ),
                      onPressed: _formKey.currentState != null &&
                                  _formKey.currentState!.isValid ||
                              _isLoading
                          ? () {
                              onPressSignUp();
                            }
                          : null,
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
                          : Text(
                              S.of(context).continue_b,
                              style: TextStyle(
                                color: MyTheme.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).by_clicking_continue_you_are,
                          style: TextStyle(
                              color: MyTheme.grey_153,
                              fontSize: 8,
                              fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero),
                            onPressed: () {},
                            child: Text(S.of(context).terms_conditions,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: MyTheme.accent_color,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w300))),
                      ],
                    )),
              ]),
            )
          ],
        ));
  }
}
