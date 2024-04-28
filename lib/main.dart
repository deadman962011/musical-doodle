import 'dart:async';
import 'package:csh_app/providers/offer_provider.dart';
import 'package:csh_app/screens/verifyLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:one_context/one_context.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_value/shared_value.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uni_links/uni_links.dart';
import 'package:csh_app/screens/splash_screen.dart';
import 'package:csh_app/my_theme.dart';
import 'package:csh_app/providers/locale_provider.dart';
import 'app_config.dart';
import 'lang_config.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // AddonsHelper().setAddonsData();
  // BusinessSettingHelper().setBusinessSettingData();
  // app_language.load();
  // app_mobile_language.load();
  // app_language_rtl.load();
  //
  // access_token.load().whenComplete(() {
  //   AuthHelper().fetch_and_set();
  // });

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  runApp(
    SharedValue.wrapApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deepLink = 'No link yet';
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      // Uri? initialLink = await getInitialUri();
      // if (initialLink != null) {
      //   handleDeepLink(initialLink);
      // }
      uriLinkStream.listen((Uri? uri) {
        if (uri != null) {
          handleDeepLink(uri);
        }
      }, onError: (err) {
        print('Failed to get deep link: $err');
      });
    } on PlatformException {
      print('Failed to get deep link');
    }
  }

  void handleDeepLink(Uri uri) {
    if (!mounted) return;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) {
        return VerifyLink(
          url: uri,
        );
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => OfferProvider()),
        ],
        child: Consumer<LocaleProvider>(
            builder: (context, localeProvider, snapshot) {
          return Consumer<OfferProvider>(
              builder: (context, offerProvider, snapshot) {
            return MaterialApp(
              builder: OneContext().builder,
              navigatorKey: navigatorKey,
              title: AppConfig.app_name,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: MyTheme.white,
                scaffoldBackgroundColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                /*textTheme: TextTheme(
                bodyText1: TextStyle(),
                bodyText2: TextStyle(fontSize: 12.0),
              )*/
                //
                // the below code is getting fonts from http
                textTheme: GoogleFonts.publicSansTextTheme(textTheme).copyWith(
                  bodyText1:
                      GoogleFonts.publicSans(textStyle: textTheme.bodyText1),
                  bodyText2: GoogleFonts.publicSans(
                      textStyle: textTheme.bodyText2, fontSize: 12),
                ),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: MyTheme.accent_color),
              ),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              locale: localeProvider.locale,
              supportedLocales: LangConfig().supportedLocales(),
              home: SplashScreen(),
              // home: Splash(),
            );
          });
        }));
  }
}
