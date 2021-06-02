import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "loading....",
          style: TextStyle(fontSize: 50),
        ),
        //   Image.asset(
        // 'images/logo.jpg',
        // alignment: Alignment.topCenter,
        // fit: BoxFit.contain,
      ),
      //),
    );
  }
}
