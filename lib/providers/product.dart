import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String categories;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.categories,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  // @override
  // toString() =>
  //     'Id: $id,Title: $title,Description: $description,Categories: $categories,Price: $price,ImageUrl: $imageUrl,';

  void _favStatus(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    final url =
        'https://khit-kabar-flutter-app-default-rtdb.firebaseio.com/products/$id.json';

    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'isFavourite': isFavourite,
          },
        ),
      );
      if (response.statusCode >= 400) {
        _favStatus(oldStatus);
      }
    } catch (error) {
      _favStatus(oldStatus);
    }
  }
}
