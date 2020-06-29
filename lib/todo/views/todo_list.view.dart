import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app_getx/todo/controllers/todo.controller.dart';
import 'package:todo_app_getx/todo/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TodoController c = Get.put<TodoController>(TodoController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        centerTitle: true,
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
