import 'dart:async';

import 'package:clean_arch2/config/db/school_riverpod/school_pod.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature-school/pod-entry/pod_entry.pod.dart';
import 'package:clean_arch2/feature-school/pod/teacher/model/teacher.model.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class TeacherPod extends AsyncNotifier<List<TeacherModel>> {
  @override
  FutureOr<List<TeacherModel>> build() {
    return getCurrentActiveTeacher();
  }
  
  FutureOr<List<TeacherModel>> getCurrentActiveTeacher() {
    return Future.value(state.value);
  }
  
  FutureOr<List<TeacherModel>> getTeacherList() async {
    List<TeacherModel> teacherList = [];
    teacherList = await ref.read(schoolPodProvider.notifier).getTeacherList();

    return teacherList;
  }

  FutureOr<void> loginTeacher(TeacherModel signIn, BuildContext context, bool isMounted) async{
    var teacherResp = await ref.read(schoolPodProvider.notifier).loginTeacher(signIn);
    
    if (teacherResp!.isEmpty) {
      Fluttertoast.showToast(msg: invalidCredsTitle, toastLength: Toast.LENGTH_SHORT);
      return;
    }

    state = AsyncValue.data(teacherResp);
    if (!isMounted) return;
    context.go("/school-teacher-dashboard");
  }

  FutureOr<List<StudentModel>?> getStudentList (int teacherId) async{
    List<StudentModel>? studentList = [];
    studentList = await ref.read(schoolPodProvider.notifier).getStudentList(teacherId);

    return studentList;
  }

  FutureOr<int> updateStudent(int teacherId, int studentId, BuildContext context) async {
    var teacherResp = await ref.read(schoolPodProvider.notifier).updateStudent(teacherId, studentId);
    switch(teacherResp) {
      case -1:
        Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_SHORT);
      break;
      case 0:
        Fluttertoast.showToast(msg: teacherCantDoActions, toastLength: Toast.LENGTH_SHORT);
      break;
      case 1:
        context.push("/school-teacher-update-student");
      break;
    } 
    return teacherResp;
  }
}
