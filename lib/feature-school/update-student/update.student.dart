import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';

class SchoolUpdateStudent extends StatefulWidget {
  const SchoolUpdateStudent({super.key});

  @override
  State<SchoolUpdateStudent> createState () => _SchoolUpdateStudent();
}

class _SchoolUpdateStudent extends State<SchoolUpdateStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(updateStudentTitle),
        backgroundColor: goldColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
