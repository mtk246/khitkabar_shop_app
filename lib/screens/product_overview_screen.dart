import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

enum FilterOption {
  ShowFavouriteItems,
  ShowAll,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavouriteItems = false;
  bool _isInit = true;
  var _isLoading = true;

  @override
  void initState() {
    // Provider.of<ProductsProvider>(
    //   context,
    //   listen: false,
    // ).fetchAndSetProducts();
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Khit Kabar Shop',
        ),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.ShowFavouriteItems) {
                  _showFavouriteItems = true;
                } else {
                  _showFavouriteItems = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Show Favourite Items',
                ),
                value: FilterOption.ShowFavouriteItems,
              ),
              PopupMenuItem(
                child: Text(
                  'Show All Items',
                ),
                value: FilterOption.ShowAll,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              child: ch,
              value: cartData.itemsCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : ProductsGrid(_showFavouriteItems),
      // floatingActionButton: Consumer<Cart>(
      //   builder: (_, cartData, ch) => Badge(
      //     child: ch,
      //     value: cartData.itemsCount.toString(),
      //   ),
      //   child: FloatingActionButton.extended(
      //     label: Text(
      //       'Cart',
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),
      //     ),
      //     backgroundColor: Theme.of(context).primaryColor,
      //     onPressed: () {
      //       Navigator.of(context).pushNamed(CartScreen.routeName);
      //     },
      //     icon: Icon(
      //       Icons.shopping_cart,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
    );
  }
}
