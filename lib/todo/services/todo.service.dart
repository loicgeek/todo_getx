import 'dart:async';

import 'package:todo_app_getx/todo/models/todo.model.dart';

class TodoService {
  List<Todo> todos = [Todo(id: "1", title: "Go to school")];
  Future<List<Todo>> findAll() {
    //Simulation Api call
    Completer completer = Completer<List<Todo>>();
    Timer(Duration(seconds: 2), () {
      completer.complete(todos);
    });
    return completer.future;
  }

  Future<Todo> findOne(String id) {
    Todo todo = todos.firstWhere((element) => element.id == id);
    Completer completer = Completer<Todo>();
    Timer(Duration(seconds: 2), () {
      completer.complete(todo);
    });
    return completer.future;
  }

  Future<Todo> addOne(String title, {bool done = false}) {
    Completer completer = Completer<Todo>();
    Timer(Duration(seconds: 2), () {
      var todo = Todo(id: "${todos.length + 1}", title: title, done: done);
      completer.complete(todo);
    });
    return completer.future;
  }

  Future<Todo> updateOne(Todo todo) async {
    int index = todos.indexWhere((element) => element.id == todo.id);
    todos[index] = todo;
    return todo;
  }

  deleteOne(String id) {
    todos.removeWhere((element) => element.id == id);
    return true;
  }
}
