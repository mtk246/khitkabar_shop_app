import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_items.dart';
import '../models/function.dart';
import '../components/constants.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders_screen';

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: buildAppBarContent('Your Orders', context, kIconThemeColor),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An unknown error occurred'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) {
                  return ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, item) =>
                        OrderItems(orderData.orders[item]),
                  );
                },
              );
            }
          }
        },
      ),
      // _isLoading
      //   ?
      //   :
    );
  }
}
