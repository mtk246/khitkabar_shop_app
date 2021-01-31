import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_products_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/register_screen.dart';
import 'package:shop_app/screens/sign_in_screen.dart';
import 'package:shop_app/screens/tabs_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Khit Kabar Shop',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: Colors.deepOrange,
          accentColor: Colors.white,
          primaryTextTheme: Theme.of(context)
              .primaryTextTheme
              .apply(bodyColor: Colors.deepOrangeAccent),
          iconTheme: IconThemeData(color: Colors.deepOrangeAccent),
          fontFamily: 'Lato',
        ),
        home: WelcomeScreen(),
        routes: {
          SignInScreen.routeName: (ctx) => SignInScreen(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          TabsScreen.routeName: (ctx) => TabsScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductsScreen.routeName: (ctx) => EditProductsScreen(),
        },
      ),
    );
  }
}
