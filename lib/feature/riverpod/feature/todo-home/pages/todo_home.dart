import 'dart:developer';

import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod/feature/todo-home/model/todoModel.dart';
import 'package:clean_arch2/feature/riverpod/feature/todo-home/todo-home-riverpod/todo_home_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class TodoHome extends StatefulWidget {
//   const TodoHome({super.key});

//   @override
//   State<TodoHome> createState () => _TodoHome();
// }

class TodoHomePage extends ConsumerWidget {
  TodoHomePage({super.key});

  TextEditingController todoTitleController = TextEditingController();
  
  void onAddTodo (WidgetRef ref) {
    String title = todoTitleController.text;
    ref.watch(counterProvider.notifier).increment('Ojjj');
  }
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TodoModel> counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(todoTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("L: ${counter.length} $todoTitle"),
            TextFormField(
              controller: todoTitleController,
            ),
            const SizedBox(height: 10.0,),
            InkWell(
              onTap: () {
                onAddTodo(ref);
              },
              splashColor: Colors.teal[800],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.teal
                ),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Add to list"),
                ),
              ),
            ),
            const SizedBox(height: 8.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("0 Items left"),
                InkWell(
                  onTap: () {},
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
                    child: Text("Completed"),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
