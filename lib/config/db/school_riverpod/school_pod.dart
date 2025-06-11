import 'dart:developer';

import 'package:clean_arch2/config/api-dio/dio-api.dart';
import 'package:clean_arch2/feature-school/pod/teacher/model/teacher.model.dart';
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
          "fname": student.firstName,
          "lname": student.lastName,
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

  FutureOr<List<TeacherModel>> getTeacherList() async {
    List<TeacherModel> teacherList = [];
    SupabaseClient instance = Supabase.instance.client;
    var teacherResp = await instance.from("teachers").select("fname, lname, id, age");
    
    for(var tp in teacherResp) {
      teacherList.add(TeacherModel.fromJson(tp));
    }

    return teacherList;
  }

  FutureOr<List<TeacherModel>?> loginTeacher(TeacherModel signIn) async{
    try{
      SupabaseClient instance = Supabase.instance.client;
      List<TeacherModel> teacher = [];
      var teacherResp = await instance.from("teachers")
        .select("id, course_id, fname, lname, age")
        .eq("id", signIn.id!)
        .eq("fname", signIn.fname)
        .eq("lname", signIn.lname);

      for(var tp in teacherResp) {
        teacher.add(TeacherModel.fromJson(tp));
      }
    
      return teacher;
    }
    catch(error) {
      log("Errorororor >>>> loginTeacher");
      log(error.toString());

      return [];
    } 
  }

  FutureOr<List<StudentModel>?> getStudentList(int teacherId) async{
    try{
      List<StudentModel> studentList = [];
      SupabaseClient instance = Supabase.instance.client;
      var studentResp = await instance.from("students")
        .select("id, teacher_id, fname, lname, age")
        .eq("teacher_id", teacherId);

      for(var sp in studentResp) {
        studentList.add(StudentModel.fromJson(sp));
      }
      
      return studentList;
    }
    catch(error) {
      log("Errorororo getStudentList");
      log(error.toString());
      return null;
    }
  }

  FutureOr<int> updateStudent(int teacherId, int studentId) async {
    try{
      SupabaseClient instance = Supabase.instance.client;
      var teacherResp = await instance.from("students")
        .select("id")
        .eq("teacher_id", teacherId)
        .eq("id", studentId);
        
      if (teacherResp.isEmpty) {
        return 0;
      }

      return 1;
    }
    catch(error) {
      log("Erororor >>> updateStudent");
      log(error.toString());
      return -1;
    }
  }
  
  FutureOr<int?> updateStudentRecord (int teacherId, StudentModel student) async{
    try{
      SupabaseClient instance = Supabase.instance.client;
      await instance.from("students")
        .update({
          "fname": student.firstName,
          "lname": student.lastName,
          "age": student.age,
        }).eq("id", student.id!);
        
      return 1;
    }
    catch(error) {
      log('Errororor >>>> updateStudentRecord');
      log(error.toString());

      return -1;
    }
  }

  // nestJS
  FutureOr<List<TeacherModel>> getTeacherListV2() async{
    try{
      ApplicationApiService applicationApiService = ApplicationApiService();

      var teacherRecord = await applicationApiService.getRequest(baseUrl: 'teacher/get-all-teachers');
      List<TeacherModel> teacherList = [];
      for(var tr in teacherRecord) {
        teacherList.add(TeacherModel.fromJson(tr));
      }
      
      return teacherList;
    }
    catch(error) {
      log('Error >>> getTeacherListV2');
      log(error.toString());
      return [];
    }
  }

  FutureOr<int?> insertNewStudentRecordV2(StudentModel student) async{
    try{
      ApplicationApiService applicationApiService = ApplicationApiService();
      var response = await applicationApiService.postRequest(baseUrl: "auth/");
      log("Response >>> ");
      log(response.toString());

      return 1;
    }
    catch(error) {
      log("Error >>> insertNewStudentRecordV2");
      log(error.toString());

      return -1;
    }
  }
}
