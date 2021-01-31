import 'package:flutter/material.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/models/function.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_items.dart' as ci;
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart_screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: buildAppBarContent('Your Cart', context, kIconThemeColor),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                'Order Summary :',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, item) => ci.CartItems(
                id: cart.items.values.toList()[item].id,
                productId: cart.items.keys.toList()[item],
                title: cart.items.values.toList()[item].title,
                quantity: cart.items.values.toList()[item].quantity,
                price: cart.items.values.toList()[item].price,
                imageUrl: cart.items.values.toList()[item].imageUrl,
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Ks ${cart.totalAmount.toString()}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Chip(
                  //   label: Text(
                  //     '${cart.totalAmount.toString()} MMK',
                  //     style: TextStyle(
                  //         color: Theme.of(context)
                  //             .primaryTextTheme
                  //             .headline1
                  //             .color),
                  //   ),
                  //   backgroundColor: Theme.of(context).primaryColor,
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OrderButton(cart: cart),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: _isLoading
            ? CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              )
            : Text(
                'Place Order',
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
      ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              await Provider.of<Orders>(context, listen: false).addOrders(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );

              setState(() {
                _isLoading = false;
              });

              widget.cart.clearCart();
            },
    );
  }
}
