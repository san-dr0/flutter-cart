class UserListModel {
  int id;
  String email;
  String password;
  String userType;
  String firstname;
  String lastname;

  UserListModel({
    required this.id, required this.email, required this.password, required this.firstname, required this.lastname, required this.userType,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      id: json['id'] ?? '', 
      email: json['email'] ?? '', 
      password: json['password'] ?? '', 
      firstname: json['firstname'] ?? '', 
      lastname: json['lastname'] ?? '', 
      userType: json['user_type'] ?? ''
    );
  }
}
