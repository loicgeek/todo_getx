import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/product/product.controller.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key key}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductController productController = ProductController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: GetX(
        initState: (state) {
          productController.loadDetails(Get.parameters["product_id"]);
        },
        builder: (disposible) {
          if (productController.isLoadingDetails) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (productController.errorLoadingDetails) {
            return Container(
              child: Center(
                child: FlatButton(
                  child: Text("Relosd"),
                  onPressed: () {
                    productController.loadDetails(Get.parameters["product_id"]);
                  },
                ),
              ),
            );
          }

          return Column(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(height: 200.0),
                items: productController.activeProduct.gallery.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            image: DecorationImage(
                              image: NetworkImage(
                                image.url,
                              ),
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                  );
                }).toList(),
              ),
              Text("${productController.activeProduct.name}"),
            ],
          );
        },
      ),
    );
  }
}
