import 'dart:async';

import 'package:clean_arch2/feature-school/pod/teacher/model/teacher.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherPod extends AsyncNotifier<List<TeacherModel>> {
  @override
  FutureOr<List<TeacherModel>> build() {
    return [];
  }
  
  FutureOr<List<Map<String, dynamic>>> getTeacherList() {
    List<Map<String, dynamic>> teacherList = [];
    
    return teacherList;
  }
}