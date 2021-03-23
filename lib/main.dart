import 'package:flutter/material.dart';
import 'package:ui_gp/ForgetPassword.dart';
import 'package:ui_gp/HomePage.dart';
import 'package:ui_gp/SignIn.dart';
import 'package:ui_gp/SignUp.dart';
import 'package:ui_gp/User_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        'signup': (context) => SignUP(),
        'signin': (context) => SignIn(),
        'forgetpass': (context) => ForgetPassword(),
        'userhome': (context) => UserHome(),
      },
    );
  }
}
