// import 'dart:html';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/image1.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.85), BlendMode.dstIn),
          ),
        ),
        child: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                child: Text(
                  'Welcome to ',
                  style: TextStyle(
                    fontFamily: 'BOUNCY',
                    fontSize: 25,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                'Historia',
                style: TextStyle(
                  fontFamily: 'Antens',
                  fontSize: 100,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              child: Text(
                'your virtual tour guide',
                style: TextStyle(
                  fontFamily: 'BOUNCY',
                  fontSize: 30,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            Transform.translate(
                offset: Offset(1, 295.0),
                child: Container(
                  width: 200.0,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 228, 181, 0.89),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'signup');
                    },
                    child: Text(
                      'Create an account',
                    ),
                  ),
                )),
            Transform.translate(
              offset: Offset(1, 305.0),
              child: Container(
                width: 200.0,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 228, 181, 0.89),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'signin');
                  },
                  child: Text(
                    'Sign In',
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(1, 200.0),
              child: InkWell(
                child: Text(
                  'Continue without signing in',
                  style: TextStyle(
                    fontFamily: 'Calibri',
                    fontSize: 12,
                    color: const Color(0xffe9e9e9),
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'userhome');
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
