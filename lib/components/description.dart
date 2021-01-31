import 'package:flutter/material.dart';
import '../providers/product.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.size,
    @required Product loadedProduct,
  })  : _loadedProduct = loadedProduct,
        super(key: key);

  final Size size;
  final Product _loadedProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 50.0,
        right: 30.0,
        left: 30.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              25.0,
            ),
            topLeft: Radius.circular(25.0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Text(
                'Description :',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  '${_loadedProduct.description}',
                  softWrap: true,
                  style: TextStyle(
                    height: 1.8,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
