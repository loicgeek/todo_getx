import 'package:get/get.dart';
import 'package:todo_app_getx/todo/models/todo.model.dart';
import 'package:todo_app_getx/todo/services/todo.service.dart';

class TodoController extends GetxController {
  static TodoController to = Get.find();
  RxList<Todo> todos = <Todo>[].obs;
  RxBool isLoadingTodos = false.obs;
  RxBool isAddingTodo = false.obs;
  RxBool isLoadingDetails = false.obs;
  Todo activeTodo;
  TodoService _todoService;
  TodoController() {
    _todoService = TodoService();
  }

  onInit() {
    this.loadTodos();
  }

  loadTodos() async {
    try {
      isLoadingTodos.value = true;
      var result = await _todoService.findAll();
      todos.addAll(result);
      isLoadingTodos.value = false;
    } catch (e) {
      isLoadingTodos.value = false;
      print(e);
    }
  }

  Future<Todo> loadDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      activeTodo = await _todoService.findOne(id);
      print(activeTodo);
      isLoadingDetails.value = false;
      return activeTodo;
    } catch (e) {}
  }

  addTodo(String title) async {
    try {
      isAddingTodo.value = true;
      var todo = await _todoService.addOne(title);
      todos.add(todo);
      Get.snackbar("Success", todo.title, snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  updateTodo(Todo todo) async {
    try {
      isAddingTodo.value = true;
      await _todoService.updateOne(todo);
      int index = todos.value.indexWhere((element) => element.id == todo.id);

      todos[index] = todo;
      print(todos);
      Get.snackbar("Success", " updated", snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  deleteTodo(String id) async {
    try {
      await _todoService.deleteOne(id);
      int index = todos.value.indexWhere((element) => element.id == id);
      todos.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }
}
