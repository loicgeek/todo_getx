import 'package:flutter/material.dart';
import 'package:todo_app_getx/product/models/product.model.dart';

class SingleProduct extends StatelessWidget {
  final Product product;
  const SingleProduct({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(product.name),
    );
  }
}
