import 'package:get/get.dart';
import 'package:todo_app_getx/todo/views/views.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => TodoList(),
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
