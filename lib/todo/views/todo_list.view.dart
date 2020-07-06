import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/auth/auth.controller.dart';

import 'package:todo_app_getx/todo/todo.controller.dart';
import 'package:todo_app_getx/todo/widgets/todo_item.dart';
import 'package:todo_app_getx/widgets/app_drawer.dart';

class TodoList extends StatelessWidget {
  TodoList({Key key}) : super(key: key);
  AuthController authController = AuthController.to;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    TodoController c = Get.put<TodoController>(TodoController());
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Obx(() => authController.user != null
            ? Text(" ${authController?.user?.value?.email}")
            : Container()),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(Icons.menu)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                authController.handleSignOut();
              })
        ],
      ),
      body: Obx(() {
        if (c.isLoadingTodos.value) {
          return Container(child: Center(child: CircularProgressIndicator()));
        }

        if (c.todos.length == 0) {
          return Center(child: Text('Nothing to do'));
        }
        return ListView.builder(
            itemCount: c.todos.length,
            itemBuilder: (context, index) {
              return TodoItem(c.todos.elementAt(index));
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/add-todo"),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
