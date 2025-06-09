import 'dart:developer';

import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SchoolUpdateStudent extends StatefulWidget {
  SchoolUpdateStudent({super.key, this.studentModel});
  StudentModel? studentModel;

  @override
  State<SchoolUpdateStudent> createState () => _SchoolUpdateStudent();
}

class _SchoolUpdateStudent extends State<SchoolUpdateStudent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _txtFname = TextEditingController();
  final TextEditingController _txtLname = TextEditingController();
  final TextEditingController _txtAge = TextEditingController();

  @override
  void initState() {
    super.initState();
    _txtFname.text = widget.studentModel!.firstname;
    _txtLname.text = widget.studentModel!.lastname;
    _txtAge.text = widget.studentModel!.age.toString();
  }

  void onUpdateStudentRecord() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String fname = _txtFname.text;
    String lname = _txtLname.text;
    String age = _txtAge.text;
    
  }

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
          child: Card(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _txtFname,
                      decoration: _inputDecoration(label: "Firstname"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty Firstname";
                        }
              
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _txtLname,
                      decoration: _inputDecoration(label: "Lastname"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty Lastname";
                        }
              
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _txtAge,
                      decoration: _inputDecoration(label: "Age"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty Age";
                        }
              
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10.0,),
                    SizedBox(
                      width: 150.0,
                      child: inkButton(
                        tapped: (param) {
                          onUpdateStudentRecord();
                        },
                        subTitle: "Update",
                        splashColor: Colors.amber[900]!,
                        bgColor: goldColor!
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration({String label = ""}) {
  return InputDecoration(
    label: Text(label)
  );
}