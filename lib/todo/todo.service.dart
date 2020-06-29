import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_getx/todo/models/todo.model.dart';

class TodoService {
  CollectionReference todosRef = Firestore.instance.collection("todos");
  Stream<Iterable<Todo>> findAll(userId) {
    return todosRef
        .where("user_id", isEqualTo: userId)
        .getDocuments()
        .then((value) {
      return value.documents.map((e) => Todo.fromSnapshot(e)).toList();
    }).asStream();
  }

  Future<Todo> findOne(String id) async {
    var result = await todosRef.document(id).get();
    return Todo.fromSnapshot(result);
  }

  Future<Todo> addOne(String userId, String title, {bool done = false}) async {
    var result =
        await todosRef.add({"user_id": userId, "title": title, "done": done});
    return Todo(id: result.documentID, title: title, done: done);
  }

  Future<void> updateOne(Todo todo) async {
    todosRef.document(todo.id).updateData(todo.toJson());
  }

  deleteOne(String id) {
    todosRef.document(id).delete();
  }
}
