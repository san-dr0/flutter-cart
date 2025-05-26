class SupaUserModel {
  String firstname;
  String lastname;
  String email;
  String password;

  SupaUserModel({
    required this.firstname, required this.lastname, required this.email, required this.password
  });
} // used for creation

class SupaUserModelRetrieve {
  String id;
  String firstname;
  String lastname;
  String email;
  String password;

  SupaUserModelRetrieve({
    required this.id, required this.firstname, required this.lastname, required this.email, required this.password
  });

  factory SupaUserModelRetrieve.fromJson(Map<String, dynamic> json) {
    return SupaUserModelRetrieve(
      id: json["id"]?.toString() ?? '',
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? ''
    );
  }
} // used for retrieval

class SupaLoginUser {
  String email;
  String password;

  SupaLoginUser({required this.email, required this.password});
} // used for login
