import 'dart:developer';

import 'package:clean_arch2/config/api-dio/dio-api.dart';
import 'package:clean_arch2/config/api-dio/generic.dart';
import 'package:clean_arch2/feature-school/pod/teacher/model/teacher.model.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as Supabase;
part 'school_pod.g.dart';

@riverpod
class SchoolPod extends _$SchoolPod{

  @override
  void build() {

  }

  FutureOr<int?> insertNewStudentRecord(StudentModel student) async {
    try{
      Supabase.SupabaseClient supaInstance = Supabase.Supabase.instance.client;
      
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
    Supabase.SupabaseClient instance = Supabase.Supabase.instance.client;
    var teacherResp = await instance.from("teachers").select("fname, lname, id, age");
    
    for(var tp in teacherResp) {
      teacherList.add(TeacherModel.fromJson(tp));
    }

    return teacherList;
  }

  FutureOr<List<TeacherModel>?> loginTeacher(TeacherModel signIn) async{
    try{
      Supabase.SupabaseClient instance = Supabase.Supabase.instance.client;
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
      Supabase.SupabaseClient instance = Supabase.Supabase.instance.client;
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
      Supabase.SupabaseClient instance = Supabase.Supabase.instance.client;
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
      Supabase.SupabaseClient instance = Supabase.Supabase.instance.client;
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
      for(var tr in teacherRecord.data) {
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
      Map<String, dynamic> studentRecord = {
        "firstName": student.firstName,
        "lastName": student.lastName,
        "age": student.age,
        "teacherId": student.teacherId
      };
      var response = await applicationApiService.postRequest(baseUrl: "auth/register-student", data: studentRecord);

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

  FutureOr<List<TeacherModel>?> loginTeacherV2(TeacherModel teacher) async {
    try{
      ApplicationApiService applicationApiService = ApplicationApiService();
      List<TeacherModel> teacherInfo = [];
      
      Map<String, dynamic> teacherRecord = {
        "id": teacher.id,
        "firstName": teacher.fname,
        "lastName": teacher.lname,
      };

      var credsResp = await applicationApiService.postRequest(baseUrl: "auth/teacher-login", data: teacherRecord);
      teacherInfo.add(TeacherModel.fromJson(credsResp.data[0]));
      ref.read(appLoading.notifier).setLoadingStatus();

      return teacherInfo;
    }
    catch(error) {
      log('Error >>> loginTeacherV2');
      log(error.toString());
      ref.read(appLoading.notifier).setLoadingStatus();

      return null;
    }
  }

  FutureOr<List<StudentModel>> getAllStudentForAttendance(int teacherId) async {
    try{
      List<StudentModel> studentList = [];
      ApplicationApiService applicationApiService = ApplicationApiService();
      var studentRecord = await applicationApiService.getRequest(baseUrl: 'teacher/get-all-students-for-attendance/$teacherId');
      
      for(var sr in studentRecord.data) {
        studentList.add(StudentModel.fromJson(sr));
      }

      return studentList;
    }
    catch(error) {
      log('Error --- getAllStudentForAttendance');
      log(error.toString());

      return [];
    }
  }

  FutureOr<List<StudentModel>> getStudentListV2(int teacherId) async{
    try{
      ApplicationApiService applicationApiService = ApplicationApiService();
      var studentResp = await applicationApiService.getRequest(baseUrl: 'student/$teacherId');
      List<StudentModel> studentList = [];

      for(var sr in studentResp.data) {
        studentList.add(StudentModel.fromJson(sr));
      }

      return studentList;
    }
    catch(error) {
      log('Errror >>> ');
      log(error.toString());

      return [];
    }

  }

  FutureOr<dynamic> updateStudentRecordV2WithoutImage(int teacherId, StudentModel student) async {
    try{
      ApplicationApiService applicationApiService = ApplicationApiService();
      Map<String, dynamic> data = {
        "teacherId": teacherId,
        "studentId": student.id,
        "studentFirstname": student.firstName,
        "studentLastname": student.lastName,
        "age": student.age,
      };

      GenericModel genericModel = await applicationApiService.postRequest(baseUrl: 'student/update-student-record-without-image', data: data);
      return genericModel.data;
    }
    catch(error) {
      log('updateStudentRecordV2WithoutImage >>> ');
      log(error.toString());

      return null;
    }
  }

  FutureOr<int?> updateStudentRecordV2WithImage(int teacherId, StudentModel student, List<XFile>? profileImage) async{
    try{
      ApplicationApiService applicationApiService = ApplicationApiService();

      var formData = FormData.fromMap({
        "profileImage": await MultipartFile.fromFile(profileImage![0].path, filename: profileImage[0].name),
        "studentId": student.id,
        "age": student.age,
        "studentFirstname": student.firstName,
        "studentLastname": student.lastName
      });

      applicationApiService.postRequestWithImage(baseUrl: 'student/update-student-record-with-image', data: formData);

      return 1;
    }
    catch(error) {
      log("Errror ----- updateStudentRecordV2");
      log(error.toString());

      return -1;
    }
  }
}
