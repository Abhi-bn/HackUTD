// main.dart
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:frontend/emergency.dart';
import 'package:frontend/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final prefs = SharedPreferences.getInstance();

  int? id = 0;
  @override
  Widget build(BuildContext context) {
    prefs.then((value) {
      id = value.getInt("id");
    });

    return MaterialApp(
        title: 'Helpy',
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeScreen(),
          '/login': (BuildContext context) => Login(),
          '/emergency': (BuildContext context) => FormApp(),
        },
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.blue,
          // ignore: prefer_const_constructors
          textTheme: TextTheme(
            headline3: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 45.0,
              color: Colors.blue,
            ),
            button: TextStyle(
              fontFamily: 'OpenSans',
            ),
            subtitle1: TextStyle(
              fontFamily: 'NotoSans',
            ),
            bodyText2: TextStyle(
              fontFamily: 'NotoSans',
            ),
          ),
        ),
        home: (id != 0) ? HomeScreen() : Login());
  }
}
