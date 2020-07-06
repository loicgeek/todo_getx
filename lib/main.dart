import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/auth/auth.controller.dart';
import 'package:todo_app_getx/get_routes.dart';
import 'package:todo_app_getx/product/product.controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController =
      Get.put<AuthController>(AuthController());
  final ProductController productController =
      Get.put<ProductController>(ProductController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App with Get Package',
      defaultTransition: Transition.rightToLeft,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
      ),
      initialRoute: "/splashscreen",
      getPages: AppRoutes.routes,
    );
  }
}
