import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/product/product.service.dart';

import 'models/category.model.dart';
import 'models/product.model.dart';

class ProductController extends GetxController {
  TextEditingController productName;
  TextEditingController productPrice;
  TextEditingController productDesc;
  TextEditingController productQty;
  Category productCategory;

  RxList<Product> productList = <Product>[].obs;
  ProductService productService;
  ProductController() {
    productService = ProductService();
  }

  @override
  onInit() {
    productName = TextEditingController();
    productPrice = TextEditingController();
    productDesc = TextEditingController();
    productQty = TextEditingController();
    productList.bindStream(productService.findAll());
  }

  @override
  onClose() {
    productName?.dispose();
    productPrice?.dispose();
    productDesc?.dispose();
    productQty?.dispose();
  }
}
