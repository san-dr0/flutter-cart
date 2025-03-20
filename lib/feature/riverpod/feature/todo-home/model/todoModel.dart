// ignore_for_file: file_names

enum TodoEnum {
  all,
  active,
  completed
}
class TodoModel {
  String todoId;
  String title;
  bool isActive = true;

  TodoModel({required this.todoId, required this.title});
}
