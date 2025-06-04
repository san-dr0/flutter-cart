class TeacherModel {
  int? id;
  int? courseId;
  String fname;
  String lname;
  int age;

  TeacherModel({
    this.id, this.courseId, required this.fname, required this.lname, required this.age
  });

  factory TeacherModel.fromJson(Map<String, dynamic> teacherJson) {
    return TeacherModel(
      id: teacherJson['id'],
      courseId: teacherJson['courseId'],
      fname: teacherJson['fname'],
      lname: teacherJson['lname'],
      age: teacherJson['age']
    );
  }
}
