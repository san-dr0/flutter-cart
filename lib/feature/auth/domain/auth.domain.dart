class AuthCredentialsModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;

  AuthCredentialsModel({required this.firstName, required this.middleName, required this.lastName, required this.email});

  factory AuthCredentialsModel.fromJson(AuthCredentialsModel json) {
    return AuthCredentialsModel(
      firstName: json.firstName, 
      middleName: json.middleName,
      lastName: json.lastName,
      email: json.email
    );
  }
}
