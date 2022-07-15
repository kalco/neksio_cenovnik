import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neksio_cenovnik/helpers/constant_data.dart';
import 'package:neksio_cenovnik/helpers/constant_widget.dart';
import 'package:neksio_cenovnik/screens/home_page.dart';
import 'package:neksio_cenovnik/screens/sign_in_page.dart';
import 'package:neksio_cenovnik/generated/l10n.dart';
import 'package:neksio_cenovnik/util/pref_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

void initPush() async {
  FirebaseMessaging.instance.getInitialMessage();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    changeStatusColor(primaryColor);
    ConstantData.setThemePosition();
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('mk'),
      ],
      locale: const Locale('mk'),
      debugShowCheckedModeBanner: false,
      title: 'Нексио Ценовник',
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: primaryColor),
      home: const MyHomePage(title: 'Нексио Ценовник'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool firebaseInitialized = false;
  @override
  void initState() {
    super.initState();

    Firebase.initializeApp().then((_) {
      setState(() {
        firebaseInitialized = true;
        initPush();
      });
    });
    ConstantData.setThemePosition();
    signInValue();
    getThemeMode();
  }

  int? themMode;

  getThemeMode() async {
    themMode = await PrefData.getThemeMode();
    ConstantData.setThemePosition();
    setState(() {});
  }

  void signInValue() async {
    final nameStorage = GetStorage();
    final name = nameStorage.read('name');
    int themMode = await PrefData.getThemeMode();

    ConstantData.setThemePosition();

    SystemChrome.setSystemUIOverlayStyle((themMode == 0)
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);

    name != null
        ? Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(0),
                ));
          })
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInPage(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    double size = ConstantWidget.getWidthPercentSize(context, 74);
    double subSize = ConstantWidget.getPercentSize(size, 63.1);
    return Scaffold(
      backgroundColor: bgColor,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SizedBox(
            height: size,
            width: size,
            child: Center(
              child: Image.asset(
                themMode == 0
                    ? ConstantData.assetImagesPath + "neksio-logo.png"
                    : ConstantData.assetImagesPath + "neksio-logo-w.png",
                width: subSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
