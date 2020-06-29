import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/auth/auth.controller.dart';

class SplashScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
