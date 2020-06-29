import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/todo/todo.controller.dart';
import 'package:todo_app_getx/todo/models/todo.model.dart';

class EditTodo extends StatelessWidget {
  EditTodo({Key key}) : super(key: key);
  TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Todo"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: GetX(
            initState: (state) =>
                TodoController.to.loadDetails(Get.parameters["id"]),
            builder: (disposable) {
              if (TodoController.to.isLoadingDetails.value) {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (titleController == null) {
                titleController = TextEditingController(
                    text: TodoController.to.activeTodo.title);
              }

              return Column(
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Add title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (titleController.text != "") {
                          Todo todo = TodoController.to.activeTodo;
                          todo.title = titleController.text;
                          TodoController.to.updateTodo(todo);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .6,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Obx(
                    () => TodoController.to.isAddingTodo.value
                        ? Container(
                            child: Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            )),
                          )
                        : Container(),
                  )
                ],
              );
            },
          )),
    );
  }
}
