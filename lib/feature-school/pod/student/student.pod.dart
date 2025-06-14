import 'dart:async';

import 'package:clean_arch2/config/db/school_riverpod/school_pod.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentPod extends AsyncNotifier<List<StudentModel>> {
  @override
  FutureOr<List<StudentModel>> build() {
    return [];
  }

  FutureOr<int?> insertNewStudentRecord(StudentModel student) async {
    int? resp = await ref.read(schoolPodProvider.notifier).insertNewStudentRecordV2(student);

    return resp;
  }
}
