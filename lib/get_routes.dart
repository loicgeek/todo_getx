import 'package:get/get.dart';
import 'package:todo_app_getx/auth/views/login.dart';
import 'package:todo_app_getx/auth/views/register.dart';
import 'package:todo_app_getx/snap_sell.dart';
import 'package:todo_app_getx/splashscreen.dart';
import 'package:todo_app_getx/todo/views/views.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splashscreen',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/',
      page: () => SnapSell(), //TodoList(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
    ),
    GetPage(
      name: '/todos/:id/edit',
      page: () => EditTodo(),
    ),
    GetPage(
      name: '/add-todo',
      page: () => AddTodo(),
    ),
  ];
}
