import 'package:clean_arch2/feature/riverpod/feature/todo-home/model/todoModel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'todo_home_riverpod.g.dart';

@riverpod
class TodoPod extends _$TodoPod {  
  
  @override
  List<TodoModel> build() => [];

  void increment (String title) => state = [...state, TodoModel(todoId: '1233', title: title)];
}
