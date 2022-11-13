// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:frontend/utilities/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    Future<String?>? _authUser(LoginData data) async {
      debugPrint('Name: ${data.name}, Password: ${data.password}');

      var headersList = {
        'Accept': '*/*',
        'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
        'Content-Type': 'application/json'
      };

      debugPrint(Global.loginPage);
      var url = Uri.parse(Global.loginPage);

      var body = {"email": data.name, "password": data.password};

      var req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();
      var jsonData = jsonDecode(resBody);

      debugPrint(resBody);
      if (jsonData["errorResponse"] == null) {
        prefs.then((pref) {
          pref.setInt("id", jsonData["id"]);
        });
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }

      // var response = http.post(
      //   Uri.parse(Global.loginPage),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: jsonEncode(<String, String>{
      //     'email': data.name,
      //     'password': data.password,
      //   }),
      // );

      // response.then((res) {
      //   debugPrint('Response: ${res.body}');
      //   if (res.statusCode == 200) {
      //     Navigator.of(context).pushNamed('/home');
      //   }
      // });
      // // ignore: unrelated_type_equality_checks

      return null;
    }

    return FlutterLogin(
      logo: AssetImage('images/Helpy_white.jpg'),
      onLogin: _authUser,

      // onSignup: (_) => Future(null),
      // onSubmitAnimationCompleted: () {
      //   Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (context) => DashboardScreen(),
      //   ));
      // },
      onRecoverPassword: (_) => Future(() => 'Okay'),
      theme: LoginTheme(
        accentColor: Colors.grey,
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: Colors.pinkAccent,
          elevation: 9.0,
          highlightElevation: 6.0,
        ),
      ),
    );
  }
}
