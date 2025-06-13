class SchoolAuthModel {
  int? id;
  String firstName;
  String lastName;
  int? courseId;

  SchoolAuthModel({
    this.id, required this.firstName, required this.lastName, this.courseId
  });

  factory SchoolAuthModel.fromJson(Map<String, dynamic> schoolAuth) {
    return SchoolAuthModel(
      firstName: schoolAuth['firstName'],
      lastName: schoolAuth['lastName'],
      id: schoolAuth['id'],
      courseId: schoolAuth['courseId']
    );
  }
}
