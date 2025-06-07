class StudentModel {
  int? id;
  String firstname;
  String lastname;
  int age;
  int? teacherId;

  StudentModel({
    this.id, this.teacherId,
    required this.firstname, required this.lastname, required this.age,
  });

  factory StudentModel.fromJson(Map<String, dynamic> studentJson) {
    return StudentModel(
      id: studentJson['id'] ?? 0,
      firstname: studentJson['fname'], 
      lastname: studentJson['lname'], 
      age: studentJson['age'],
      teacherId: studentJson["teacher_id"]
    );
  }
}
