import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature-school/pod-entry/pod_entry.pod.dart';
import 'package:clean_arch2/feature-school/pod/teacher/model/teacher.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolLoginPage extends ConsumerStatefulWidget {
  const SchoolLoginPage({super.key});

  @override
  ConsumerState<SchoolLoginPage> createState () => _SchoolLoginPage();
}

class _SchoolLoginPage extends ConsumerState<SchoolLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teacherID = TextEditingController();
  final TextEditingController _teacherFname = TextEditingController();
  final TextEditingController _teacherLname = TextEditingController();

  void onLoginTeacher () {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String teacherID = _teacherID.text;
    String teacherFname = _teacherFname.text;
    String teacherLname = _teacherLname.text;
    TeacherModel teacherModel = TeacherModel(id: int.parse(teacherID), fname: teacherFname, lname: teacherLname);
    ref.read(teacherPod.notifier).loginTeacher(teacherModel, context, mounted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(schoolLoginPageTitle),
        backgroundColor: goldColor,
      ),
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Card(
              child: Padding(padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: _inputDecoration(
                        label: "Teacher Id"
                      ),
                      keyboardType: TextInputType.number,
                      controller: _teacherID,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty ID";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: _inputDecoration(
                        label: "Firstname"
                      ),
                      controller: _teacherFname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty Firstname";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: _inputDecoration(
                        label: "Lastname"
                      ),
                      controller: _teacherLname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty Lastname";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0,),
                    SizedBox(
                      width: 100.0,
                      child: inkButton(
                        tapped: (param) => onLoginTeacher(),
                        subTitle: "Login",
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
