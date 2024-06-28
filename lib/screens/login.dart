import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_auth_repository.dart';
import 'package:com.mybill.app/repositories/user/user_auth_repository.dart';
import 'package:com.mybill.app/screens/check_mail.dart';
import 'package:com.mybill.app/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  final String model;

  const Login({super.key, required this.model});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ScrollController _mainScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();

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
      return MyTheme.accent_color_shadow;
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

    var response;

    if (widget.model == 'user') {
      response = await UserAuthRepository().getUserAuthenticateResponse(email);
    } else if (widget.model == 'merchant') {
      response =
          await MerchantAuthRepository().getMerchantAuthenticateResponse(email);
    }

    if (response.runtimeType.toString() == 'ValidationResponse') {
      setState(() {
        _errors = response.errors;
      });
    } else if (response.runtimeType.toString() == 'UserLoginResponse') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CheckMail(
          email: email,
          model: widget.model,
        );
      }));
    } else if (response.runtimeType.toString() == 'MerchantLoginResponse') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CheckMail(email: email, model: widget.model);
      }));
    } else { 
      ToastComponent.showDialog('network_error', context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AuthScreen.buildScreen(context, 'login', login(), true, scaffoldKey);
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    S.of(context).please_login_to_continue,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
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
                              padding: const EdgeInsets.only(bottom: 0),
                              child: FormBuilderTextField(
                                name: 'email',
                                controller: _emailController,
                                autovalidateMode: AutovalidateMode.disabled,
                                decoration:
                                    InputDecorations.buildInputDecoration_1(
                                        error_text: _errors['email'] != null
                                            ? _errors['email']![0]
                                            : null,
                                        hint_text: S.of(context).email),
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    S.of(context).no_need_to_remember_your_password,
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
                            minimumSize: Size.zero, padding: EdgeInsets.zero),
                        onPressed: () {},
                        child: Text(S.of(context).terms_conditions,
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
