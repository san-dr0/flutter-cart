import 'dart:developer';

import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature-school/pod-entry/pod_entry.pod.dart';
import 'package:clean_arch2/feature-school/pod/teacher/model/teacher.model.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SchoolRegistration extends ConsumerStatefulWidget {
  const SchoolRegistration({super.key});
  @override
  ConsumerState<SchoolRegistration> createState () => _SchoolRegistration();
}

class _SchoolRegistration extends ConsumerState<SchoolRegistration> {
  TextEditingController txtFirstname = TextEditingController();
  TextEditingController txtLastname = TextEditingController();
  TextEditingController txtAge = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<TeacherModel> teacherList = [];
  TeacherModel? choosenActionTeacher;

  @override
  void initState() {
    super.initState();
    getTeacherList();
  }

  void onSubmitStudentRegistration() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String firstname = txtFirstname.text;
    String lastname = txtLastname.text;
    String age = txtAge.text;

    if (choosenActionTeacher == null ) {
      Fluttertoast.showToast(msg: pleaseSelectATeacherTitle, toastLength: Toast.LENGTH_SHORT);
      return;
    }
    
    StudentModel studentModel = StudentModel(firstName: firstname, lastName: lastname, age: int.parse(age), teacherId: choosenActionTeacher!.id);
    int? resp = await ref.read(studentPod.notifier).insertNewStudentRecord(studentModel);

    if (resp! == 0) {
      Fluttertoast.showToast(msg: studentRegistrationErrorTitle, toastLength: Toast.LENGTH_SHORT);
      return;
    }
    Fluttertoast.showToast(msg: studentRegistrationTitle, toastLength: Toast.LENGTH_LONG);
    resetFields();
  }

  void getTeacherList () async {
    List<TeacherModel> teacher =  await ref.read(teacherPod.notifier).getTeacherList();
    setState(() {
      teacherList = teacher;
    });
  }

  void resetFields() {
    txtFirstname.text = "";
    txtLastname.text = "";
    txtAge.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(schoolRegistrationTitle),
        backgroundColor: goldColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              registrationTitle,
                              style: textStyle(color: Colors.black, fontSize: 20.0),
                            ),
                            TextFormField(
                              controller: txtFirstname,
                              decoration: _inputDecoration(
                                label: "Firstname"
                              ),
                              validator: (value) {
                                if ( value == null || value.isEmpty) {
                                  return "Empty firstname";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: txtLastname,
                              decoration: _inputDecoration(
                                label: "Lastname"
                              ),
                              validator: (value) {
                                if ( value == null || value.isEmpty) {
                                  return "Empty lastname";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: txtAge,
                              decoration: _inputDecoration(
                                label: "Age"
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if ( value == null || value.isEmpty) {
                                  return "Empty Age";
                                }
                                return null;
                              },
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<TeacherModel>(
                                isExpanded: true,
                                hint: Text("Teacher list"),
                                items: teacherList.map((TeacherModel teacher){
                                  return  DropdownMenuItem<TeacherModel>(value: teacher,child: Text("${teacher.lname}, ${teacher.fname}"),);
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    choosenActionTeacher = value;
                                  });
                                },
                                value: choosenActionTeacher,
                              ),
                              
                            ),
                            const SizedBox(height: 10.0,),
                            inkButton(
                              tapped: (param) {
                                onSubmitStudentRegistration();
                              },
                              subTitle: "Submit",
                              bgColor: goldColor!,
                              splashColor: Colors.amber
                            )
                          ],
                        ),
                      )
                    ),
                  ],
                )
              )
            )
          ],
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration ({String label = ""}) {
  return InputDecoration(
    label: Text(label)
  );
}
