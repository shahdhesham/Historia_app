import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _userName;
  String _email;

  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get userName {
    return _userName;
  }

  String get email {
    return _email;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String action) async {
    final apiKey = 'AIzaSyCSOnZOjdaaBYZUjCnz1wtiD_2sPmGDy9I';
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$action?key=$apiKey';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];

      _email = responseData['email'];
      _userName = _email.substring(0, _email.indexOf('@'));
      print('/////Test $_userName');
      if (_userId == null) {
        throw HttpException('User ID is null');
      }
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      print('Auth, User id is : $_userId');
      //print('Auth, Token is : $_token');
      print('Auth, _expiryDate is : $_expiryDate');
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      await prefs.setString('MIUShop_User', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('wisefood_User')) {
      return false;
    }
    final savedUserData =
        json.decode(prefs.getString('wisefood_User')) as Map<String, dynamic>;

    _expiryDate = DateTime.parse(savedUserData['expiryDate']);
    if (_expiryDate.isBefore(DateTime.now())) {
      print('Auto Login Date Check failed');
      return false;
    }

    print('//Auto Login $savedUserData');
    try {
      _token = savedUserData['token'];
      _userId = savedUserData['userId'];
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
    print('Test: $_token');
    print('_expiryDate: $_expiryDate');
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    _email = null;
    _userName = null;
    _authTimer?.cancel();

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    _authTimer = Timer(_expiryDate.difference(DateTime.now()), logout);
  }
}
