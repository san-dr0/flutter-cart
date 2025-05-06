import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Count extends InheritedWidget {
  const Count({super.key, required this.c, required this.increment, required super.child});
  final int c;

  final void Function() increment;

  static Count of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Count>()!;
  }

  @override
  bool updateShouldNotify(Count oldWidget) {
    return c != oldWidget.c;
  }
}

class TestMainInheritedWidget extends StatefulWidget {
  @override
  State<TestMainInheritedWidget> createState () => _TestInheritedWidgetPage();
}

class TestInheritedWidgetPage extends StatelessWidget {
  const TestInheritedWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Count.of(context).c;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(c.toString()),
          OutlinedButton(onPressed: () {
            Count.of(context).increment();
          }, child: Text("Tap"))
        ],
      ),
    );
  }
}

class _TestInheritedWidgetPage extends State<TestMainInheritedWidget> {
  int c = 0;
  void increment () {
    setState(() {
      c++;
    });
  }
  Widget build(BuildContext context) {
    return Count(c: c, child: TestInheritedWidgetPage(), increment: increment,);
  } 
}
