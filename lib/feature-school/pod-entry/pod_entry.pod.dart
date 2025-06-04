import 'package:clean_arch2/feature-school/pod/student/student.pod.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var studentPod = AsyncNotifierProvider<StudentPod, List<StudentModel>>(() {
  return StudentPod();
});
