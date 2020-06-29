import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String title;
  bool done;
  String userId;
  Todo({this.id, this.userId, this.title, this.done = false});
  copyWith({title, done}) {
    return Todo(
      id: id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      done: done ?? this.done,
    );
  }

  factory Todo.fromSnapshot(DocumentSnapshot snap) {
    return Todo(
        id: snap.documentID,
        done: snap.data["done"],
        title: snap.data['title']);
  }

  toJson() {
    return {"title": title, "done": done};
  }
}
