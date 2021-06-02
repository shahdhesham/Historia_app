import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_gp/models/user.dart';


import '../models/HTTPException.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class Users with ChangeNotifier {
  //var user = FirebaseAuth.instance.currentUser;
//print(user.uid);
  List<User> _userDB = [];
  static const baseUrl =
      'https://historia-8452f-default-rtdb.firebaseio.com/';
  Future<void> fetchAndSetProducts() async {
    var url = '$baseUrl/users.json';
    try {
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      final List<User> dbUsers = [];
      dbData.forEach((uid, data) {
        dbUsers.add(User(
          id: uid,
          lname: data['lname'],
          fname: data['fname'],
          number: data['number'],
          image: data['image'],
        ));
      });
      _userDB = dbUsers;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> addUser(User user) async {
    final url = '$baseUrl/users.json';
   // FirebaseAuth auth = FirebaseAuth.instance;



    try {
      final response = await http.post(
        url,
        body: json.encode({
          'fname': user.fname,
          'lname': user.lname,
          'number': user.number,
          'image': user.image,
        }),
      );

      final newStore = User(
          fname: user.fname,
          lname: user.lname,
          number: user.number,
          image: user.image,
          id: json.decode(response.body)['uid']);

      _userDB.add(newStore);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateUser(String id, User newUser) async {
    final url =
        'https://historia-8452f-default-rtdb.firebaseio.com/$id.json';

    final userIndex = _userDB.indexWhere((user) => user.id == id);
    if (userIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'id': newUser.id,
            'number': newUser.number,
            'image': newUser.image,
            'lname': newUser.lname,
            'fname': newUser.fname,
          }));
      _userDB[userIndex] = newUser;
      notifyListeners();
    }
  }

  void deleteUser(String id) {
    final url =
        'https://historia-8452f-default-rtdb.firebaseio.com//users/$id.json';
    final existingInd = _userDB.indexWhere((element) => element.id == id);
    var existing = _userDB[existingInd];
    _userDB.removeAt(existingInd);
    http.delete(url).then((res) {
      if (res.statusCode >= 400) {
        _userDB.insert(existingInd, existing);
        notifyListeners();
        print(res.statusCode);
        throw HTTPException('Delete Failid for id is $id');
      }
    });
    notifyListeners();
  }
}
