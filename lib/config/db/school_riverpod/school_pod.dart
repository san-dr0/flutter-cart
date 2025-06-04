import 'dart:developer';

import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'school_pod.g.dart';

@riverpod
class SchoolPod extends _$SchoolPod{

  @override
  void build() {

  }

  FutureOr<int?> insertNewStudentRecord(StudentModel student) async {
    try{
      SupabaseClient supaInstance = Supabase.instance.client;
      
      await supaInstance.from("students")
        .insert([{
          "teacher_id": student.teacherId,
          "firstname": student.firstname,
          "lastname": student.lastname,
          "age": student.age,
        }]);

      return 1;
    }
    catch(error) {
      log("Errrrrrroor ---- insertNewStudentRecord");
      log(error.toString());

      return 0;
    }
  }

}
