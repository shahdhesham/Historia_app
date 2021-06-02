import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_gp/models/monument.dart';

import 'auth.dart';

class Monuments with ChangeNotifier {
  Monuments(this.authToken, this.userId, this._monumentDB);
  static const baseUrl =
      'https://historia-8452f-default-rtdb.firebaseio.com/';

  List<Monument> _monumentDB = [];
  String authToken;
  String userId;

  List<Monument> get items {
    return [..._monumentDB];
  }

  List<Monument> get favoriteItems {
    return _monumentDB.where((monumentName) => monumentName.isFavorite).toList();
  }

  Monument findById(String id) {
    return _monumentDB.firstWhere((monument) => monument.id == id);
  }

  List<Monument> returnAll() {
    return _monumentDB;
  }

  Future<void> fetchAndSetMonuments({bool filterByUser = false}) async {
    final filterString =
        filterByUser ? 'orderBy="ownerId"&equalTo="$userId"' : '';

    var url = '$baseUrl/monuments.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData == null) {
        return;
      }
      url = '$baseUrl/userFav/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      final loadedMonuments = <Monument>[];
      dbData.forEach((monumentId, data) {
        print('Monuments receiveToken, monumwnt: $monumentId');
        loadedMonuments.add(Monument(
          id: monumentId,
          monumentName: data['monumentName'],
          rating: data['rating'],
          location: data['location'],
          number: data['number'],
          
          longitude: data['Lng'],
          latitude: data['Ltd'],
          imageUrl: data['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[monumentId] ?? false,
        ));
      });
      _monumentDB = loadedMonuments;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteMonument(String id) async {
    final url = '$baseUrl/monuments/$id.json?auth=$authToken';
    final existingProductIndex = _monumentDB.indexWhere((monuments) => monuments.id == id);

    var existingProduct = _monumentDB[existingProductIndex]; //optimistic update
    _monumentDB.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _monumentDB.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }

  Future<void> addMonuments(Monument monument) async {
    final url = '$baseUrl/monuments.json?auth=$authToken';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'monumentName': monument.monumentName,
          'rating': monument.rating,
          'location': monument.location,
          'number': monument.number,
          'imageUrl': monument.imageUrl,
          'Lng': monument.longitude,
          'Ltd': monument.latitude,
        }),
      );

      final newMonument = Monument(
          monumentName: monument.monumentName,
          rating: monument.rating,
          location: monument.location,
          number: monument.number,
          imageUrl: monument.imageUrl,
          longitude:monument.longitude,
          latitude: monument.latitude,
          id: json.decode(response.body)['name']);

      _monumentDB.add(newMonument);
      notifyListeners();
    }
    //).catchError
    catch (error) {
      print(error);
      throw error;
    }
    //);
  }

  Future<void> updateMonument(String id, Monument newMonument) async {
    final url = '$baseUrl/monuments/$id.json?auth=$authToken';

    final monumentIndex = _monumentDB.indexWhere((monument) => monument.id == id);
    if (monumentIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'id': newMonument.id,
            'monumentName': newMonument.monumentName,
            'rating': newMonument.rating,
            'location': newMonument.location,
            'number': newMonument.number,
           
            'Lng': newMonument.longitude,
            'Lat': newMonument.latitude,
            'imageUrl': newMonument.imageUrl,
            'Ltd': newMonument.longitude,
          }));
      _monumentDB[monumentIndex] = newMonument;
      notifyListeners();
    }
  }

  void receiveToken(Auth auth, List<Monument> items) {
    authToken = auth.token;
    userId = auth.userId;

    _monumentDB = items;
    print(authToken);
  }
}
