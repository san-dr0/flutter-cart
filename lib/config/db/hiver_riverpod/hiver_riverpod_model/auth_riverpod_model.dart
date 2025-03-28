import 'package:hive/hive.dart';
part "auth_riverpod_model.g.dart";

@HiveType(typeId: 7)
class AuthRiverpodModel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String password;

  AuthRiverpodModel({
    required this.email, required this.firstName, required this.lastName, required this.password
  });
}
