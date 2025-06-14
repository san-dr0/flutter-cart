import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature-school/component/icon.button.dart';
import 'package:clean_arch2/feature-school/pod-entry/pod_entry.pod.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolAttendancePage extends ConsumerStatefulWidget {
  const SchoolAttendancePage({super.key});

  @override
  ConsumerState<SchoolAttendancePage> createState () => _SchoolAttendancePage();
}

class _SchoolAttendancePage extends ConsumerState<SchoolAttendancePage> {
  List<StudentModel> studentRecord = [];

  @override
  void initState() {
    super.initState();
    getStudentsForAttendance();
  }

  void getStudentsForAttendance () async {
    if (ref.read(schoolAuthPod).value == null) {
      return;
    }

    int teacherId = ref.read(schoolAuthPod).value!.id!;
    var studentList = await ref.read(teacherPod.notifier).getAllStudentForAttendance(teacherId);
    setState(() {
      studentRecord = studentList;
    });
  }

  void onButtonAction () {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(schoolAttendanceTitle),
        backgroundColor: goldColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(itemBuilder: (context, index) {
            return Card(
              child: Padding(padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lastname: ${studentRecord[index].lastName}"),
                        Text("Firstname: ${studentRecord[index].firstName}")
                      ],
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        iconButton(buttonAction: onButtonAction, icon: Icons.check, color: Colors.green[400]!),
                        iconButton(buttonAction: onButtonAction, icon: Icons.close, color: Colors.red[600]!),
                      ],
                    )
                  ],
                ),
              ),
            );
          }, separatorBuilder: (context, index) {
            return const SizedBox(height: 8.0,);
          }, itemCount: studentRecord.length,),
        ),
      ),
    );
  }
}
