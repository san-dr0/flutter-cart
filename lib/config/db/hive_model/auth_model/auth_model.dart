import 'package:hive_flutter/hive_flutter.dart';

import '../mock_auth/mock_auth.model.dart';

@HiveType(typeId: 2)
class AuthEntity extends HiveObject {
  @HiveField(0)
  String email;
  @HiveField(1)
  MockAuthModel authModel;

  AuthEntity({required this.email, required this.authModel});
}

