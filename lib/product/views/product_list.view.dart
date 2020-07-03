import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/product/product.controller.dart';
import 'package:todo_app_getx/product/widgets/single_product.dart';

class ProductListPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Snap Sell"),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState.openDrawer();
            },
            child: Icon(Icons.menu)),
      ),
      body: Obx(() {
        return ListView.builder(
            itemCount: productController.productList.length,
            itemBuilder: (context, index) {
              return SingleProduct(
                product: productController.productList[index],
              );
            });
      }),
    );
  }
}
