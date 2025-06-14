import 'dart:async';
import 'dart:developer';

import 'package:clean_arch2/feature-school/pod/auth/model/school.auth.model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../config/db/school_riverpod/school_pod.dart';
import '../../../core/string.dart';
import '../teacher/model/teacher.model.dart';

class SchoolAuthPod extends AsyncNotifier<SchoolAuthModel?>{
   @override
  FutureOr<SchoolAuthModel?> build() {
    return null;
  }

  FutureOr<void> loginTeacher(TeacherModel signIn, BuildContext context, bool isMounted) async{
    var teacherResp = await ref.read(schoolPodProvider.notifier).loginTeacherV2(signIn);
    
    if (teacherResp == null) {
      Fluttertoast.showToast(msg: invalidCredsTitle, toastLength: Toast.LENGTH_SHORT);
      return;
    }
    else if (teacherResp.isEmpty) {
      Fluttertoast.showToast(msg: invalidCredsTitle, toastLength: Toast.LENGTH_SHORT);
      return;
    }
    SchoolAuthModel schoolAuthModel = SchoolAuthModel(
      firstName: teacherResp[0].fname,
      lastName: teacherResp[0].lname,
      courseId: teacherResp[0].courseId,
      id: teacherResp[0].id,
    );
    state = AsyncValue.data(schoolAuthModel);
    if (!isMounted) return;
    context.go("/school-teacher-dashboard");
  }
  
}
