import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature-school/pod-entry/pod_entry.pod.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class SchoolUpdateStudent extends ConsumerStatefulWidget {
  SchoolUpdateStudent({super.key, this.studentModel});
  StudentModel? studentModel;

  @override
  ConsumerState<SchoolUpdateStudent> createState () => _SchoolUpdateStudent();
}

class _SchoolUpdateStudent extends ConsumerState<SchoolUpdateStudent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _txtFname = TextEditingController();
  final TextEditingController _txtLname = TextEditingController();
  final TextEditingController _txtAge = TextEditingController();

  @override
  void initState() {
    super.initState();
    _txtFname.text = widget.studentModel!.firstName;
    _txtLname.text = widget.studentModel!.lastName;
    _txtAge.text = widget.studentModel!.age.toString();
  }

  void onUpdateStudentRecord(int studentId) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String fname = _txtFname.text;
    String lname = _txtLname.text;
    String age = _txtAge.text;

    var teacherId = ref.read(schoolAuthPod).value!.id!;
    StudentModel student = StudentModel(id: studentId, firstName: fname, lastName: lname, age: int.parse(age));
    int? studentUpdateResp = await ref.read(teacherPod.notifier).updateStudentRecord(teacherId!, student);

    if (studentUpdateResp! > 0) {
      Fluttertoast.showToast(msg: schoolUpdateStudentRecord, toastLength: Toast.LENGTH_SHORT);
      return;
    }
    Fluttertoast.showToast(msg: schoolUpdateStudentRecordFailed, toastLength: Toast.LENGTH_SHORT);
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
                          onUpdateStudentRecord(widget.studentModel!.id!);
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