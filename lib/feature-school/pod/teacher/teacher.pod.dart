import 'dart:async';
import 'dart:developer';

import 'package:clean_arch2/config/db/school_riverpod/school_pod.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature-school/pod/teacher/model/teacher.model.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
    teacherList = await ref.read(schoolPodProvider.notifier).getTeacherListV2();

    return teacherList;
  }

  FutureOr<List<StudentModel>?> getStudentList (int teacherId) async{
    List<StudentModel>? studentList = [];
    studentList = await ref.read(schoolPodProvider.notifier).getStudentList(teacherId);

    return studentList;
  }

  FutureOr<int> updateStudent(int teacherId, StudentModel student, BuildContext context) async {
    var teacherResp = await ref.read(schoolPodProvider.notifier).updateStudent(teacherId, student.id!);
    switch(teacherResp) {
      case -1:
        Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_SHORT);
      break;
      case 0:
        Fluttertoast.showToast(msg: teacherCantDoActions, toastLength: Toast.LENGTH_SHORT);
      break;
      case 1:
        context.push("/school-teacher-update-student", extra: student);
      break;
    } 
    return teacherResp;
  } // these only check if the teacher has the authority to update certain student

  Future<int?> updateStudentRecord(int teacherId, StudentModel student) async {
    var studentUpdateResp = await ref.read(schoolPodProvider.notifier).updateStudentRecord(teacherId, student);

    return studentUpdateResp;
  }
  FutureOr<List<StudentModel>> getStudentListV2(int teacherId) async {
    var studentRecord = await ref.read(schoolPodProvider.notifier).getStudentListV2(teacherId);

    return studentRecord;
  }

  FutureOr<List<StudentModel>> getAllStudentForAttendance(int teacherId) async {    
    var studentList = await ref.read(schoolPodProvider.notifier).getAllStudentForAttendance(teacherId);
    return studentList;
  }

  FutureOr<dynamic> updateStudentRecordV2WithoutImage(int teacherId, StudentModel student) async {
    dynamic record = await ref.read(schoolPodProvider.notifier).updateStudentRecordV2WithoutImage(teacherId, student);
    
    return record;
  }

  FutureOr<int?> updateStudentRecordV2WithImage(int teacherId, StudentModel student, List<XFile>? profileImage) async {
    return await ref.read(schoolPodProvider.notifier).updateStudentRecordV2WithImage(teacherId, student, profileImage);
  }
  
}
