import 'package:clean_arch2/feature-school/pod/auth/model/school.auth.model.dart';
import 'package:clean_arch2/feature-school/pod/auth/school.auth.pod.dart';
import 'package:clean_arch2/feature-school/pod/student/student.pod.dart';
import 'package:clean_arch2/feature-school/pod/teacher/model/teacher.model.dart';
import 'package:clean_arch2/feature-school/pod/teacher/teacher.pod.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var studentPod = AsyncNotifierProvider<StudentPod, List<StudentModel>>(() {
  return StudentPod();
});

var teacherPod = AsyncNotifierProvider<TeacherPod, List<TeacherModel>>(() {
  return TeacherPod();
});

var schoolAuthPod = AsyncNotifierProvider<SchoolAuthPod, SchoolAuthModel>(() {
  return SchoolAuthPod();
});
