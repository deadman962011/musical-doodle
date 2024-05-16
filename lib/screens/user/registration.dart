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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserRegistration extends StatefulWidget {
  final String email;

  const UserRegistration({super.key, required this.email});

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  //controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  String _gender = '';
  final TextEditingController _referralCodeController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool obscureText = true;

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
    String first_name = _firstNameController.text.toString();
    String last_name = _lastNameController.text.toString();
    String birth_date = _birthDateController.text.toString();
    String referral_code = _referralCodeController.text.toString();
    setState(() {
      _isLoading = true;
    });
    debugPrint(_gender);
    await UserAuthRepository()
        .getUserCompleteRegisterResponse(widget.email, first_name, last_name,
            _gender, birth_date, referral_code)
        .then((value) {
      debugPrint(value.runtimeType.toString());
      if (value.runtimeType.toString() == 'UserCompleteRegisterResponse') {
        //authHelper
        AuthHelper().setUserData(value.payload);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
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
      return MyTheme.grey_153;
    }
    if (_isLoading) {
      return MyTheme.accent_color_shadow;
    }

    return MyTheme.accent_color;
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;

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
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .please_enter_your_informations_to_continue,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                  padding: EdgeInsets.only(bottom: 8),
                  child: FormBuilderTextField(
                    // autofocus: false,
                    // autovalidateMode: AutovalidateMode.always,
                    name: 'first_name_name',
                    controller: _firstNameController,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: AppLocalizations.of(context)!.firstname),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                    ]),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: FormBuilderTextField(
                    // autofocus: false,
                    // autovalidateMode: AutovalidateMode.always,
                    name: 'last_name_name',
                    controller: _lastNameController,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: AppLocalizations.of(context)!.lastname),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                    ]),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: FormBuilderDateTimePicker(
                    lastDate: DateTime.now(),
                    name: 'birth_date',
                    controller: _birthDateController,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: AppLocalizations.of(context)!.birthDate),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    inputType: InputType.date,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: FormBuilderDropdown(
                      name: 'gender',
                      items: [
                        DropdownMenuItem(value: 'male', child: Text('male')),
                        DropdownMenuItem(value: 'female', child: Text('female'))
                      ],
                      decoration:
                          InputDecorations.buildDropdownInputDecoration_1(
                              hint_text: 'Select Gender'),
                      onChanged: (value) {
                        _gender = value.toString();
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: FormBuilderTextField(
                    // autofocus: false,
                    // autovalidateMode: AutovalidateMode.always,
                    controller: _referralCodeController,
                    name: 'referral_code',
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecorations.buildInputDecoration_1(
                        hint_text: AppLocalizations.of(context)!.referral_code),
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
                              AppLocalizations.of(context)!.continue_b,
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
                          AppLocalizations.of(context)!
                              .by_clicking_continue_you_are,
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
                            child: Text(
                                AppLocalizations.of(context)!.terms_conditions,
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
