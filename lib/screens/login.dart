import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_auth_repository.dart';
import 'package:com.mybill.app/repositories/user/user_auth_repository.dart';
import 'package:com.mybill.app/screens/check_mail.dart';
import 'package:com.mybill.app/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:loading_indicator/loading_indicator.dart';

class Login extends StatefulWidget {
  final String model;

  Login({required this.model}) : super();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ScrollController _mainScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  Map<String, dynamic> _errors = {};
  @override
  void initState() {
    //on Splash Screen hide statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
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

  onPressedLogin() async {
    var email = _emailController.text.toString();

    setState(() {
      _isLoading = true;
    });

    if (widget.model == 'user') {
      await UserAuthRepository()
          .getUserAuthenticateResponse(email)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value.runtimeType.toString() == 'ValidationResponse') {
          setState(() {
            _errors = value.errors;
          });
        } else if (value.runtimeType.toString() == 'UserLoginResponse') {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CheckMail(
              email: email,
              model: widget.model,
            );
          }));
        }
      });
    } else if (widget.model == 'merchant') {
      await MerchantAuthRepository()
          .getMerchantAuthenticateResponse(email)
          .then((value) => {
                if (value.runtimeType.toString() == 'ValidationResponse')
                  {
                    setState(() {
                      _errors = value.errors;
                    }),
                  }
                else if (value.runtimeType.toString() ==
                    'MerchantLoginResponse')
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CheckMail(email: email, model: widget.model);
                    }))
                  }
                else
                  {},
              });

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AuthScreen.buildScreen(
        context, 'login', login(), false, scaffoldKey);
  }

  Widget login() {
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
                    AppLocalizations.of(context)!.please_login_to_continue,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormBuilder(
                      key: _formKey,
                      onChanged: () {
                        setState(() {
                          _errors = {};
                        });
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 0),
                              child: FormBuilderTextField(
                                name: 'email',
                                controller: _emailController,
                                autovalidateMode: AutovalidateMode.disabled,
                                decoration:
                                    InputDecorations.buildInputDecoration_1(
                                        error_text:
                                            _errors['email'] !=
                                                    null
                                                ? _errors['email']![0]
                                                : null,
                                        hint_text: AppLocalizations.of(context)!
                                            .email),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ]),
                                textInputAction: TextInputAction.done,
                              ))
                        ],
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .no_need_to_remember_your_password,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: MyTheme.grey_153),
                    textAlign: TextAlign.center,
                  )
                ],
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
                          _formKey.currentState!.isValid
                      ? () {
                          onPressedLogin();
                        }
                      : null,

                  // _isLoading
                  //     ? null
                  //     : () {
                  //         onPressedLogin();
                  //       },
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
                            minimumSize: Size.zero, padding: EdgeInsets.zero),
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
          ],
        ));
  }
}
