class TeacherModel {
  int? id;
  int? courseId;
  String fname;
  String lname;
  int? age;

  TeacherModel({
    this.id, this.courseId, required this.fname, required this.lname, this.age
  });

  factory TeacherModel.fromJson(Map<String, dynamic> teacherJson) {
    return TeacherModel(
      id: teacherJson['id'],
      courseId: teacherJson['courseId'],
      fname: teacherJson['firstName'] ?? '',
      lname: teacherJson['lastName'] ?? '',
      age: teacherJson['age']
    );
  }
}
