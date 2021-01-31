import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Cookies',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.',
    //   categories: 'Cookies',
    //   price: 1000,
    //   imageUrl:
    //       'https://drive.google.com/uc?id=1FEDxozk24pL0KVD8nEvYYRq__u_e9EI_',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Waffles',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.',
    //   categories: 'Waffles',
    //   price: 2000,
    //   imageUrl:
    //       'https://drive.google.com/uc?id=1w3cSHWAhD_JPCITUyZ0NhXlqLBTu5hBc',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Chocolate',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.',
    //   categories: 'Chocolate',
    //   price: 3000,
    //   imageUrl:
    //       'https://drive.google.com/uc?id=18hG7uOr0RqNDFPl1-C2mRNeSC5ep4d1g',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'M & M\'s',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam orci in fringilla malesuada. Nam quis mauris vestibulum, tristique tellus accumsan, imperdiet tellus. Suspendisse et lacus tempus, malesuada ex non, dictum lacus.',
    //   categories: 'Chocolate',
    //   price: 4000,
    //   imageUrl:
    //       'https://drive.google.com/uc?id=140srR2iK-y-azGopLotkubuWibaJeKy4',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((prod) => prod.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Product findByCategory(String category) {
    return _items.firstWhere((catItem) => catItem.categories == category);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://khit-kabar-flutter-app-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) {
          loadedProducts.add(
            Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              categories: prodData['categories'],
              price: prodData['price'],
              imageUrl: prodData['imageUrl'],
            ),
          );
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProducts(Product product) async {
    const url =
        'https://khit-kabar-flutter-app-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavourite': product.isFavourite,
          },
        ),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProducts(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    try {
      if (prodIndex >= 0) {
        final url =
            'https://khit-kabar-flutter-app-default-rtdb.firebaseio.com/products/$id.json';
        await http.patch(
          url,
          body: json.encode(
            {
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price,
            },
          ),
        );
        _items[prodIndex] = newProduct;
        notifyListeners();
      } else {
        print('...');
      }
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> deleteProducts(String id) async {
    final url =
        'https://khit-kabar-flutter-app-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
