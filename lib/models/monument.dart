import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Monument with ChangeNotifier {
  Monument(
      {this.id,
      this.monumentName,
      this.rating,
      this.imageUrl,
      this.location,
      this.article,
      this.review,
      this.longitude,
      this.latitude,
      this.isFavorite = false});
  static const baseUrl = 'https://historia-8452f-default-rtdb.firebaseio.com/';
  final String id;
  final String monumentName;
  final double rating;
  final String imageUrl;
  final String location;
  final String article;
  final String review;
  final double longitude;
  final double latitude;

  bool isFavorite;

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = '$baseUrl/userFav/$userId/$id.json?auth=$token';

    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      print('1 response.statusCode ${response.statusCode}');
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
        print('2 response.statusCode ${response.statusCode}');
      }
    } catch (error) {
      _setFavValue(oldStatus);
      print('error: ${error.toString()}');
    }
  }
}
