import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart.dart';
import '../models/function.dart';
import '../components/description.dart';
import '../components/top_widget_detail_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product_detail_screen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _initNumber = 1;
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final _loadedProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);

    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    Size size = MediaQuery.of(context).size;

    void _increaseNumber() {
      setState(() {
        _initNumber++;
      });
    }

    void _decreaseNumber() {
      setState(() {
        if (_initNumber != 0) {
          _initNumber--;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                setState(() {
                  _loadedProduct.toggleFavouriteStatus();
                  if (_loadedProduct.isFavourite) {
                    buildSnackBar(
                      context,
                      'Favourite Item Added',
                      () {
                        setState(() {
                          _loadedProduct.toggleFavouriteStatus();
                        });
                      },
                    );
                  } else {
                    buildSnackBar(
                      context,
                      'Removed from Favourite Item',
                      () {
                        setState(() {
                          _loadedProduct.toggleFavouriteStatus();
                        });
                      },
                    );
                  }
                });
              },
              icon: FittedBox(
                child: Icon(
                  _loadedProduct.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
              ),
            );
          })
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            Column(
              children: [
                TopWidgetDetailScreen(loadedProduct: _loadedProduct),
                Expanded(
                  child: Description(size: size, loadedProduct: _loadedProduct),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Theme.of(context).accentColor),
                child: Row(
                  children: <Widget>[
                    buildIconButtonNumCounter(
                      context,
                      Icons.remove,
                      () {
                        _decreaseNumber();
                      },
                    ),
                    Text(
                      '$_initNumber',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buildIconButtonNumCounter(
                      context,
                      Icons.add,
                      () {
                        _increaseNumber();
                      },
                    ),
                    buildRaisedButton(
                      context,
                      'Add to Cart',
                      Theme.of(context).primaryColor,
                      () {
                        if (_initNumber != 0) {
                          cart.addItem(
                              _loadedProduct.id,
                              _loadedProduct.title,
                              _loadedProduct.price,
                              _initNumber,
                              _loadedProduct.imageUrl);
                          buildSnackBar(
                            context,
                            'Item added to the cart',
                            () {
                              cart.removeItem(_loadedProduct.id);
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
