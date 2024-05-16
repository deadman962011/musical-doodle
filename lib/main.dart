import 'dart:async';
import 'package:com.mybill.app/firebase_options.dart';
import 'package:com.mybill.app/helpers/notification_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/items/notification_body.dart';
import 'package:com.mybill.app/providers/offer_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:com.mybill.app/screens/verifyLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:one_context/one_context.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_value/shared_value.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uni_links/uni_links.dart';
import 'package:com.mybill.app/screens/splash_screen.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/providers/locale_provider.dart';
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

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // NotificationBodyModel? body;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
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
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    initUniLinks();
    getLocation();
    initFirebase();
  }

  Future<void> initUniLinks() async {
    try {
      // Uri? initialLink = await getInitialUri();
      // if (initialLink != null) {
      //   handleDeepLink(initialLink);
      // }
      uriLinkStream.listen((Uri? uri) {
        debugPrint(uri.toString());
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
    // if (!mounted) return;
    debugPrint('am at hander deeep link');

    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) {
      return VerifyLink(
        url: uri,
      );
    }));
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    // });
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      user_longitude.$ = position.longitude.toString();
      user_longitude.save();
      user_latitude.$ = position.latitude.toString();
      user_latitude.save();
    }
  }

  void initFirebase() async {
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    // Set foreground notification presentation options
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.subscribeToTopic('all_zone_customer');

    // Get the FCM token
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print('FCM Token: $token');
    });
    // Listen for messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, false);
      // Handle your message here
    });
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
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
                dialogBackgroundColor: Colors.white,
                // the below code is getting fonts from http
                textTheme: GoogleFonts.interTightTextTheme(textTheme).copyWith(
                  bodyText1:
                      GoogleFonts.interTight(textStyle: textTheme.bodyText1),
                  bodyText2: GoogleFonts.interTight(
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
