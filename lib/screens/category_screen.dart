import 'package:flutter/material.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/models/function.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarContent('Categories', context, kIconThemeColor),
    );
  }
}
