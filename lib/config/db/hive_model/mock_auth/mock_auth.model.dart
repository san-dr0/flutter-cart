import 'package:hive/hive.dart';
part 'mock_auth.model.g.dart';

@HiveType(typeId: 4)
class UserInfoModel {
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
  @HiveField(5)
  String userType;

  UserInfoModel({
    required this.email, required this.firstName, required this.middleName, required this.lastName,
    required this.password, required this.userType
  });
}