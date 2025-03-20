import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod/feature/todo-home/model/todoModel.dart';
import 'package:clean_arch2/feature/riverpod/feature/todo-home/todo-home-riverpod/todo_home_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TodoHomePage extends ConsumerStatefulWidget {
  const TodoHomePage({super.key});

  @override
  ConsumerState<TodoHomePage> createState () => _TodoHomePage();
}

class _TodoHomePage extends ConsumerState<TodoHomePage> {
  late TextEditingController todoTitleController;
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    todoTitleController = TextEditingController();
  }
  
  void onAddTodo () {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Empty fields");
      return;
    }
    String title = todoTitleController.text;
    ref.read(todoPodProvider.notifier).increment(title);
    todoTitleController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    List<TodoModel> todoList = ref.watch(todoPodProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(todoTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: todoTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide a todo title";
                        }
                        return null;
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onAddTodo();
                    },
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.all(Radius.circular(6.0))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Add"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 6.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Left"),
                InkWell(
                  onTap: () {
                    
                  },
                  child: Ink(
                    child: Text("All"),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Ink(
                    child: Text("Active"),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Ink(
                    child: Text("Complete"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox(value: !todoList[index].isActive, onChanged: (value) {
                      setState(() {
                        todoList[index].isActive = !value!;
                      });
                    }),
                    Text(todoList[index].title)
                  ],
                );
              }, separatorBuilder: (context, index) {
                return SizedBox(height: 8.0,);
              }, itemCount: todoList.length),
            )
          ],
        ),
      ),
    );
  }
}
