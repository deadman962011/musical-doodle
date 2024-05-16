import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/device_info.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_auth_repository.dart';
import 'package:com.mybill.app/repositories/user/user_auth_repository.dart';
import 'package:com.mybill.app/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckMail extends StatefulWidget {
  final String email;
  final String model;

  const CheckMail({Key? key, required this.email, required this.model})
      : super(key: key);

  @override
  _CheckMailState createState() => _CheckMailState();
}

class _CheckMailState extends State<CheckMail> with TickerProviderStateMixin {
  late AnimationController _controller;
  late bool showOpenEmailBtn = true;
  late String buttonAction = '';
  int levelClock = 45;

  bool _isLoading = false;
  bool _displayCounter = false;
  Future<void> _launchEmail() async {
    // debugPrint(url);
    String url = buttonAction;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    late String url;
    String email = widget.email.toString();
    debugPrint(email.endsWith('@gmail.com').toString());
    if (email.endsWith('@gmail.com')) {
      url = 'https://mail.google.com/';
    } else if (email.endsWith('@outlook.com') ||
        email.endsWith('@hotmail.com')) {
      url = 'https://outlook.live.com/';
    } else if (email.endsWith('@yahoo.com')) {
      url = 'https://login.yahoo.com/';
    } else if (email.endsWith('@protonmail.com')) {
      url = 'https://account.proton.me/login';
    } else if (email.endsWith('@yandex.com')) {
      url = 'https://360.yandex.com/mail/';
    } else {
      url = '';
      setState(() {
        showOpenEmailBtn = false;
      });
    }
    setState(() {
      buttonAction = url;
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _counterAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _displayCounter = false;
      });
    }
  }

  Future<void> resendEmail() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.model == 'user') {
      await UserAuthRepository()
          .getUserAuthenticateResponse(widget.email)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value.runtimeType.toString() == 'ValidationResponse') {
        } else if (value.runtimeType.toString() == 'UserLoginResponse') {}
      });
    } else if (widget.model == 'merchant') {
      await MerchantAuthRepository()
          .getMerchantAuthenticateResponse(widget.email)
          .then((value) => {
                if (value.runtimeType.toString() == 'MerchantLoginResponse') {}
              });
    }
    setState(() {
      _controller = AnimationController(
          vsync: this, duration: Duration(seconds: levelClock));
      _controller.forward();
      _controller.addStatusListener(_counterAnimationStatusListener);
      _displayCounter = true;
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AuthScreen.buildScreen(
        context, 'Chcek Your Email', checkMail(), false, scaffoldKey);
  }

  Widget checkMail() {
    return Container(
      width: DeviceInfo(context).width,
      margin: const EdgeInsets.only(top: 100, bottom: 40),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
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
                  AppLocalizations.of(context)!.check_your_email,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 3.0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.we_sent_you_confirmatin_email,
                    style: TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.email.toString(),
                        style: TextStyle(
                            color: MyTheme.accent_color,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 18,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    child: showOpenEmailBtn
                        ? TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: MyTheme.accent_color,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () async {
                              await _launchEmail();
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 2),
                                child: Text(
                                  AppLocalizations.of(context)!.open_email,
                                  style: TextStyle(
                                    color: MyTheme.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )))
                        : Text(
                            AppLocalizations.of(context)!
                                .please_check_your_email_inbox,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 3.0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.didnt_recive_email,
                            style: TextStyle(
                                color: MyTheme.font_grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            child: _isLoading
                                ? const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        color: Color.fromRGBO(84, 38, 222, 1),
                                      ),
                                    ))
                                : !_displayCounter
                                    ? TextButton(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .resend_email,
                                          style: TextStyle(
                                              color: MyTheme.accent_color,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onPressed: () async {
                                          await resendEmail();
                                        },
                                      )
                                    : Countdown(
                                        animation: StepTween(
                                          begin:
                                              levelClock, // THIS IS A USER ENTERED NUMBER
                                          end: 0,
                                        ).animate(_controller),
                                      ),
                          ),
                        ],
                      )),
                ],
              )),
        ],
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;
  bool displayTimer = false;
  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    if (animation.value == 0) {
      print('animation.value  ${animation.value} ');
    }
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          "$timerText",
          style: TextStyle(
            fontSize: 20,
            color: MyTheme.grey_153,
          ),
        ));
  }
}
