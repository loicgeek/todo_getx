class Todo {
  String id;
  String title;
  bool done;
  Todo({this.id, this.title, this.done = false});
  copyWith({title, done}) {
    return Todo(id: id, title: title ?? this.title, done: done ?? this.done);
  }
}
