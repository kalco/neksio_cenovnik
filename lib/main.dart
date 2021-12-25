import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neksio_cenovnik/pages/home_page.dart';
import 'package:neksio_cenovnik/pages/on_boarding_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('Favorite');
  await Hive.openBox('Name');
  runApp(const MyApp());
}

void initPush() async {
  FirebaseMessaging.instance.getInitialMessage();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initalzation = Firebase.initializeApp();
  @override
  Widget build(BuildContext contex) {
    final box = Hive.box('Name');
    final name = box.get(1);
    return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Neksio Cenovnik',
theme: ThemeData(primarySwatch:  Colors.blue, textTheme: GoogleFonts.openSansTextTheme() ),
home: name != null
? FutureBuilder(
  future: _initalzation,
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Scaffold(
        body: Center (
          child: Text(snapshot.hasError.toString()),
        ),
      );
    }
    if (snapshot.connectionState == ConnectionState.done) {
      initPush();
      return HomePage(name:name);
    }
    return const Scaffold(
      body: Center (
        child: CircularProgressIndicator(),
      ),
    );
  },
  )
  :
  const OnBoarding(),

    );
  }
}
