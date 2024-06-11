import 'dart:async';
import 'package:alice/alice.dart';
import 'package:com.mybill.app/firebase_options.dart';
import 'package:com.mybill.app/helpers/notification_helper.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/providers/offer_provider.dart';
import 'package:com.mybill.app/ui_elements/dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:com.mybill.app/screens/verifyLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
import 'package:com.mybill.app/generated/l10n.dart';

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

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  runApp(
    SharedValue.wrapApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _deepLink = 'No link yet';
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late Alice _alice;

  @override
  void initState() {
    // _alice = Alice(
    //   navigatorKey: navigatorKey,
    //   showNotification: true,
    //   showInspectorOnShake: true,
    //   maxCallsCount: 1000,
    // );
    super.initState();
    // getLocation();
    initUniLinks();
    initFirebase();
    // _checkPermission(() {});
    super.initState();
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

    if (uri.path.toString() == '/to/guest') {
      //do nothing
    } else {
      AppConfig.alice
          .getNavigatorKey()!
          .currentState!
          .push(MaterialPageRoute(builder: (context) {
        return VerifyLink(
          url: uri,
        );
      }));
    }

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    // });
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
              navigatorKey: AppConfig.alice.getNavigatorKey(),
              title: AppConfig.app_name,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                canvasColor: Colors.white,
                primaryColor: MyTheme.white,
                scaffoldBackgroundColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: GoogleFonts.interTightTextTheme(),
                dialogBackgroundColor: Colors.white,
                dialogTheme: DialogTheme(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                ),
                // dialogBackgroundColor:Colors.white

                //  .interTightTextTheme(textTheme).copyWith(
                //   titleMedium: TextStyle(color: MyTheme.accent_color),
                //   titleSmall: TextStyle(color: MyTheme.accent_color),
                //   titleLarge: TextStyle(color: MyTheme.accent_color),
                // bodyLarge: TextStyle(color: MyTheme.accent_color),
                // bodyMedium: TextStyle(color: MyTheme.accent_color),
                // bodySmall: TextStyle(color: MyTheme.accent_color),

                // bodyLarge:
                //     GoogleFonts.interTight(textStyle: textTheme.bodyLarge),
                // bodyMedium: GoogleFonts.interTight(
                //     textStyle: textTheme.bodyMedium, fontSize: 12),
                // ),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: MyTheme.accent_color),
              ),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                S.delegate,
              ],
              locale: localeProvider.locale,
              supportedLocales: LangConfig().supportedLocales(),
              home: const SplashScreen(),
              // home: Splash(),
            );
          });
        }));
  }
}
