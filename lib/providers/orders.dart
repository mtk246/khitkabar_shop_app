import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItems({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItems> _orders = [];

  List<OrderItems> get orders {
    return [..._orders];
  }

  Future<void> addOrders(List<CartItem> cartProducts, double total) async {
    const url =
        'https://khit-kabar-flutter-app-default-rtdb.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();

    final response = await http.post(
      url,
      body: json.encode(
        {
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cartProductItem) => {
                    'id': cartProductItem.id,
                    'title': cartProductItem.title,
                    'quantity': cartProductItem.quantity,
                    'price': cartProductItem.price,
                  })
              .toList(),
        },
      ),
    );

    _orders.insert(
      0,
      OrderItems(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    const url =
        'https://khit-kabar-flutter-app-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(url);
    final List<OrderItems> loadedOrders = [];
    final extractedOrders = json.decode(response.body) as Map<String, dynamic>;

    if (extractedOrders == null) {
      return;
    }

    extractedOrders.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItems(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map(
                (items) => CartItem(
                  id: items['id'],
                  price: items['price'],
                  quantity: items['quantity'],
                  title: items['title'],
                ),
              )
              .toList(),
          dateTime: DateTime.parse(
            orderData['dateTime'],
          ),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
