import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/todo/todo.controller.dart';
import 'package:todo_app_getx/todo/models/todo.model.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = new TextEditingController();
  Todo todo;

  @override
  void initState() {
    print(Get.parameters);
    if (Get.parameters != null) {
      var id = Get.parameters["id"];
      if (id != null) {
        TodoController.to.loadDetails(id).then((value) => setState(() {
              todo = value;
              titleController.text = value.title;
            }));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
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
                    if (todo != null) {
                      todo.title = titleController.text;
                      TodoController.to.updateTodo(todo);
                      titleController.clear();
                    } else {
                      TodoController.to.addTodo(titleController.text);
                      titleController.clear();
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Save",
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
        ),
      ),
    );
  }
}
