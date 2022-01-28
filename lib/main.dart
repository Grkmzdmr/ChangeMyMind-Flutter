import 'package:change_my_mind/views/account_page.dart';
import 'package:change_my_mind/views/answer_page.dart';
import 'package:change_my_mind/views/first_page.dart';
import 'package:change_my_mind/views/login_page.dart';
import 'package:change_my_mind/views/main_page.dart';
import 'package:change_my_mind/views/person_list.dart';
import 'package:change_my_mind/views/questions_page.dart';
import 'package:change_my_mind/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('tr')],
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashPage(),
      ),
    );
  }
}
