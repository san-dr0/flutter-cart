class SchoolStudentModel {
  int id;
  int teacherId;
  String fname;
  String lname;
  int age;

  SchoolStudentModel({
    required this.id, required this.teacherId, required this.fname, required this.lname, required this.age
  });

  factory SchoolStudentModel.fromJson (Map<String, dynamic> studentModel) {
    return SchoolStudentModel(
      id: studentModel['id'], 
      teacherId: studentModel['teacherId'], 
      fname: studentModel['fname'], 
      lname: studentModel['lname'], 
      age: studentModel['age']
    );
  }
}
