import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../config/db/school_riverpod/school_pod.dart';
import '../../../core/string.dart';
import '../teacher/model/teacher.model.dart';

class SchoolAuthPod extends AsyncNotifier<SchoolAuthPod>{
   @override
  FutureOr<SchoolAuthPod> build() {
    return SchoolAuthPod();
  }

  FutureOr<void> loginTeacher(TeacherModel signIn, BuildContext context, bool isMounted) async{
    var teacherResp = await ref.read(schoolPodProvider.notifier).loginTeacherV2(signIn);
    
    if (teacherResp != null) {
      Fluttertoast.showToast(msg: invalidCredsTitle, toastLength: Toast.LENGTH_SHORT);
      return;
    }

    // state = AsyncValue.data(teacherResp);
    if (!isMounted) return;
    // context.go("/school-teacher-dashboard");
  }
  
}
