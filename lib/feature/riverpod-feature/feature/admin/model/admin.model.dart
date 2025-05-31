class AdminModel {
  String firstName;
  String lastName;
  String middleName;
  String email;
  String password;

  AdminModel({
    required this.firstName, required this.lastName, required this.middleName, required this.email, required this.password
  });
} // used for registration

class AdminSignin {
  String email;
  String password;

  AdminSignin({required this.email, required this.password});
} // used for signin

class AdminCredentials {
  String id;
  String firstName;
  String lastName;
  String middleName;
  String email;
  String password;

  AdminCredentials({ required this.id,
    required this.firstName, required this.lastName, required this.middleName, required this.email, required this.password
  });
}
