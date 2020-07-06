import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/product/models/product.model.dart';
import 'package:todo_app_getx/widgets/app_cached_image.dart';

class SingleProduct extends StatelessWidget {
  final Product product;
  const SingleProduct({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("products/${product.id}/view");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: AppCachedImage(
                  url: product.gallery.first.url,
                  imageBuilder: (context, provider) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
                          )),
                    );
                  }),
            ),
            Text(product.name),
            Text(product.desc),
            Text("\$ ${product.price}"),
          ],
        ),
      ),
    );
  }
}
