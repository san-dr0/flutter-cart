class AuthCredentialsModel {
  String firstName;
  String middleName;
  String lastName;
  String email;
  String password;

  AuthCredentialsModel({required this.firstName, required this.middleName, required this.lastName, required this.email, required this.password});

  factory AuthCredentialsModel.fromJson(AuthCredentialsModel json) {
    return AuthCredentialsModel(
      firstName: json.firstName, 
      middleName: json.middleName,
      lastName: json.lastName,
      email: json.email,
      password: json.password,
    );
  }
}
