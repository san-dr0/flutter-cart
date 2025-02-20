import 'package:hive_flutter/hive_flutter.dart';
part 'auth_model.g.dart';

@HiveType(typeId: 2)
class AuthEntity extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;

  AuthEntity({required this.name, required this.email});
}
