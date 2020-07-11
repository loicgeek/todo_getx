import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/product/product.service.dart';
import 'package:todo_app_getx/auth/auth.controller.dart';
import 'models/category.model.dart';
import 'models/product.model.dart';

class ProductController extends GetxController {
  static ProductController to = Get.find();
  TextEditingController productName;
  TextEditingController productPrice;
  TextEditingController productDesc;
  TextEditingController productQty;
  Category productCategory;

  //
  bool isLoadingDetails = false;
  bool errorLoadingDetails = false;
  bool successLoadingDetails = false;
  Product activeProduct;

  //

  RxList<Product> productList = <Product>[].obs;
  RxList<Product> userProductsList = <Product>[].obs;
  ProductService productService;
  ProductController() {
    productService = ProductService();
  }

  @override
  onReady() {
    productName = TextEditingController();
    productPrice = TextEditingController();
    productDesc = TextEditingController();
    productQty = TextEditingController();
    productList.bindStream(loadProducts());
  }

  Stream<List<Product>> loadProducts() {
    return productService.findAll();
  }

  loadDetails(String productId) async {
    try {
      isLoadingDetails = true;
      errorLoadingDetails = false;
      activeProduct = await productService.findOne(productId);
      print(activeProduct);
      isLoadingDetails = false;
      successLoadingDetails = true;
    } catch (e) {
      isLoadingDetails = false;
      successLoadingDetails = false;
      errorLoadingDetails = true;
    }
  }

  @override
  onClose() {
    productName?.dispose();
    productPrice?.dispose();
    productDesc?.dispose();
    productQty?.dispose();
  }
}
