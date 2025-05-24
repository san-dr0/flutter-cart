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
} // used for retrieval
