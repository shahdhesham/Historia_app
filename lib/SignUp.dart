// import 'dart:html';

import 'package:flutter/material.dart';

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  var _formKey;

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
            child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Text(
                'Crate Account',
                style: TextStyle(
                  fontFamily: 'Antens',
                  fontSize: 86,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.center,
              ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor:Colors.white.withOpacity(0.75),
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor:Colors.white.withOpacity(0.75),
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        labelText: ' Email',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor:Colors.white.withOpacity(0.75),
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        labelText: 'Mobile number',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor:Colors.white.withOpacity(0.75),
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor:Colors.white.withOpacity(0.75),
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(
                    width: 500.0,
              height: 100.0,
                  child: Center(
                    child: Container(
                       width: 250.0,
                height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(255, 228, 181, 0.89),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Sign Up',
                        ),
                      ),
                    ),
                  ),
                ),
                    InkWell(
                          child: SizedBox(
                            width: 500.0,
              height: 100.0,
                            child: Center(
                              child: Text(
                                
                'Already Have an Account?',
                style: TextStyle(
                  fontFamily: 'Calibri',
                  fontSize: 12,
                  color: const Color(0xffe9e9e9),
                  decoration: TextDecoration.underline,
                ),

              ),
                            ),
                          ),
              onTap:(){} ,
            ), 
            
              ])),
        )),
      ),
    );
  }
}
