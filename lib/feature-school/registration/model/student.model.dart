class StudentModel {
  int? id;
  String firstName;
  String lastName;
  int age;
  int? teacherId;

  StudentModel({
    this.id, this.teacherId,
    required this.firstName, required this.lastName, required this.age,
  });

  factory StudentModel.fromJson(Map<String, dynamic> studentJson) {
    return StudentModel(
      id: studentJson['id'] ?? 0,
      firstName: studentJson['fname'], 
      lastName: studentJson['lname'], 
      age: studentJson['age'],
      teacherId: studentJson["teacher_id"]
    );
  }
}
