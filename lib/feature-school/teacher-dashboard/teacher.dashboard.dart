import 'dart:developer';

import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature-school/pod-entry/pod_entry.pod.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SchoolTeacherDashboardPage extends ConsumerStatefulWidget {
  const SchoolTeacherDashboardPage({super.key});
  @override
  ConsumerState<SchoolTeacherDashboardPage> createState () => _SchoolTeacherDashboardPage();
}

class _SchoolTeacherDashboardPage extends ConsumerState<SchoolTeacherDashboardPage> {
  List<StudentModel>? studentList = [];
  RefreshController dashboardController = RefreshController();

  void getStudentList() async {
    var teacherInfo = ref.read(teacherPod).value;
    var studentListResp = await ref.read(teacherPod.notifier).getStudentList(teacherInfo![0].id!);
    studentList = studentListResp;
  }

  void onRefreshTeacherDashboardController () {
    dashboardController.refreshCompleted();
    getStudentList();
  }

  void onUpdateStudent (int studentId) async{
    var currentActiveTeacher = ref.read(teacherPod).value;
    ref.read(teacherPod.notifier).updateStudent(currentActiveTeacher![0].id!, studentId, context);
    // Remove mi in second push
  }

  void onDeleteStudent () {

  }

  @override
  Widget build(BuildContext context) {
    getStudentList();

    return Scaffold(
      appBar: AppBar(
        title: Text(schoolTeacherDashboardTitle),
        backgroundColor: goldColor,
      ),
      body: SafeArea(
        child: SmartRefresher(
          controller: dashboardController,
          onRefresh: onRefreshTeacherDashboardController,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lastname: ${studentList![index].lastname}"),
                        Text("Firstname: ${studentList![index].firstname}"),
                        Text("Age: ${studentList![index].age}"),
                        const SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150.0,
                              child: inkButton(
                                tapped: (param) {
                                onUpdateStudent(
                                  studentList![index].id!,
                                );
                                }, subTitle: "Update",
                                bgColor: Colors.amber[900]!,
                                splashColor: goldColor!
                              ),
                            ),
                            const SizedBox(width: 8.0,),
                            SizedBox(
                              width: 150.0,
                              child: inkButton(
                                tapped: (param) {
                                onDeleteStudent();
                                }, subTitle: "Delete",
                                bgColor: Colors.red[700]!,
                                splashColor: redColor!,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8.0,);
              },
              itemCount: studentList!.length
            ),
          ),
        )
      ),
    );
  }
}
