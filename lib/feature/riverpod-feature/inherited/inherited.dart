import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Count extends InheritedWidget {
  const Count({super.key, required super.child});
  final c = 0;

  void increment() {}

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
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          OutlinedButton(onPressed: () {
            Count.of(context).increment();
          }, child: Text("Tap"))
        ],
      ),
    );
  }
}

class _TestInheritedWidgetPage extends State<TestMainInheritedWidget> {
  Widget build(BuildContext context) {
    return Count(child: TestInheritedWidgetPage());
  } 
}
