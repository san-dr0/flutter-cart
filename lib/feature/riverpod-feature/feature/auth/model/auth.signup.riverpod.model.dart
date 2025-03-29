import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part "auth.signup.riverpod.model.g.dart";

@HiveType(typeId: 8)
class AuthSignupRiverpodModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  final String firstname;
  @HiveField(2)
  final String lastname;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String password;

  AuthSignupRiverpodModel({
    required this.id,
    required this.firstname, required this.lastname, required this.email, required this.password
  });
}
