import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/product/product.controller.dart';
import 'package:todo_app_getx/product/widgets/single_product.dart';

class ProductListPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final ProductController productController = ProductController.to;
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: productController.productList.length,
            itemBuilder: (BuildContext context, int index) => SingleProduct(
              product: productController.productList[index],
            ),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index == 2 ? 2 : 3),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        );
      }),
    );
  }
}
