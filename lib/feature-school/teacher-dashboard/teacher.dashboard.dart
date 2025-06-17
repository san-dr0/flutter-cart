import 'dart:developer';

import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature-school/pod-entry/pod_entry.pod.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:clean_arch2/feature-school/teacher-dashboard/presentation/teacher.nav.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SchoolTeacherDashboardPage extends ConsumerStatefulWidget {
  const SchoolTeacherDashboardPage({super.key});
  @override
  ConsumerState<SchoolTeacherDashboardPage> createState () => _SchoolTeacherDashboardPage();
}

class _SchoolTeacherDashboardPage extends ConsumerState<SchoolTeacherDashboardPage> {
  List<StudentModel> studentList = [];
  RefreshController dashboardController = RefreshController();

  @override
  void initState() {
    super.initState();
    getStudentList();
  }

  void getStudentList() async {
    var teacherInfo = ref.read(schoolAuthPod).value;
    if (teacherInfo == null) {
      return;
    }
    var studentListResp = await ref.read(teacherPod.notifier).getStudentListV2(teacherInfo.id!);

    setState(() {
      studentList = studentListResp;
    });
  }

  void onRefreshTeacherDashboardController () {
    getStudentList();
    dashboardController.refreshCompleted();
  }

  void onUpdateStudent (StudentModel student) async{
    var currentActiveTeacher = ref.read(schoolAuthPod).value;
    ref.read(teacherPod.notifier).updateStudent(currentActiveTeacher!.id!, student, context);
  }

  void onDeleteStudent () {

  }

  void studentAttendance() {
    context.push('/school-teacher-attendance');
  }

  void studentScoring() {

  }

  void studentReports () {

  }

  void onGoToHome() {
    context.go('/school-home');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(schoolTeacherDashboardTitle),
        backgroundColor: goldColor,
        actions: [
          ...teacherNav(studentAttendance, studentScoring, studentReports, onGoToHome)
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [],
              ),
            )
          ],
        ),
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
                        Text("Lastname: ${studentList[index].lastName}"),
                        Text("Firstname: ${studentList[index].firstName}"),
                        Text("Age: ${studentList[index].age}"),
                        const SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150.0,
                              child: inkButton(
                                tapped: (param) {
                                onUpdateStudent(
                                  studentList[index],
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
              itemCount: studentList.length
            ),
          ),
        )
      ),
    );
  }
}
