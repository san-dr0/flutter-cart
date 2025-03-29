import 'package:hive/hive.dart';
part "auth.signup.riverpod.model.g.dart";

@HiveType(typeId: 8)
class AuthSignupRiverpodModel {
  @HiveField(0)
  final String firstname;
  @HiveField(1)
  final String lastname;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;

  AuthSignupRiverpodModel({
    required this.firstname, required this.lastname, required this.email, required this.password
  });
}
