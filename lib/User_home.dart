// import 'dart:html';

import 'package:flutter/material.dart';

class User_home extends StatefulWidget {
  @override
  _User_homeState createState() => _User_homeState();
}

class _User_homeState extends State<User_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.gps_fixed),
            onPressed: () {},
          ),
        ],
      ),
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
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Welcome Helena ',
                    style: TextStyle(
                      fontFamily: 'Antens',
                      fontSize: 70,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  width: 200.0,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 228, 181, 0.89),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Start Scanning',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  width: 200.0,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 228, 181, 0.89),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Upload Offline',
                    ),
                  ),
                ),
              ),
              //  Padding(
              //   padding: const EdgeInsets.only(top: 60),
              //   child: Container(
              //     width: 200.0,
              //     height: 60,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         primary: Color.fromRGBO(255, 228, 181, 0.89),
              //       ),
              //       onPressed: () {},
              //       child: Text(
              //         'Neaby Monuments',
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  width: 200.0,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 228, 181, 0.89),
                    ),
                    onPressed: () {},
                    child: Text(
                      'My History ',
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
