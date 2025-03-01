import 'package:hive/hive.dart';
part 'mock_auth.g.dart';

@HiveType(typeId: 4)
class MockAuthModel {
  @HiveField(0)
  String email;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String middleName;
  @HiveField(3)
  String lastName;
  @HiveField(4)
  String password;

  MockAuthModel({
    required this.email, required this.firstName, required this.middleName, required this.lastName,
    required this.password
  });
}