import 'dart:async';

import 'package:clean_arch2/config/db/school_riverpod/school_pod.dart';
import 'package:clean_arch2/feature-school/pod/teacher/model/teacher.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherPod extends AsyncNotifier<List<TeacherModel>> {
  @override
  FutureOr<List<TeacherModel>> build() {
    return [];
  }
  
  FutureOr<List<TeacherModel>> getTeacherList() async {
    List<TeacherModel> teacherList = [];
    teacherList = await ref.read(schoolPodProvider.notifier).getTeacherList();

    return teacherList;
  }
}