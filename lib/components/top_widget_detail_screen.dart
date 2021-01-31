import 'package:flutter/material.dart';
import '../providers/product.dart';

class TopWidgetDetailScreen extends StatelessWidget {
  const TopWidgetDetailScreen({
    Key key,
    @required Product loadedProduct,
  })  : _loadedProduct = loadedProduct,
        super(key: key);

  final Product _loadedProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _loadedProduct.categories != null ? _loadedProduct.categories : '',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).accentColor,
                ),
          ),
          Text(
            _loadedProduct.title,
            style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Price -\n',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    TextSpan(
                      text: '${_loadedProduct.price} MMK',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Hero(
                    tag: _loadedProduct.imageUrl,
                    child: Image.network(
                      _loadedProduct.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
