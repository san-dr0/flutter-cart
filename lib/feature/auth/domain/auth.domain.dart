class AuthCredentialsModel {
  String name;
  String email;

  AuthCredentialsModel({required this.name, required this.email});

  factory AuthCredentialsModel.fromJson(Map<String, dynamic> json) {
    return AuthCredentialsModel(name: json['name'], email: json['email']);
  }
}
